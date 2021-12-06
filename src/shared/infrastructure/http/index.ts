import 'reflect-metadata';
import '~/index';

import { createConnections, getConnectionOptions } from 'typeorm';
import { server } from '~/shared/infrastructure/http/server';
import { PORT } from '~/shared/infrastructure/settings/environment';

createConnections();
server.listen(PORT, () => {
  console.log(`Server listening at port ${PORT}`);
});
