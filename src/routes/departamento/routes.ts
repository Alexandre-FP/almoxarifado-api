import { DepartamentoController } from "./controller";
import { Router } from "express";

const routes = Router()
const departamentoController = new DepartamentoController()

routes.post("/criar-departamento", departamentoController.criaDepartamento)
routes.get("/listar-departamentos", departamentoController.listarDepartamento)

export default routes 