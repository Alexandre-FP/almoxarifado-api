import { fileURLToPath } from 'url';
import { dirname, resolve } from 'path';
import multer from 'multer';
import crypto from "node:crypto";

const __filename = fileURLToPath(import.meta.url); 
const __dirname = dirname(__filename)

export const TMP_FOLDER = resolve(__dirname, "..", "..", "tmp");
export const UPLOADS_FOLDER = resolve(TMP_FOLDER, "uploads");

export const Multer = {
  directory: UPLOADS_FOLDER,
  storage: multer.diskStorage({
    destination: UPLOADS_FOLDER,
    filename(req, file, callback){
      const fileHash = crypto.randomBytes(10).toString("hex");
      const fileName = `${fileHash}-${file.originalname}`
      console.log(fileName)

      return callback(null, fileName);
    }
  })
}