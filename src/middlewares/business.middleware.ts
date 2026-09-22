import { Request, Response, NextFunction } from "express";

export const validatingInput = (req: Request, res: Response, next: NextFunction) => {
  const { name, slug, timezone } = req.body;

  if (!name || !slug || !timezone) {
    return res.status(400).json({
      message: "Todos los campos son obligatorios",
    });
  }

  if (
    typeof name !== "string" ||
    typeof slug !== "string" ||
    typeof timezone !== "string"
  ) {
    return res.status(400).json({
      message: "Los campos deben ser de tipo cadena",
    });
  }

  if (name.trim() === "" || slug.trim() === "" || timezone.trim() === "") {
    return res.status(400).json({
      message: "Los campos no pueden estar vacíos",
    });
  }
  next();
};
