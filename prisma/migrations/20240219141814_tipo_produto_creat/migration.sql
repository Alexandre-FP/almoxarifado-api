-- CreateTable
CREATE TABLE "tipoProduto" (
    "id" SERIAL NOT NULL,
    "nome" VARCHAR(45) NOT NULL,
    "descricao" VARCHAR(128),
    "criadoEm" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "alteradoEm" TIMESTAMP(3),
    "situacao" "SituacaoEnum" NOT NULL DEFAULT 'ATIVO',

    CONSTRAINT "tipoProduto_pkey" PRIMARY KEY ("id")
);
