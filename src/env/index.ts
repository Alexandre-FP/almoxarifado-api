import 'dotenv'
import { z } from 'zod'

const envSchema = z.object({
  JWT_TOKEN: z.string(),
  PORT_DEV: z.coerce.number().default(3333), // coerce -> não interessa qual tipo eu vou receber ele vai converter
})

const _env = envSchema.safeParse(process.env)

if (_env.success === false) {
  console.error('👀 Invalid environment variables!', _env.error.format())

  throw new Error('Invalid environment variables!')
} 

export const env = _env.data