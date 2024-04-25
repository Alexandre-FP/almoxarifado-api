import {  Request ,Response } from "express";
import { prisma } from "../../database/prisma";
import { z } from "zod";
import { verify } from "jsonwebtoken";
import { env } from "../../env";
import { JwtPayload } from "../../@types/jwt-pay-load";

export class EtapaController {
  async criarEtapa(req: Request, res: Response){
    const tokenRequest = req.headers.authorization
    const [, tokenEncriptado] = tokenRequest!.split(" ")
    
    const token = verify(tokenEncriptado, env.JWT_TOKEN) as JwtPayload

    const bodyParse = z.object({
      descricao: z.string(),
    })

    const { params } = req

    const { descricao } = bodyParse.parse(req.body)

    await prisma.etapa.create({
      data: {
        descricao,
        produtoId: String(params.idprojeto),
        usuarioId: token.user.id
      }
    })

    return res.status(201).send()
  }
}


/*

descricao
produto  
produtoId
usuario  
usuarioId
*/