/*
  Warnings:

  - You are about to drop the column `estaLogado` on the `usuarios` table. All the data in the column will be lost.
  - You are about to drop the column `matricula` on the `usuarios` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "usuarios" DROP COLUMN "estaLogado",
DROP COLUMN "matricula";
