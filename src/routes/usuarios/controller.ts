import { prisma } from "../../database/prisma";
import bcrypt from "bcryptjs";
import { Request, Response } from "express";
import { AppError } from "../../utils/AppError";
import { z } from "zod";

class UsuarioController {
  async cadastraUsuario(req: Request, res: Response) {
    const bodyParse = z.object({
      nome: z.string(),
      email: z.string().email(),
      senha: z.string(),
      telefone: z.string(),
      permissaoId: z.string(),
      departamentoId: z.string()
    })

    const { nome, email, senha, telefone, permissaoId, departamentoId } = bodyParse.parse(req.body)

    const emailExiste = await prisma.usuario.findFirst({
      where: {
        email
      }
    });

    if (emailExiste) {
      throw new AppError("Esse email já esta em uso");
    }

    const senhaEncriptografada = await bcrypt.hash(senha, 8);

    await prisma.usuario.create({
      data: {
        nome,
        email,
        senha: senhaEncriptografada,
        telefone,
        permissaoId,
        departamentoId,
      },
    });

    return res.status(201).json();
  }

  async listarTodosUsuarios(req: Request, res: Response){
    const listarTodosUsuarios = await prisma.usuario.findMany({})  

    return res.status(201).json({ content: listarTodosUsuarios })
  }
}

export default UsuarioController;
