-- CreateTable
CREATE TABLE "produto" (
    "id" SERIAL NOT NULL,
    "nome" VARCHAR(60) NOT NULL,
    "descricao" VARCHAR(300),
    "numeroPatrimonio" INTEGER,
    "localOndeEncontra" VARCHAR(60),
    "numeroSerie" INTEGER NOT NULL,
    "reservado" BOOLEAN NOT NULL DEFAULT false,
    "criadoEm" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "alteradoEm" TIMESTAMP(3),
    "status_Id" INTEGER NOT NULL,

    CONSTRAINT "produto_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "produto" ADD CONSTRAINT "produto_status_Id_fkey" FOREIGN KEY ("status_Id") REFERENCES "status"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
