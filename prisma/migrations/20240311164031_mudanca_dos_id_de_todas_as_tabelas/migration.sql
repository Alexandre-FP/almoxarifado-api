/*
  Warnings:

  - The primary key for the `departamentos` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `permissoes` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `produtos` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `secretarias` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `status` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `tiposProdutos` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `usuarios` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- DropForeignKey
ALTER TABLE "departamentos" DROP CONSTRAINT "departamentos_secretariaId_fkey";

-- DropForeignKey
ALTER TABLE "produtos" DROP CONSTRAINT "produtos_statusId_fkey";

-- DropForeignKey
ALTER TABLE "produtos" DROP CONSTRAINT "produtos_tipoProdutoId_fkey";

-- DropForeignKey
ALTER TABLE "produtos" DROP CONSTRAINT "produtos_usuarioId_fkey";

-- DropForeignKey
ALTER TABLE "usuarios" DROP CONSTRAINT "usuarios_departamentoId_fkey";

-- DropForeignKey
ALTER TABLE "usuarios" DROP CONSTRAINT "usuarios_permissaoId_fkey";

-- AlterTable
ALTER TABLE "departamentos" DROP CONSTRAINT "departamentos_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "secretariaId" SET DATA TYPE TEXT,
ADD CONSTRAINT "departamentos_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "departamentos_id_seq";

-- AlterTable
ALTER TABLE "permissoes" DROP CONSTRAINT "permissoes_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "permissoes_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "permissoes_id_seq";

-- AlterTable
ALTER TABLE "produtos" DROP CONSTRAINT "produtos_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "statusId" SET DATA TYPE TEXT,
ALTER COLUMN "tipoProdutoId" SET DATA TYPE TEXT,
ALTER COLUMN "usuarioId" SET DATA TYPE TEXT,
ADD CONSTRAINT "produtos_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "produtos_id_seq";

-- AlterTable
ALTER TABLE "secretarias" DROP CONSTRAINT "secretarias_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "secretarias_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "secretarias_id_seq";

-- AlterTable
ALTER TABLE "status" DROP CONSTRAINT "status_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "status_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "status_id_seq";

-- AlterTable
ALTER TABLE "tiposProdutos" DROP CONSTRAINT "tiposProdutos_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "tiposProdutos_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "tiposProdutos_id_seq";

-- AlterTable
ALTER TABLE "usuarios" DROP CONSTRAINT "usuarios_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "departamentoId" SET DATA TYPE TEXT,
ALTER COLUMN "permissaoId" SET DATA TYPE TEXT,
ADD CONSTRAINT "usuarios_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "usuarios_id_seq";

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
