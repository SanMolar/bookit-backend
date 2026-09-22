import { Request, Response, NextFunction } from "express";

export function validationOfCreateProviders(
  req: Request,
  res: Response,
  next: NextFunction,
) {
  const { full_name, job_title } = req.body;

  if (typeof full_name !== "string") {
    return res
      .status(400)
      .json({ message: "El nombre completo debe ser texto" });
  }
  if (typeof job_title !== "string") {
    return res.status(400).json({ message: "El tabajo debe ser texto" });
  }

  if (full_name.trim().length === 0) {
    return res
      .status(400)
      .json({ message: "El nombre completo debe contener letras" });
  }
  if (job_title.trim().length === 0) {
    return res.status(400).json({ message: "Eltrabajo debe contener letras" });
  }

  next();
}
