import { TipoProdutoController } from './controller'
import { Router } from 'express' 


const tipoProjeto = new TipoProdutoController()
const routes = Router()

routes.post("/criar-tipoproduto", tipoProjeto.criaTipoProduto)
routes.get("/listar-tipoproduto", tipoProjeto.listarTipoProduto)

export default routes