import db from './db.js'

const getAllCategories = async () => {
    const query = `
        SELECT category_id, category_name
        FROM public.category;
    `;

    const result = await db.query(query);

    return result.rows;
}

const getCategoryDetails = async (categoryId) => {
    const query = `
        SELECT category_id, category_name
        FROM category
        WHERE category_id = $1;
    `;

    const queryParams = [categoryId];
    const result = await db.query(query, queryParams);

    return result.rows.length > 0 ? result.rows[0] : null;
};

const getProjectsByCategoryId = async (categoryId) => {
    const query = `
        SELECT
            service_project.project_id,
            service_project.title
        FROM service_project
        JOIN project_category ON service_project.project_id = project_category.project_id
        WHERE project_category.category_id = $1;
    `;

    const queryParams = [categoryId];
    const result = await db.query(query, queryParams);

    return result.rows;
};

const getCategoriesByProjectId = async (projectId) => {
    const query = `
        SELECT
            category.category_id,
            category.category_name
        FROM category
        JOIN project_category ON category.category_id = project_category.category_id
        WHERE project_category.project_id = $1;
    `;

    const queryParams = [projectId];
    const result = await db.query(query, queryParams);

    return result.rows;
};

export { getAllCategories, getCategoryDetails, getProjectsByCategoryId, getCategoriesByProjectId };