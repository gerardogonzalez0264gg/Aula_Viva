// Pruebas simples del backend: revisan que cada direccion responda bien
const { test } = require("node:test");
const assert = require("node:assert");
const http = require("node:http");
const { crearServidor } = require("../src/server");

// Enciende el servidor, pide una direccion, guarda la respuesta y lo apaga
function pedir(ruta) {
  return new Promise((resolver, rechazar) => {
    const servidor = crearServidor();
    servidor.listen(0, () => {
      const { port } = servidor.address();
      http
        .get({ port, path: ruta, agent: false }, (res) => {
          let texto = "";
          res.on("data", (parte) => (texto += parte));
          res.on("end", () => {
            servidor.close();
            resolver({ codigo: res.statusCode, cuerpo: JSON.parse(texto) });
          });
        })
        .on("error", rechazar);
    });
  });
}

test("/health responde que esta vivo", async () => {
  const r = await pedir("/health");
  assert.strictEqual(r.codigo, 200);
  assert.strictEqual(r.cuerpo.status, "ok");
});

test("/ready responde que esta listo", async () => {
  const r = await pedir("/ready");
  assert.strictEqual(r.codigo, 200);
  assert.strictEqual(r.cuerpo.ready, true);
});

test("una direccion que no existe responde 404", async () => {
  const r = await pedir("/no-existe");
  assert.strictEqual(r.codigo, 404);
  assert.strictEqual(r.cuerpo.title, "No encontrado");
});
