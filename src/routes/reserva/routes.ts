import { ReservaController } from "./controller";
import { Router } from "express"
import { AcessoRotas } from "../../middlewares/AcessoRotas";

const reserva = new ReservaController()
const router = Router()

router.post("/criar-reserva/:produtoId", AcessoRotas, reserva.criarRerva)
router.get("/listar-reserva/:produtoId", AcessoRotas, reserva.listarReserva)
router.get("/chekar-reserva", reserva.chekarReserva)

export default router
  