-- CreateEnum
CREATE TYPE "SituacaoEnum" AS ENUM ('ATIVO', 'INATIVO', 'EXCLUIDO');

-- CreateTable
CREATE TABLE "usuario" (
    "id" SERIAL NOT NULL,
    "nome" VARCHAR(45) NOT NULL,
    "email" VARCHAR(45) NOT NULL,
    "senha" TEXT NOT NULL,
    "telefone" VARCHAR(32) NOT NULL,
    "matricula" INTEGER NOT NULL,
    "responsavelSecretaria" BOOLEAN NOT NULL DEFAULT false,
    "criadoEm" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "alteradoEm" TIMESTAMP(3),
    "situacao" "SituacaoEnum" NOT NULL DEFAULT 'ATIVO',
    "estaLogado" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "usuario_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "usuario_email_key" ON "usuario"("email");

-- CreateIndex
CREATE UNIQUE INDEX "usuario_matricula_key" ON "usuario"("matricula");
