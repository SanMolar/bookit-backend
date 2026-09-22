import { pool } from "../config/database.js";

export const findBusinessBySlug = async (slug: string) => {
  const result = await pool.query("SELECT * FROM businesses WHERE slug = $1", [
    slug,
  ]);

  return result.rows[0];
};

export const createBusiness = async (name: string, slug: string, timezone: string) => {

    const result = await pool.query(
        "INSERT INTO businesses (name, slug, timezone) VALUES ($1, $2, $3) RETURNING *",
        [name, slug, timezone]
    )

    return result.rows[0]
}
