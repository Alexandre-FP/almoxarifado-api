/*
  Warnings:

  - You are about to drop the column `tipoProduto_id` on the `produtos` table. All the data in the column will be lost.
  - Added the required column `tipoProduto_Id` to the `produtos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `usuario_Id` to the `produtos` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "produtos" DROP CONSTRAINT "produtos_tipoProduto_id_fkey";

-- AlterTable
ALTER TABLE "produtos" DROP COLUMN "tipoProduto_id",
ADD COLUMN     "tipoProduto_Id" INTEGER NOT NULL,
ADD COLUMN     "usuario_Id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "produtos" ADD CONSTRAINT "produtos_tipoProduto_Id_fkey" FOREIGN KEY ("tipoProduto_Id") REFERENCES "tiposProdutos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "produtos" ADD CONSTRAINT "produtos_usuario_Id_fkey" FOREIGN KEY ("usuario_Id") REFERENCES "usuarios"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
