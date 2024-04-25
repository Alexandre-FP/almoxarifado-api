/*
  Warnings:

  - You are about to drop the column `reservado` on the `produtos` table. All the data in the column will be lost.
  - You are about to drop the column `statusReserva` on the `reserva` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "produtos" DROP COLUMN "reservado",
ALTER COLUMN "situacao" SET DEFAULT 'INATIVO';

-- AlterTable
ALTER TABLE "reserva" DROP COLUMN "statusReserva",
ADD COLUMN     "situacao" "SituacaoEnum" NOT NULL DEFAULT 'ATIVO';
