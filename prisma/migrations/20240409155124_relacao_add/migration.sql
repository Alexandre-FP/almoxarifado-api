-- AlterTable
ALTER TABLE "produtos" ADD COLUMN     "usuarioMandarProduto_id" TEXT;

-- AddForeignKey
ALTER TABLE "produtos" ADD CONSTRAINT "produtos_usuarioMandarProduto_id_fkey" FOREIGN KEY ("usuarioMandarProduto_id") REFERENCES "usuarios"("id") ON DELETE SET NULL ON UPDATE CASCADE;
