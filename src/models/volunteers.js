import db from './db.js'

const addVolunteer = async (projectId, userId) => {
    const query = `
        INSERT INTO project_volunteer (project_id, user_id)
        VALUES ($1, $2);
    `;

    await db.query(query, [projectId, userId]);
};

const removeVolunteer = async (projectId, userId) => {
    const query = `
        DELETE FROM project_volunteer
        WHERE project_id = $1 AND user_id = $2;
    `;

    await db.query(query, [projectId, userId]);
};

const getVolunteeredProjectsByUserId = async (userId) => {
    const query = `
        SELECT
            service_project.project_id,
            service_project.title,
            service_project.project_date,
            service_project.location
        FROM service_project
        JOIN project_volunteer ON service_project.project_id = project_volunteer.project_id
        WHERE project_volunteer.user_id = $1;
    `;

    const queryParams = [userId];
    const result = await db.query(query, queryParams);

    return result.rows;
};

const isUserVolunteered = async (projectId, userId) => {
    const query = `
        SELECT 1
        FROM project_volunteer
        WHERE project_id = $1 AND user_id = $2;
    `;

    const queryParams = [projectId, userId];
    const result = await db.query(query, queryParams);

    return result.rows.length > 0;
};

export { addVolunteer, removeVolunteer, getVolunteeredProjectsByUserId, isUserVolunteered };