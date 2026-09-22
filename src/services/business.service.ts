import {
  createBusiness,
  findBusinessBySlug,
} from "../repositories/business.repository.js";

export const startABusiness = async (
  name: string,
  slug: string,
  timezone: string,
) => {
  const result = await findBusinessBySlug(slug);

  if (!result) {
    return createBusiness(name, slug, timezone);
  } else {
    throw new Error("No puedo continuar porque el slug ya existe");
  }
};
