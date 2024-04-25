import { app } from "./app"
import { env } from "./env" 

app.listen({ 
    port: env.PORT_DEV }, () => console.log(`Servidor rodando na porta ${ env.PORT_DEV }`)) 