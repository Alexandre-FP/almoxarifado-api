/*
  Warnings:

  - Added the required column `usuario_id` to the `produtos` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "produtos" ADD COLUMN     "usuario_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "produtos" ADD CONSTRAINT "produtos_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "usuarios"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
