-- ========================================
-- Organization Table
-- ========================================
CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,
    org_name VARCHAR(150) NOT NULL,
	org_description TEXT NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    logo_filename VARCHAR(255) NOT NULL
);

-- ========================================
-- Insert sample data: Organizations
-- ========================================
INSERT INTO organization (org_name, org_description, contact_email, logo_filename)
VALUES
    ('BrightFuture Builders', 'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
    ('GreenHarvest Growers', 'An urban farming collective promoting food sustainability and education in local neighborhoods.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
    ('UnityServe Volunteers', 'A volunteer coordination group supporting local charities and service initiatives.', 'hello@unityserve.org', 'unityserve-logo.png');

-- ========================================

-- Create table: service_project

-- ========================================

CREATE TABLE service_project (

    project_id SERIAL PRIMARY KEY,

    organization_id INTEGER REFERENCES organization(organization_id) NOT NULL,

    title VARCHAR(200) NOT NULL,

    description TEXT NOT NULL,

    location VARCHAR(200) NOT NULL,

project_date DATE NOT NULL

);

-- ========================================
-- Insert sample data: Service Projects
-- ========================================
INSERT INTO service_project (organization_id, title, description, location, project_date)
VALUES
    -- BrightFuture Builders (organization_id = 1)
    (1, 'Community Center Roof Repair', 'Repairing and reinforcing the roof of the downtown community center to prevent water damage.', 'Rexburg, ID', '2026-03-14'),
    (1, 'Playground Construction', 'Building a new accessible playground for the Riverside neighborhood park.', 'Rexburg, ID', '2026-04-02'),
    (1, 'Wheelchair Ramp Installation', 'Installing wheelchair ramps for elderly residents in low-income housing.', 'Idaho Falls, ID', '2026-05-10'),
    (1, 'School Classroom Renovation', 'Renovating three classrooms at a local elementary school damaged by flooding.', 'Rexburg, ID', '2026-06-01'),
    (1, 'Emergency Shelter Expansion', 'Expanding the capacity of the local emergency shelter ahead of winter.', 'Idaho Falls, ID', '2026-09-15'),

    -- GreenHarvest Growers (organization_id = 2)
    (2, 'Urban Garden Startup', 'Establishing a new community garden plot in an underused city lot.', 'Boise, ID', '2026-03-20'),
    (2, 'Composting Workshop Series', 'Hosting a series of workshops teaching households how to compost food waste.', 'Boise, ID', '2026-04-18'),
    (2, 'School Garden Program', 'Planting and maintaining vegetable gardens at three elementary schools.', 'Nampa, ID', '2026-05-05'),
    (2, 'Farmers Market Support', 'Coordinating a weekly farmers market to support local small growers.', 'Boise, ID', '2026-06-12'),
    (2, 'Food Bank Produce Donation Drive', 'Organizing volunteers to grow and donate fresh produce to local food banks.', 'Nampa, ID', '2026-07-30'),

    -- UnityServe Volunteers (organization_id = 3)
    (3, 'Winter Coat Drive', 'Collecting and distributing winter coats to families in need.', 'Twin Falls, ID', '2026-01-15'),
    (3, 'Senior Center Visitation Program', 'Organizing regular volunteer visits to reduce isolation among seniors.', 'Twin Falls, ID', '2026-02-20'),
    (3, 'River Cleanup Day', 'Coordinating volunteers to clean up litter along the Snake River trail.', 'Twin Falls, ID', '2026-04-22'),
    (3, 'Literacy Tutoring Program', 'Pairing volunteer tutors with adults working to improve reading skills.', 'Jerome, ID', '2026-05-18'),
    (3, 'Holiday Meal Packing Event', 'Organizing volunteers to pack and deliver holiday meals to families in need.', 'Twin Falls, ID', '2026-11-20');

-- ========================================
-- Create table: category
-- ========================================
CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- ========================================
-- Create table: project_category
-- ========================================
CREATE TABLE project_category (
    project_id INTEGER REFERENCES service_project(project_id) NOT NULL,
    category_id INTEGER REFERENCES category(category_id) NOT NULL,
    PRIMARY KEY (project_id, category_id)
);

-- ========================================
-- Insert sample data: Categories
-- ========================================
INSERT INTO category (category_name)
VALUES
    ('Construction & Infrastructure'),
    ('Environmental Sustainability'),
    ('Community Outreach');

-- ========================================
-- Insert sample data: Project Categories
-- ========================================
INSERT INTO project_category (project_id, category_id)
VALUES
    -- BrightFuture Builders projects (mostly construction, some overlap with outreach)
    (1, 1),                 -- Community Center Roof Repair -> Construction & Infrastructure
    (2, 1),                 -- Playground Construction -> Construction & Infrastructure
    (2, 3),                 -- Playground Construction -> also Community Outreach
    (3, 1),                 -- Wheelchair Ramp Installation -> Construction & Infrastructure
    (3, 3),                 -- Wheelchair Ramp Installation -> also Community Outreach
    (4, 1),                 -- School Classroom Renovation -> Construction & Infrastructure
    (5, 1),                 -- Emergency Shelter Expansion -> Construction & Infrastructure
    (5, 3),                 -- Emergency Shelter Expansion -> also Community Outreach

    -- GreenHarvest Growers projects (environmental, some overlap with outreach)
    (6, 2),                 -- Urban Garden Startup -> Environmental Sustainability
    (7, 2),                 -- Composting Workshop Series -> Environmental Sustainability
    (7, 3),                 -- Composting Workshop Series -> also Community Outreach
    (8, 2),                 -- School Garden Program -> Environmental Sustainability
    (8, 3),                 -- School Garden Program -> also Community Outreach
    (9, 2),                 -- Farmers Market Support -> Environmental Sustainability
    (10, 2),                -- Food Bank Produce Donation Drive -> Environmental Sustainability
    (10, 3),                -- Food Bank Produce Donation Drive -> also Community Outreach

    -- UnityServe Volunteers projects (community outreach, some overlap)
    (11, 3),                -- Winter Coat Drive -> Community Outreach
    (12, 3),                -- Senior Center Visitation Program -> Community Outreach
    (13, 3),                -- River Cleanup Day -> Community Outreach
    (13, 2),                -- River Cleanup Day -> also Environmental Sustainability
    (14, 3),                -- Literacy Tutoring Program -> Community Outreach
    (15, 3);                -- Holiday Meal Packing Event -> Community Outreach

-- ========================================
-- Creating table for roles
-- ========================================
CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) UNIQUE NOT NULL,
    role_description TEXT
);
-- ========================================
-- Inserting data to roles table
-- ========================================
INSERT INTO roles (role_name, role_description) VALUES
    ('user', 'Standard user with basic access'),
    ('admin', 'Administrator with full system access');
-- ========================================
-- Creating table users
-- ========================================
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role_id INTEGER REFERENCES roles(role_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- ========================================
-- Inserting data to users table
-- ========================================
-- ========================================
-- Create table: project_volunteer
-- ========================================
CREATE TABLE project_volunteer (
    project_id INTEGER REFERENCES service_project(project_id) NOT NULL,
    user_id INTEGER REFERENCES users(user_id) NOT NULL,
    PRIMARY KEY (project_id, user_id)
);