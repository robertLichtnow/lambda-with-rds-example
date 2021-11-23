import express, { json } from 'express';
import { StatusCodes } from 'http-status-codes';

const server = express();
server.use(json());

server.get('/', (_, res) => res.sendStatus(StatusCodes.OK));

server.listen(3000, () => {
  console.log('Listening on port 3000');
});
