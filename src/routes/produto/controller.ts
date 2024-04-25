import { prisma } from "../../database/prisma";
import { randomUUID } from "node:crypto";
import { Request, Response } from "express";
import { AppError } from "../../utils/AppError";
import { z } from "zod";
import { permissao } from "../../utils/permissao";
import { verify } from "jsonwebtoken";
import { env } from "../../env";
import { JwtPayload } from "../../@types/jwt-pay-load";

export class ProdutoController {
  async criaProduto(req: Request, res: Response) {
    const tokenRequest = req.headers.authorization;
    const [, tokenEncriptado] = tokenRequest!.split(" ");

    const token = verify(tokenEncriptado, env.JWT_TOKEN) as JwtPayload; 
    console.log("token:", token.user.departamento.nome) 

    const bodyParse = z.object({
      nome: z.string(),
      descricao: z.string(),
      tipoProdutoId: z.string().uuid(),
      numeroPatrimonio: z.string(),
      usuarioMandarProduto_id: z.string().uuid().optional(),
      ordemCompra: z.string().optional()
    });

    const {
      nome,
      descricao,
      tipoProdutoId,
      numeroPatrimonio,
      usuarioMandarProduto_id,
      ordemCompra 
    } = bodyParse.parse(req.body); 

    const imagem = req.file!.path;
    
    
    const produtoCriado = await prisma.produto.create({
      data: {
        nome,
        descricao, 
        numeroSerie: randomUUID(), 
        localOndeEncontra: `Departamento - ${token.user.departamento.nome}` ,
        imagem,
        tipoProdutoId, 
        numeroPatrimonio, 
        usuarioId: token.user.id,
        usuarioMandarProduto_id,
        ordemCompra,
      },
    });

    await prisma.etapa.create({
      data: {
        descricao: "Produto aberto para reserva",
        produtoId: produtoCriado.id,
        usuarioId: token.user.id        
      }
    })
    
    return res.status(201).json();
  }

  async listarProdutoPorPermissao(req: Request, res: Response) {
    const tokenRequest = req.headers.authorization;
    const [, tokenEncriptado] = tokenRequest!.split(" ");

    const token = verify(tokenEncriptado, env.JWT_TOKEN) as JwtPayload;

    let result: any[] | null = null;

    console.log(token.user.permissaoId)

    switch (token.user.permissaoId) {
      case permissao.usuarioComun:
        result = await prisma.produto.findMany({
          include: {
            tipoProduto: {
              select: {
                nome: true,
                descricao: true,
              },
            },
            usuario: {
              select: {
                nome: true,
              },
            },
          },
          where: {
            OR: [
              {
                usuarioMandarProduto_id: token.user.id
              }, 
              {
                situacao: "ATIVO",
              },
              {
                usuarioId: token.user.id
              }
          ],
        },
        });
        break;
      case permissao.admin:
        result = await prisma.produto.findMany({
          include: {
            tipoProduto: {
              select: {
                nome: true,
                descricao: true,
              },
            },
            usuario: {
              select: {
                nome: true,
              },
            },
            usuarioMandarProduto: {
              select: {
                nome: true
              }
            }
          },
        });
        break;
      default: {
        result = [];
      }
    }

    const produtosComImagens = result.map((produto) => {
      const caminhoCompleto = produto.imagem;
      const partesCaminho = caminhoCompleto!.split("\\");
      const nomeArquivo = partesCaminho[partesCaminho.length - 1];
      return {
        ...produto,
        imagem: `http://10.1.0.187:3000/api/file/${nomeArquivo}`,
      };
    });

    return res.status(200).json({ content: produtosComImagens });
  }

  async listarProduto(req: Request, res: Response){
    const listarProduto = await prisma.produto.findMany({
      include: {
        tipoProduto: {
          select: {
            nome: true,
            descricao: true,
          },
        },
        usuario: {
          select: {
            nome: true,
          },
        },
      },
      where: {
        situacao: "ATIVO"
      }
    });

    const produtosComImagens = listarProduto.map((produto) => {
      const caminhoCompleto = produto.imagem;
      const partesCaminho = caminhoCompleto!.split("\\");
      const nomeArquivo = partesCaminho[partesCaminho.length - 1];
      return {
        ...produto,
        imagem: `http://10.1.0.187:3000/api/file/${nomeArquivo}`,
      };
    });

    return res.status(200).json({ content: produtosComImagens });
  } 

  async listarProdutoUnico(req: Request, res: Response) {
    const { params } = req;

    const result = await prisma.produto.findUnique({
      where: {
        id: String(params.id),
      },
      include: {
        tipoProduto: {
          select: {
            nome: true,
            descricao: true,
          },
        },
        usuario: {
          select: {
            nome: true,
          },
        },
        etapa: {
          include: {
            usuario: { 
              select: {
                nome: true
              }
            }
          },
          orderBy: {
            criadoEm: "desc"
          }
        }
      },
    });

    if (!result) {
      throw new AppError("Produto não encontrado");
    }

    const caminhoCompleto = result?.imagem;
    const partesCaminho = caminhoCompleto!.split("\\");
    const nomeArquivo = partesCaminho[partesCaminho.length - 1];
    const caminho = {
      ...result,
      imagem: `http://10.1.0.187:3000/api/file/${nomeArquivo}`,
    };

    return res.status(200).json({ content: caminho });
  }

  async atualizarProdutoPorId(req: Request, res: Response) {
    const { params } = req
    const tokenRequest = req.headers.authorization;
    const [, tokenEncriptado] = tokenRequest!.split(" ");

    const token = verify(tokenEncriptado, env.JWT_TOKEN) as JwtPayload;  

    const bodyParse = z.object({
      nome: z.string(),
      descricao: z.string(),
      localOndeEncontra: z.string(),
      tipoProdutoId: z.string().uuid(),
      numeroPatrimonio: z.string(),
      produtoConcluido: z.boolean()
    });

    const {
      nome,
      descricao,
      localOndeEncontra,
      tipoProdutoId,
      numeroPatrimonio,
      produtoConcluido
    } = bodyParse.parse(req.body); 

    const projetoCriadoAntes = await prisma.produto.findUnique({
      where: { id: String(params.id) }
    }) 

    const result = await prisma.produto.update({
      where: {
        id: String(params.id) 
      }, 
      data: { 
        nome,
        descricao,
        numeroSerie: randomUUID(), 
        localOndeEncontra,
        imagem: projetoCriadoAntes?.imagem,
        tipoProdutoId,
        numeroPatrimonio,
        usuarioId: projetoCriadoAntes?.usuarioId, 
        produtoConcluido,
      }, 
    });

    return res.status(201).send(result);
  }

  async atualizarProdutoSituacao(req: Request, res: Response){
    const { params } = req

    const bodyParse = z.object({
      situacao: z.enum(["ATIVO", "INATIVO"])
    })

    const { situacao } = bodyParse.parse(req.body)

    await prisma.produto.update({
      where: {
        id: String(params.id)
      },
      data: {
        situacao,
      }
    })

    return res.status(200).send()
  }
}
