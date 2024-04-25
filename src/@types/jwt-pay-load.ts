export interface JwtPayload {
  user:{
    id: string;
    nome: string;
    email: string;
    senha: string;
    telefone: string;
    criadoEm: Date;
    alteradoEm: Date | null;
    permissaoId: string;
    departamentoId: string;
    departamento: {
      nome: string
    }
  }
}