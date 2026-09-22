import { pool } from "../config/database.js";

export async function searchBusinessBySlug(slug: string) {
    const result = await pool.query(
        "SELECT * FROM businesses WHERE SLUG = $1", [slug]
    )

   const x  = result.rows[0] ?? null 

    return x;
}