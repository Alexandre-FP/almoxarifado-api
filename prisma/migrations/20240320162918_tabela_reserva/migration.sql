-- AlterTable
ALTER TABLE "produtos" ADD COLUMN     "reservado" TEXT NOT NULL DEFAULT 'Disponivel';

-- CreateTable
CREATE TABLE "reserva" (
    "id" TEXT NOT NULL,
    "statusReserva" TEXT NOT NULL DEFAULT 'Ativo',
    "produtoId" TEXT NOT NULL,
    "usuarioId" TEXT NOT NULL,
    "criadoEm" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "alteradoEm" TIMESTAMP(3),

    CONSTRAINT "reserva_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "reserva" ADD CONSTRAINT "reserva_produtoId_fkey" FOREIGN KEY ("produtoId") REFERENCES "produtos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reserva" ADD CONSTRAINT "reserva_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES "usuarios"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
