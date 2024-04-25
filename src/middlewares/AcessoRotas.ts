import { Request, Response, NextFunction } from "express"; 
import { AppError } from "../utils/AppError"; 
import jwt from "jsonwebtoken"
import { env } from "../env"; 

export const AcessoRotas = (req: Request, res: Response, next: NextFunction) => {
  const authHeader = req.headers.authorization

  if(!authHeader){
    throw new AppError('JWT token não informado')
  }

  const [, bearerToken] = authHeader.split(" ")
  try{
    jwt.verify(bearerToken, env.JWT_TOKEN)
    return next()
  }catch{
    throw new AppError('token de usuário invalido')
  }
}