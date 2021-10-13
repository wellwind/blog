import * as connect from 'connect';
import * as serveStatic from 'serve-static';
import { join } from 'path';

const distFolder = join(process.cwd(), 'dist/blog/browser');
connect()
  .use(serveStatic(distFolder))
  .listen(4200, () => console.log('Server running on 4200...'));
