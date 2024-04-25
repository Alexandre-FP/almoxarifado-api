import { z } from "zod";
import { prisma } from "../../database/prisma"; 
import { Request, Response } from "express";

export class DepartamentoController {
  async criaDepartamento(req: Request, res: Response){
    const bodyParse = z.object({
      nome: z.string(),
      secretariaId: z.string().uuid()
    })

    const { nome, secretariaId } = bodyParse.parse(req.body)

    await prisma.departamento.create({
      data: {
        nome,
        secretariaId
      }
    })

    return res.status(201).json()
  }

  async listarDepartamento(req: Request, res: Response){
    const listarDepartamento = await prisma.departamento.findMany()

    return res.status(200).json({ content: listarDepartamento })
  }
}


