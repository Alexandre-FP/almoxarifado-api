/*
  Warnings:

  - You are about to drop the `reserva` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "SituacaoDaReserva" AS ENUM ('DISPONIVEL', 'RESERVADO');

-- DropForeignKey
ALTER TABLE "reserva" DROP CONSTRAINT "reserva_produtoId_fkey";

-- DropForeignKey
ALTER TABLE "reserva" DROP CONSTRAINT "reserva_usuarioId_fkey";

-- AlterTable
ALTER TABLE "produtos" ADD COLUMN     "concluido" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "situacaoDeReserva" "SituacaoDaReserva" NOT NULL DEFAULT 'DISPONIVEL';

-- DropTable
DROP TABLE "reserva";

-- CreateTable
CREATE TABLE "etapas" (
    "id" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,
    "produtoId" TEXT NOT NULL,
    "usuarioId" TEXT NOT NULL,
    "criadoEm" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "alteradoEm" TIMESTAMP(3),

    CONSTRAINT "etapas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "reservas" (
    "id" TEXT NOT NULL,
    "situacaoDeReserva" "SituacaoDaReserva" NOT NULL DEFAULT 'RESERVADO',
    "situacao" "SituacaoEnum" NOT NULL DEFAULT 'ATIVO',
    "produtoId" TEXT NOT NULL,
    "usuarioId" TEXT NOT NULL,
    "criadoEm" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "alteradoEm" TIMESTAMP(3),

    CONSTRAINT "reservas_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "etapas" ADD CONSTRAINT "etapas_produtoId_fkey" FOREIGN KEY ("produtoId") REFERENCES "produtos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "etapas" ADD CONSTRAINT "etapas_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES "usuarios"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reservas" ADD CONSTRAINT "reservas_produtoId_fkey" FOREIGN KEY ("produtoId") REFERENCES "produtos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reservas" ADD CONSTRAINT "reservas_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES "usuarios"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
