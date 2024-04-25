/*
  Warnings:

  - You are about to drop the column `secretariaId` on the `departamentos` table. All the data in the column will be lost.
  - Added the required column `secretaria_Id` to the `departamentos` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "departamentos" DROP CONSTRAINT "departamentos_secretariaId_fkey";

-- AlterTable
ALTER TABLE "departamentos" DROP COLUMN "secretariaId",
ADD COLUMN     "secretaria_Id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "departamentos" ADD CONSTRAINT "departamentos_secretaria_Id_fkey" FOREIGN KEY ("secretaria_Id") REFERENCES "secretarias"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
