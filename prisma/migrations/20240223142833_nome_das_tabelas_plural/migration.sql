/*
  Warnings:

  - You are about to drop the `permissao` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `produto` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tipoProduto` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "produto" DROP CONSTRAINT "produto_status_Id_fkey";

-- DropForeignKey
ALTER TABLE "produto" DROP CONSTRAINT "produto_tipoProduto_id_fkey";

-- DropForeignKey
ALTER TABLE "usuarios" DROP CONSTRAINT "usuarios_permissao_Id_fkey";

-- DropTable
DROP TABLE "permissao";

-- DropTable
DROP TABLE "produto";

-- DropTable
DROP TABLE "tipoProduto";

-- CreateTable
CREATE TABLE "permissoes" (
    "id" SERIAL NOT NULL,
    "nome" VARCHAR(45) NOT NULL,
    "descricao" VARCHAR(128),
    "criadoEm" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "alteradoEm" TIMESTAMP(3),
    "situacao" "SituacaoEnum" NOT NULL DEFAULT 'ATIVO',

    CONSTRAINT "permissoes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tiposProdutos" (
    "id" SERIAL NOT NULL,
    "nome" VARCHAR(45) NOT NULL,
    "descricao" VARCHAR(128),
    "criadoEm" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "alteradoEm" TIMESTAMP(3),
    "situacao" "SituacaoEnum" NOT NULL DEFAULT 'ATIVO',

    CONSTRAINT "tiposProdutos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "produtos" (
    "id" SERIAL NOT NULL,
    "nome" VARCHAR(60) NOT NULL,
    "descricao" VARCHAR(300),
    "numeroPatrimonio" INTEGER NOT NULL,
    "localOndeEncontra" VARCHAR(60),
    "numeroSerie" INTEGER,
    "situacao" "SituacaoEnum" NOT NULL DEFAULT 'ATIVO',
    "criadoEm" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "alteradoEm" TIMESTAMP(3),
    "status_Id" INTEGER NOT NULL,
    "tipoProduto_id" INTEGER NOT NULL,

    CONSTRAINT "produtos_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "usuarios" ADD CONSTRAINT "usuarios_permissao_Id_fkey" FOREIGN KEY ("permissao_Id") REFERENCES "permissoes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "produtos" ADD CONSTRAINT "produtos_status_Id_fkey" FOREIGN KEY ("status_Id") REFERENCES "status"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "produtos" ADD CONSTRAINT "produtos_tipoProduto_id_fkey" FOREIGN KEY ("tipoProduto_id") REFERENCES "tiposProdutos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
