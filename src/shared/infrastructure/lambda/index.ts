import { Handler } from 'aws-lambda';
import { createServer, proxy } from 'aws-serverless-express';
import { server } from '~/shared/infrastructure/http/server';

const lambdaEventHandler = createServer(server);

export const handler: Handler = (event, context) => {
  context.callbackWaitsForEmptyEventLoop = false;

  proxy(lambdaEventHandler, event, context);
};
