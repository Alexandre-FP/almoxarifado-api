/*
  Warnings:

  - You are about to drop the column `responsavelSecretaria` on the `usuarios` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX "usuarios_matricula_key";

-- AlterTable
ALTER TABLE "usuarios" DROP COLUMN "responsavelSecretaria";
