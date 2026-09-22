import {Router} from "express"
import getHealth from "../controllers/health.controller.js";
import { createBusinessController } from "../controllers/business.controller.js";
import { validationOfCreateProviders } from "../middlewares/validationProviders.controller.js";

const router = Router();

router.get('/health', getHealth);
router.post('/business', validationOfCreateProviders, createBusinessController);

export default router;