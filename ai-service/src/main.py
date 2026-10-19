# Servicio IA minimo de AulaViva.
# Sirve para probar el contenedor, Kubernetes y el pipeline.
# Despues se reemplaza por el servicio real (tutor IA con RAG).

import json
import os
import signal
import sys
from http.server import BaseHTTPRequestHandler, HTTPServer

# La configuracion viene de variables de entorno (no se escribe en el codigo)
PUERTO = int(os.environ.get("PORT", "8080"))


class Manejador(BaseHTTPRequestHandler):
    def _responder(self, codigo, datos):
        cuerpo = json.dumps(datos).encode("utf-8")
        self.send_response(codigo)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(cuerpo)))
        self.end_headers()
        self.wfile.write(cuerpo)

    def do_GET(self):
        # /health: dice si el programa esta vivo
        if self.path == "/health":
            self._responder(200, {"status": "ok"})
        # /ready: dice si esta listo para recibir preguntas
        elif self.path == "/ready":
            self._responder(200, {"ready": True})
        else:
            self._responder(404, {"title": "No encontrado", "status": 404})

    # Los mensajes salen por la salida normal (factor 11 del 12-factor)
    def log_message(self, formato, *args):
        print(json.dumps({"msg": formato % args}), flush=True)


def apagar(*_):
    # Cuando Kubernetes pide apagar, salimos con calma (factor 9)
    print(json.dumps({"msg": "Apagando servicio IA"}), flush=True)
    sys.exit(0)


if __name__ == "__main__":
    signal.signal(signal.SIGTERM, apagar)
    print(json.dumps({"msg": "Servicio IA encendido", "port": PUERTO}), flush=True)
    HTTPServer(("0.0.0.0", PUERTO), Manejador).serve_forever()
