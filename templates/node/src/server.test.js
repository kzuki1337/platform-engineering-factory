import assert from "node:assert/strict";
import { once } from "node:events";
import test from "node:test";
import { createApp } from "./server.js";

test("serves a health check", async (context) => {
  const server = createApp();
  server.listen(0, "127.0.0.1");
  await once(server, "listening");
  context.after(() => server.close());

  const response = await fetch(`http://127.0.0.1:${server.address().port}/healthz`);
  assert.equal(response.status, 200);
  assert.equal(await response.text(), "ok\n");
});
