/*
  Warnings:

  - You are about to drop the column `secretaria_Id` on the `departamentos` table. All the data in the column will be lost.
  - You are about to drop the column `status_Id` on the `produtos` table. All the data in the column will be lost.
  - You are about to drop the column `tipoProduto_Id` on the `produtos` table. All the data in the column will be lost.
  - You are about to drop the column `usuario_Id` on the `produtos` table. All the data in the column will be lost.
  - You are about to drop the column `departamento_Id` on the `usuarios` table. All the data in the column will be lost.
  - You are about to drop the column `permissao_Id` on the `usuarios` table. All the data in the column will be lost.
  - Added the required column `secretariaId` to the `departamentos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `statusId` to the `produtos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tipoProdutoId` to the `produtos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `usuarioId` to the `produtos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `departamentoId` to the `usuarios` table without a default value. This is not possible if the table is not empty.
  - Added the required column `permissaoId` to the `usuarios` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "departamentos" DROP CONSTRAINT "departamentos_secretaria_Id_fkey";

-- DropForeignKey
ALTER TABLE "produtos" DROP CONSTRAINT "produtos_status_Id_fkey";

-- DropForeignKey
ALTER TABLE "produtos" DROP CONSTRAINT "produtos_tipoProduto_Id_fkey";

-- DropForeignKey
ALTER TABLE "produtos" DROP CONSTRAINT "produtos_usuario_Id_fkey";

-- DropForeignKey
ALTER TABLE "usuarios" DROP CONSTRAINT "usuarios_departamento_Id_fkey";

-- DropForeignKey
ALTER TABLE "usuarios" DROP CONSTRAINT "usuarios_permissao_Id_fkey";

-- AlterTable
ALTER TABLE "departamentos" DROP COLUMN "secretaria_Id",
ADD COLUMN     "secretariaId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "produtos" DROP COLUMN "status_Id",
DROP COLUMN "tipoProduto_Id",
DROP COLUMN "usuario_Id",
ADD COLUMN     "statusId" INTEGER NOT NULL,
ADD COLUMN     "tipoProdutoId" INTEGER NOT NULL,
ADD COLUMN     "usuarioId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "usuarios" DROP COLUMN "departamento_Id",
DROP COLUMN "permissao_Id",
ADD COLUMN     "departamentoId" INTEGER NOT NULL,
ADD COLUMN     "permissaoId" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "usuarios" ADD CONSTRAINT "usuarios_permissaoId_fkey" FOREIGN KEY ("permissaoId") REFERENCES "permissoes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "usuarios" ADD CONSTRAINT "usuarios_departamentoId_fkey" FOREIGN KEY ("departamentoId") REFERENCES "departamentos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "departamentos" ADD CONSTRAINT "departamentos_secretariaId_fkey" FOREIGN KEY ("secretariaId") REFERENCES "secretarias"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "produtos" ADD CONSTRAINT "produtos_statusId_fkey" FOREIGN KEY ("statusId") REFERENCES "status"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "produtos" ADD CONSTRAINT "produtos_tipoProdutoId_fkey" FOREIGN KEY ("tipoProdutoId") REFERENCES "tiposProdutos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "produtos" ADD CONSTRAINT "produtos_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES "usuarios"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
