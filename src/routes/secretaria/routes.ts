import { SecretariaController } from "./controller.js";
import { Router } from "express";

const routes = Router()
const secretariaController = new SecretariaController()

routes.post("/criar-secretaria", secretariaController.criaSecretaria)
routes.get("/listar-secretaria/:id", secretariaController.listarSecretariaPorId)
routes.get("/listar-secretarias", secretariaController.listarSecretaria)
routes.put("/atualizar-secretaria/:id", secretariaController.atualizarSecretaria)
 
export default routes