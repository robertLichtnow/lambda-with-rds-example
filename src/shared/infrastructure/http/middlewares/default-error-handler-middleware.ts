import { NextFunction, Request, Response } from 'express';
import { StatusCodes } from 'http-status-codes';

export class DefaultErrorHandlerMiddleware {
  public static create() {
    return (
      error: Error,
      _request: Request,
      response: Response,
      _next: NextFunction
    ): Response => {
      // eslint-disable-next-line no-console
      console.error(error);

      return response.status(StatusCodes.INTERNAL_SERVER_ERROR).json({
        status: 'error',
        message: 'Internal server error',
        error: {
          name: error.name,
          stack: error.stack,
          message: error.message,  
        },
        environment: process.env,
      });
    };
  }
}