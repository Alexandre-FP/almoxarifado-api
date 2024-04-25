/*
  Warnings:

  - You are about to drop the `secretaria` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `departamento_Id` to the `usuarios` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "usuarios" ADD COLUMN     "departamento_Id" INTEGER NOT NULL;

-- DropTable
DROP TABLE "secretaria";

-- CreateTable
CREATE TABLE "secretarias" (
    "id" SERIAL NOT NULL,
    "nome" VARCHAR(128) NOT NULL,
    "sigla" VARCHAR(16) NOT NULL,
    "criadoEm" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "alteradoEm" TIMESTAMP(3),
    "situacao" "SituacaoEnum" NOT NULL DEFAULT 'ATIVO',

    CONSTRAINT "secretarias_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "departamentos" (
    "id" SERIAL NOT NULL,
    "nome" VARCHAR(45) NOT NULL,
    "maxDias" INTEGER NOT NULL,
    "criadoEm" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "alteradoEm" TIMESTAMP(3),
    "situacao" "SituacaoEnum" NOT NULL DEFAULT 'ATIVO',
    "secretariaId" INTEGER NOT NULL,

    CONSTRAINT "departamentos_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "usuarios" ADD CONSTRAINT "usuarios_departamento_Id_fkey" FOREIGN KEY ("departamento_Id") REFERENCES "departamentos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "departamentos" ADD CONSTRAINT "departamentos_secretariaId_fkey" FOREIGN KEY ("secretariaId") REFERENCES "secretarias"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
