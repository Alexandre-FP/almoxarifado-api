import { prisma } from "../../database/prisma";
import { compare } from "bcryptjs";
import { Request, Response, request } from "express";
import { z } from "zod";
import { AppError } from "../../utils/AppError";
import { sign } from "jsonwebtoken"
import { env } from "../../env"; 
import _ from "lodash";

class AutenticacaoController {
  async login(req: Request, res: Response) {
    const bodyParse = z.object({
      email: z.string(),
      senha: z.string(),
    }); 

    const { email, senha } = bodyParse.parse(req.body);

    const emailExiste = await prisma.usuario.findFirst({
      where: {
        email,
      },
      include: {
        departamento: {
          select: {
            nome: true
          }
        }
      }
    });

    if (!emailExiste) { 
      throw new AppError("email ou senhas invalidas");
    }

    const senhaEncriptografada = await compare(senha, emailExiste.senha);

    if (!senhaEncriptografada) {
      throw new AppError("email ou senhas invalidas");
    }

    const token = sign({ user: emailExiste }, env.JWT_TOKEN, {
      subject: String(emailExiste),
      expiresIn: 60 * 60 * 24 * 7 // 7 dias -> 60 * 60 * 24 * 7 | 1H -> 3600
    })

    return res.status(200).json({ token, session: _.omit(emailExiste, "senha") }); 
  }
}

export default AutenticacaoController;
