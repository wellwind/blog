import * as connect from 'connect';
import * as serveStatic from 'serve-static';
import { join } from 'path';

const distFolder = join(process.cwd(), 'src');
connect()
  .use(serveStatic(distFolder))
  .listen(4201, () => console.log('Server running on 4201...'));
