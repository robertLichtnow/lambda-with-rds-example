import { Response } from 'express';
import { StatusCodes } from 'http-status-codes';
import { injectable } from 'inversify';
import { Get, JsonController, Res } from 'routing-controllers';

@injectable()
@JsonController()
export class HealthController {
  @Get('/health')
  public health(@Res() response: Response): Response {
    return response.status(StatusCodes.OK).send({ health: 'OK' });
  }
}