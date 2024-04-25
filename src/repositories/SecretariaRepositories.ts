import { prisma } from "../database/prisma";

export class SecretariaRepositories {
  async criar(nome: string, sigla: string){
    const criarSecretaria = await prisma.secretaria.create({
      data: {
        nome, 
        sigla
      }
    })

    return criarSecretaria
  }

  async secretariaPorId(id: string){
    const secretariaPorId = await prisma.secretaria.findUnique({
      where: {
        id: String(id)
      }
    })

    return secretariaPorId
  }

  async listarSecretaria(){
    const listarSecretaria = await prisma.secretaria.findMany()

    return listarSecretaria
  }

  async atualizarSecretaria(nome: string, sigla: string, id: string){
    const atualizarSecretaria = await prisma.secretaria.update({
      where: {
        id: String(id)
      },
      data: {
        nome,
        sigla
      }
    })

    return atualizarSecretaria

  }
}