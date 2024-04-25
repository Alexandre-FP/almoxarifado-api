import fs from "fs";
import { TMP_FOLDER, UPLOADS_FOLDER } from "../config/uploads.js";
import { resolve } from "path";

class DiskStorage{
  async saveFile(file: any){
    await fs.promises.rename(
      resolve(TMP_FOLDER, file),
      resolve(UPLOADS_FOLDER, file)
    )
 
    return file
  }

  async deleteFile(file: any){
    const filePath = resolve(UPLOADS_FOLDER, file);

    try{
      await fs.promises.stat(filePath) 
    }catch{
      return;
    }

    await fs.promises.unlink(filePath); 
  }
}

export default DiskStorage;