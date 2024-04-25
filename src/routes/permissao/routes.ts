import { PermissaoController } from "./controller";
import { Router } from "express";

const routes = Router()
const permissaoController = new PermissaoController()

routes.post("/criar-permissao", permissaoController.criaPermissao)
routes.get("/listar-permissao", permissaoController.listarPermissao)

export default routes