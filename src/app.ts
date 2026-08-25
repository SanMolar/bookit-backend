import express, { type Express, type Request, type Response } from "express";
import cors from "cors";

export const app: Express = express();

app.use(cors());
app.use(express.json());

app.get("/api/health", (_req: Request, res: Response) => {
  res.status(200).json({
    message: "BookIt API está funcionando",
  });
});