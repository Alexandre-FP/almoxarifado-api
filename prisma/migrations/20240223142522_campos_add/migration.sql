/*
  Warnings:

  - You are about to drop the column `reservado` on the `produto` table. All the data in the column will be lost.
  - Added the required column `tipoProduto_id` to the `produto` table without a default value. This is not possible if the table is not empty.
  - Made the column `numeroPatrimonio` on table `produto` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "produto" DROP COLUMN "reservado",
ADD COLUMN     "situacao" "SituacaoEnum" NOT NULL DEFAULT 'ATIVO',
ADD COLUMN     "tipoProduto_id" INTEGER NOT NULL,
ALTER COLUMN "numeroPatrimonio" SET NOT NULL,
ALTER COLUMN "numeroSerie" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "produto" ADD CONSTRAINT "produto_tipoProduto_id_fkey" FOREIGN KEY ("tipoProduto_id") REFERENCES "tipoProduto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
