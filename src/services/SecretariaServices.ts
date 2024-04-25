import { SecretariaRepositories } from "../repositories/SecretariaRepositories";
import { AppError } from "../utils/AppError";

export class SecretariaServices {
  constructor(private secretariaRepositories: SecretariaRepositories) {}

  async secretariaId(id: string) {
    const secretariaPorId = await this.secretariaRepositories.secretariaPorId(id);

    if (!secretariaPorId) { 
      throw new AppError("Secretaria não exixste");
    }

    return secretariaPorId;
  }

}
 