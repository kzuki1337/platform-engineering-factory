import { createServer } from "node:http";
import { resolve } from "node:path";
import { pathToFileURL } from "node:url";

export function createApp() {
  return createServer((request, response) => {
    if (request.url === "/healthz") {
      response.writeHead(200, { "content-type": "text/plain" });
      response.end("ok\n");
      return;
    }

    response.writeHead(200, { "content-type": "application/json" });
    response.end(JSON.stringify({ message: "Hello from the platform starter" }));
  });
}

if (process.argv[1] && import.meta.url === pathToFileURL(resolve(process.argv[1])).href) {
  const port = Number(process.env.PORT ?? 8080);
  createApp().listen(port, "0.0.0.0");
}
