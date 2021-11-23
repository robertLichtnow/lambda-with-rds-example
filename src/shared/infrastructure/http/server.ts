import express, { json } from 'express';
import cors from 'cors';
import { useContainer, useExpressServer } from 'routing-controllers';
import { diContainer } from '~/di-container';

const server = express();

server.use(cors());
server.use(json());

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
