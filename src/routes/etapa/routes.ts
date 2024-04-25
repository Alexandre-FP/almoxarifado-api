import { EtapaController } from "./controller";
import { Router } from "express";
import { AcessoRotas } from "../../middlewares/AcessoRotas";

const etapaController = new EtapaController()
const routes = Router()

routes.post("/criar-etapa/:idprojeto", AcessoRotas, etapaController.criarEtapa)

export default routes