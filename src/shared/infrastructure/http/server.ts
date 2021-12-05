import express, { json } from 'express';
import cors from 'cors';
import { useContainer, useExpressServer } from 'routing-controllers';
import { diContainer } from '~/di-container';
import { TypeormConnectionAliveMiddleware } from '~/shared/infrastructure/http/middlewares/typeorm-connection-alive-middleware';
import { DefaultErrorHandlerMiddleware } from '~/shared/infrastructure/http/middlewares/default-error-handler-middleware';

const server = express();

server.use(cors());
server.use(json());

server.use(DefaultErrorHandlerMiddleware.create());
server.use(TypeormConnectionAliveMiddleware.create());

useContainer(diContainer);

useExpressServer(server, {
  routePrefix: '/api',
  validation: true,
  classTransformer: true,
  plainToClassTransformOptions: {
    enableImplicitConversion: false,
  },
  defaultErrorHandler: true,
});


export { server };
