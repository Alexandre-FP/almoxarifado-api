/*
  Warnings:

  - Added the required column `permissao_Id` to the `usuarios` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "usuarios" ADD COLUMN     "permissao_Id" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "permissao" (
    "id" SERIAL NOT NULL,
    "nome" VARCHAR(45) NOT NULL,
    "descricao" VARCHAR(128),
    "criadoEm" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "alteradoEm" TIMESTAMP(3),
    "situacao" "SituacaoEnum" NOT NULL DEFAULT 'ATIVO',

    CONSTRAINT "permissao_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "usuarios" ADD CONSTRAINT "usuarios_permissao_Id_fkey" FOREIGN KEY ("permissao_Id") REFERENCES "permissao"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
