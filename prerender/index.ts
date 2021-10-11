import * as puppeteer from 'puppeteer';
import * as fs from 'fs';

const url = process.argv.slice(2).length > 0 ? process.argv.slice(2)[0] : 'http://localhost:4200';

const miniArgs = [
  '--autoplay-policy=user-gesture-required',
  '--disable-background-networking',
  '--disable-background-timer-throttling',
  '--disable-backgrounding-occluded-windows',
  '--disable-breakpad',
  '--disable-client-side-phishing-detection',
  '--disable-component-update',
  '--disable-default-apps',
  '--disable-dev-shm-usage',
  '--disable-domain-reliability',
  '--disable-extensions',
  '--disable-features=AudioServiceOutOfProcess',
  '--disable-hang-monitor',
  '--disable-ipc-flooding-protection',
  '--disable-notifications',
  '--disable-offer-store-unmasked-wallet-cards',
  '--disable-popup-blocking',
  '--disable-print-preview',
  '--disable-prompt-on-repost',
  '--disable-renderer-backgrounding',
  '--disable-setuid-sandbox',
  '--disable-speech-api',
  '--disable-sync',
  '--hide-scrollbars',
  '--ignore-gpu-blacklist',
  '--metrics-recording-only',
  '--mute-audio',
  '--no-default-browser-check',
  '--no-first-run',
  '--no-pings',
  '--no-sandbox',
  '--no-zygote',
  '--password-store=basic',
  '--use-gl=swiftshader',
  '--use-mock-keychain',
];

(async () => {
  const start = new Date().getTime();
  const browser = await puppeteer.launch({
    headless: true,
    args: miniArgs,
    userDataDir: './dist/cache'
  });
  const page = await browser.newPage();

  for(let i = 0; i< 1000; ++i) {
    const targetUrl = `${url}/blog/${i}`
    console.log(`Crawl: ${targetUrl}`);
    await page.goto(targetUrl, {
      waitUntil: 'networkidle2',
    });
    await page.evaluate(() => {
      (window as any)['PRERENDER_MODE'] = true;
    });
    const content = await page.content();
    // fs.writeFileSync(`./dist/page-${i}.html`, content);
  }
  await browser.close();

  const end = new Date().getTime();
  console.log(`Time: ${(end - start) / 1000}`)
})();
