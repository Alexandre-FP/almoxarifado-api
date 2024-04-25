/*
  Warnings:

  - You are about to drop the `usuario` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE "usuario";

-- CreateTable
CREATE TABLE "usuarios" (
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

    CONSTRAINT "usuarios_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "usuarios_email_key" ON "usuarios"("email");

-- CreateIndex
CREATE UNIQUE INDEX "usuarios_matricula_key" ON "usuarios"("matricula");
