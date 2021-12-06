import { Response } from "express";
import { StatusCodes } from "http-status-codes";
import { injectable } from "inversify";
import { Get, JsonController, Res } from "routing-controllers";
import { getConnection, getConnectionOptions } from "typeorm";

@injectable()
@JsonController()
export class RunMigrationsController {

  @Get('/deploy/run-migrations')
  public async runMigrations(@Res() response: Response): Promise<Response> {
    const migrations = await getConnection().runMigrations({
      transaction: 'none',
    });

    console.log({ config: await getConnectionOptions() });

    return response.status(StatusCodes.OK).send();
  }
}