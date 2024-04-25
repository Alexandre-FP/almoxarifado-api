-- CreateTable
CREATE TABLE "status" (
    "id" SERIAL NOT NULL,
    "nome" VARCHAR(45) NOT NULL,
    "observacao" VARCHAR(128) NOT NULL,
    "criadoEm" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "alteradoEm" TIMESTAMP(3),
    "situacao" "SituacaoEnum" NOT NULL DEFAULT 'ATIVO',

    CONSTRAINT "status_pkey" PRIMARY KEY ("id")
);
