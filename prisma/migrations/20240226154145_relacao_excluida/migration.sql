/*
  Warnings:

  - You are about to drop the column `usuario_id` on the `produtos` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "produtos" DROP CONSTRAINT "produtos_usuario_id_fkey";

-- AlterTable
ALTER TABLE "produtos" DROP COLUMN "usuario_id";
