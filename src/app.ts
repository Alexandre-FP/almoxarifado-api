import express, { json, urlencoded, Request, Response, NextFunction, Express } from "express"
import morgan from "morgan"
import "express-async-errors" // trabalhar com erros async
import { AppError } from "./utils/AppError" 
import { usuario, permissao, secretaria, departamento, tipoproduto, produto, reserva, etapa } from "./routes/index" 
import { UPLOADS_FOLDER } from "./config/uploads" 
import cors from "cors"

export const app: Express = express()
 
app.use(json())
 
app.use(cors({ 
    origin: "http://10.1.2.134:3000",  
    credentials: true,
})) 

app.use(morgan('dev')) 
app.use(urlencoded({ extended: false })); 

app.use("/api/auth", usuario) 
app.use("/api/", permissao) 
app.use("/api/", secretaria) 
app.use("/api/", departamento) 
app.use("/api/", tipoproduto)
app.use("/api/", produto)
app.use("/api/", reserva)
app.use("/api/", etapa)
app.use("/api/file", express.static(UPLOADS_FOLDER))

app.use((error: Error, req: Request, res: Response, next: NextFunction) => {
    if(error instanceof AppError){
        return res.status(error.statusCode).json({ 
            status: "error", 
            message: error.message
        });
    }  
     
    return res.status(500).json({  
        status: "error",
        message: "Error da Api"
    });
});