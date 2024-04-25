/*
  Warnings:

  - You are about to drop the column `statusId` on the `produtos` table. All the data in the column will be lost.
  - You are about to drop the `status` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "produtos" DROP CONSTRAINT "produtos_statusId_fkey";

-- AlterTable
ALTER TABLE "produtos" DROP COLUMN "statusId";

-- DropTable
DROP TABLE "status";
