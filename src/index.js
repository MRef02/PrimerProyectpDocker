import http from 'node:http';
import os from 'node:os';

const PORT = process.env.PORT || 3000;

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'application/json; charset=utf-8' });
  res.end(
    JSON.stringify(
      {
        mensaje: '¡Hola Mundo desde Node.js! 🚀',
        version: process.version,
        host: os.hostname(),
        timestamp: new Date().toISOString()
      },
      null,
      2
    )
  );
});

server.listen(PORT, () => {
  console.log(`✅ Servidor corriendo en http://localhost:${PORT}`);
});