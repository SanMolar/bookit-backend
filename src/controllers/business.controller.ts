import { Request, Response } from "express";
import { startABusiness } from "../services/business.service.js";

export const createBusinessController = async (req: Request, res: Response) => {
    const { name, slug, timezone } = req.body;

    const valBusiness = await startABusiness(name, slug, timezone);
    res.status(201).json({message: "Created", business: valBusiness});
};
