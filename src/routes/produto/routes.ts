import { ProdutoController } from "./controller.js";
import { Router } from "express";
import multer from "multer";
import { Multer } from "../../config/uploads.js";
import { AcessoRotas } from "../../middlewares/AcessoRotas.js";

const produtoController = new ProdutoController()
const routes = Router()
const upload = multer(Multer);

routes.post("/criar-produto", AcessoRotas, upload.single("imagem"), produtoController.criaProduto)
routes.put("/atualizar-produto/:id", AcessoRotas, upload.single("imagem"), produtoController.atualizarProdutoPorId)
routes.patch("/atualizar-produto/:id", AcessoRotas, produtoController.atualizarProdutoSituacao)
routes.get("/listar-produtos-permissao", AcessoRotas, produtoController.listarProdutoPorPermissao)
routes.get("/listar-produtos",  produtoController.listarProduto)
routes.get("/listar-produto/:id", produtoController.listarProdutoUnico)

export default routes 