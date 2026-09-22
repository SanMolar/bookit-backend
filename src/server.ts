import "dotenv/config";
import { app } from "./app.js";

import { pool } from "./config/database.js";

const port = Number(process.env.PORT) || 3000;

async function startServer() {
  try {
    const result = await pool.query("SELECT NOW() AS current_time");
    console.log("Base de datos conectada:", result.rows[0].current_time);
    app.listen(port, () => {
      console.log(`BookIt API ejecutándose en http://localhost:${port}`);
    });
  } catch (error) {
    console.error("No se pudo iniciar BookIt:", error);
    process.exitCode = 1;
  }
}

startServer();