import 'reflect-metadata';
import '~/index';

import { createConnections, getConnectionOptions } from 'typeorm';
import { server } from '~/shared/infrastructure/http/server';

createConnections();
server.listen(process.env.APP_PORT, () => {
  console.log(`Server listening at port ${process.env.APP_PORT}`);
});
