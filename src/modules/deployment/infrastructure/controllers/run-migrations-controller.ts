import { Response } from "express";
import { StatusCodes } from "http-status-codes";
import { injectable } from "inversify";
import { Get, JsonController, Res } from "routing-controllers";
import { getConnection } from "typeorm";

@injectable()
@JsonController()
export class RunMigrationsController {

  @Get('/deploy/run-migrations')
  public async runMigrations(@Res() response: Response): Promise<Response> {
    await getConnection().runMigrations({
      transaction: 'none',
    });

    return response.status(StatusCodes.OK).send();
  }
}