import { z } from "zod";
import { prisma } from "../../database/prisma"; 
import { Request, Response } from "express";

export class PermissaoController {
  async criaPermissao(req: Request, res: Response){
    const bodyParse = z.object({
      nome: z.string(),
      descricao: z.string(),
    })

    const { nome, descricao } = bodyParse.parse(req.body)

    await prisma.permissao.create({
      data: {
        nome,
        descricao
      }
    })

    return res.status(201).json()
  }

  async listarPermissao(req: Request, res: Response){
    const listarPermissao = await prisma.permissao.findMany()

    return res.status(200).json({ content: listarPermissao })
  }
}


