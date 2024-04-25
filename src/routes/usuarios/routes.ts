import UsuarioController  from "./controller"; 
import AutenticacaoController from "../auth/controller";
import { Router } from "express"; 

const routes = Router()
const usuarioController = new UsuarioController()
const autenticacaoController = new AutenticacaoController()

routes.post('/login', autenticacaoController.login)

routes.post("/criar-usuario", usuarioController.cadastraUsuario)
routes.get("/", usuarioController.listarTodosUsuarios)

export default routes  