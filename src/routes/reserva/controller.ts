import { prisma } from "../../database/prisma";
import { Request, Response } from "express";
import { env } from "../../env";
import { verify } from "jsonwebtoken";
import { AppError } from "../../utils/AppError";

interface JwtPayload {
  user:{
    id: string
    nome: string
    email: string
    senha: string
    telefone: string
    criadoEm: Date
    alteradoEm: Date | null
    permissaoId: string
    departamentoId: string

  }
}

export class ReservaController {
  async criarRerva(req: Request, res: Response){
    const tokenRequest = req.headers.authorization;
    const [, tokenEncriptado] = tokenRequest!.split(" ");

    const token = verify(tokenEncriptado, env.JWT_TOKEN) as JwtPayload; 
    const { params } = req

    await prisma.reserva.create({
      data: {
        produtoId: String(params.produtoId),
        usuarioId: token.user.id
      }
    })
    
    await prisma.produto.update({
      where: {
        id: String(params.produtoId)
      },
      data: {
        situacao: "INATIVO",
        situacaoDeReserva: "RESERVADO"
      }
    })

    return res.status(201).send()
  }

  async listarReserva(req: Request, res: Response){
    const tokenRequest = req.headers.authorization;
    const [, tokenEncriptado] = tokenRequest!.split(" ");
    const { params } = req

    const token = verify(tokenEncriptado, env.JWT_TOKEN) as JwtPayload;

    const listarReserva = await prisma.reserva.findMany({
      select: {
        id: true,
        criadoEm: true,
        produto: {
          select: {
            id: true,
            nome: true,
            numeroPatrimonio: true,
            descricao: true,
          }
        },
        usuario: {
          select: {
            nome: true,
            telefone: true,
            departamento: {
              select: {
                nome: true
              }
            }
          }
        }
      },
      where: {
        usuarioId: token.user.id,
        AND: {
          produtoId: String(params.produtoId)
        }
      }
    });

    return res.status(200).json({ content: listarReserva })
  }

  async chekarReserva(req: Request, res: Response){
    const diasCorridos = new Date()
    diasCorridos.setDate(diasCorridos.getDate() - 1)

    const reservas = await prisma.reserva.findMany({
      where: {
        situacaoDeReserva: 'RESERVADO',
        criadoEm: {
          lte: diasCorridos
        }
      },
      include: {
        produto: true
      }
    })

    for(const reserva of reservas){
      if(reserva.produto.situacaoDeReserva === "RESERVADO"){
        await prisma.reserva.delete({
          where: {
            id: reserva.id
          },
        }) 

        await prisma.produto.update({
          where: {
            id: reserva.produto.id
          },
          data: {
            situacaoDeReserva: "DISPONIVEL"
          }
        })
      }
    }

    return res.status(201).send()
  }
}