import { NextFunction, Request, Response } from 'express';
import { createConnections, getConnection, getConnectionManager } from 'typeorm';

export class TypeormConnectionAliveMiddleware {
  public static create() {
    return async (_request: Request, _response: Response, next: NextFunction): Promise<void> => {
      const connectionManager = getConnectionManager();

      if (connectionManager.has('default')) {
        const connection = getConnection();
        if (!connection.isConnected) {
          await connection.connect();
        }
      } else {
        await createConnections();
      }

      next();
    }
  }
}