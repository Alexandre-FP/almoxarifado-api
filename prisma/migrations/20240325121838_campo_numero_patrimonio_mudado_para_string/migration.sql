/*
  Warnings:

  - A unique constraint covering the columns `[numeroPatrimonio]` on the table `produtos` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "produtos" ALTER COLUMN "numeroPatrimonio" SET DATA TYPE VARCHAR(60);

-- CreateIndex
CREATE UNIQUE INDEX "produtos_numeroPatrimonio_key" ON "produtos"("numeroPatrimonio");
