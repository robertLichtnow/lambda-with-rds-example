import 'reflect-metadata';
import '~/index';

import { createConnections, getConnection } from 'typeorm';
import { Handler } from 'aws-lambda';
import serverlessExpress from '@vendia/serverless-express';
import { server } from '~/shared/infrastructure/http/server';

const lambdaEventHandler = serverlessExpress({ app: server });

export const handler: Handler = async (event, context, callback) => {
  context.callbackWaitsForEmptyEventLoop = false;

  return lambdaEventHandler(event, context, callback);
};
