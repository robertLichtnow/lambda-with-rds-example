import { NextFunction, Request, Response } from 'express';
import { getConnectionManager } from 'typeorm';

export class TypeormConnectionAliveMiddleware {
  public static create() {
    return async (_request: Request, _response: Response, next: NextFunction): Promise<void> => {
      const connectionManager = getConnectionManager();
      await Promise.all(connectionManager.connections.map(async (connection) => {
        if (!connection.isConnected) {
          await connection.connect();
        }
      }));
    }
  }
}