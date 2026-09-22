import {Request, Response} from "express"

const getHealth = (_req: Request, res: Response) => {
 return res.status(200).json({
   message: "BookIt API está funcionando",})
}

export default getHealth;