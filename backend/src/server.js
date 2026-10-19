// Servidor minimo del backend de AulaViva.
// Sirve para probar el contenedor, Kubernetes y el pipeline.
// Despues se reemplaza por el backend real.

const http = require("node:http");

// Las configuraciones vienen de variables de entorno (no se escriben en el codigo)
const PORT = process.env.PORT || 8080;
const APP_ENV = process.env.APP_ENV || "local";

// Esta funcion decide que responder a cada direccion
function manejarPeticion(req, res) {
  // /health: dice si el programa esta vivo
  if (req.url === "/health") {
    res.writeHead(200, { "Content-Type": "application/json" });
    return res.end(JSON.stringify({ status: "ok" }));
  }

  // /ready: dice si el programa esta listo para recibir gente
  if (req.url === "/ready") {
    res.writeHead(200, { "Content-Type": "application/json" });
    return res.end(JSON.stringify({ ready: true, env: APP_ENV }));
  }

  // Cualquier otra direccion no existe
  res.writeHead(404, { "Content-Type": "application/problem+json" });
  return res.end(
    JSON.stringify({
      type: "about:blank",
      title: "No encontrado",
      status: 404,
      detail: "La direccion pedida no existe",
    })
  );
}

function crearServidor() {
  return http.createServer(manejarPeticion);
}

// Solo se enciende si ejecutamos este archivo directamente
if (require.main === module) {
  const servidor = crearServidor();
  servidor.listen(PORT, () => {
    // Los mensajes salen por la salida normal (factor 11 del 12-factor)
    console.log(JSON.stringify({ msg: "Backend encendido", port: PORT }));
  });

  // Cuando Kubernetes pide apagar, cerramos con calma (factor 9)
  process.on("SIGTERM", () => {
    console.log(JSON.stringify({ msg: "Apagando backend" }));
    servidor.close(() => process.exit(0));
  });
}

module.exports = { crearServidor, manejarPeticion };
