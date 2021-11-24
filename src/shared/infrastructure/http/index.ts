import 'reflect-metadata';
import '~/index';

import { server } from '~/shared/infrastructure/http/server';
import { PORT } from '~/shared/infrastructure/settings/environment';

server.listen(PORT, () => {
  console.log(`Server listening at port ${PORT}`);
});
