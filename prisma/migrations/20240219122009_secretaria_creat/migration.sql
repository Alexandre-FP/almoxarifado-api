-- CreateTable
CREATE TABLE "secretaria" (
    "id" SERIAL NOT NULL,
    "nome" VARCHAR(128) NOT NULL,
    "sigla" VARCHAR(16) NOT NULL,
    "criadoEm" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "alteradoEm" TIMESTAMP(3),
    "situacao" "SituacaoEnum" NOT NULL DEFAULT 'ATIVO',

    CONSTRAINT "secretaria_pkey" PRIMARY KEY ("id")
);
