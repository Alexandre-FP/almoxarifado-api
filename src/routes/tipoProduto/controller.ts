import { prisma } from "../../database/prisma"; 
import { Request, Response } from "express";
import { z } from "zod";

export class TipoProdutoController {
  async criaTipoProduto(req: Request, res: Response){
    const bodyParse = z.object({
      nome: z.string(),
      descricao: z.string()
    })

    const { nome, descricao } = bodyParse.parse(req.body)

    await prisma.tipoProduto.create({
      data: {
        nome,
        descricao
      }
    })

    return res.status(201).send()
  }

  async listarTipoProduto(req: Request, res: Response){
    const listarTipoProduto = await prisma.tipoProduto.findMany()

    return res.status(200).json({ content: listarTipoProduto })
  }
}