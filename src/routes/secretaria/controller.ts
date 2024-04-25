import { SecretariaRepositories } from "../../repositories/SecretariaRepositories";
import { SecretariaServices } from "../../services/SecretariaServices";
import { Request, Response } from "express";
import { z } from "zod"; 

const secretariaRepositories = new SecretariaRepositories()
const secretariaServices = new SecretariaServices(secretariaRepositories)

export class SecretariaController {
  async criaSecretaria(req: Request, res: Response){

    const secretariaParse = z.object({
      nome: z.string(),
      sigla: z.string(),
    })

    const { nome, sigla } = secretariaParse.parse(req.body)

    const criaSecretaria = await secretariaRepositories.criar(nome, sigla)

    return res.status(201).json({ content: criaSecretaria })
  }

  async listarSecretariaPorId(req: Request, res: Response){
    const parseId = z.object({
      id: z.string()
    })

    const { id } = parseId.parse(req.params)

    const listarSecretariaPorId = await secretariaServices.secretariaId(id)

    return res.status(200).json({ content: listarSecretariaPorId })
  }

  async listarSecretaria(req: Request, res: Response){
    const listarSecretaria = await secretariaRepositories.listarSecretaria()

    return res.status(200).json({ content: listarSecretaria })
  }

  async atualizarSecretaria(req: Request, res: Response){
    const parseSecretariaBody = z.object({
      nome: z.string(),
      sigla: z.string(),
    })

    const parseId = z.object({
      id: z.string()
    })

    const { nome, sigla } = parseSecretariaBody.parse(req.body)

    const { id } = parseId.parse(req.params)

    await secretariaServices.secretariaId(id)

    const atualizarSecretaria = await secretariaRepositories.atualizarSecretaria(nome, sigla, id)

    return res.status(201).json({ content: atualizarSecretaria })
  }
}


