import { getAllCategories, getCategoryDetails, getProjectsByCategoryId, getCategoriesByProjectId, updateCategoryAssignments } from '../models/categories.js';
import { getProjectDetails } from '../models/projects.js';
const showCategoriesPage =  async (req, res) => {
    const categories = await getAllCategories();

    const title = 'Categories';
    res.render('categories', { title, categories });
};

const showCategoryDetailsPage = async (req, res) => {
    const categoryId = req.params.id;
    const categoryDetails = await getCategoryDetails(categoryId);
    const projects = await getProjectsByCategoryId(categoryId);
    const title = 'Category Details';

    res.render('category', {title, categoryDetails, projects})

};

const showAssignCategoriesForm = async (req, res) => {
    const projectId = req.params.projectId;

    const projectDetails = await getProjectDetails(projectId);
    const allCategories = await getAllCategories();
    const assignedCategories = await getCategoriesByProjectId(projectId);

    const title = 'Assign Categories to Project';

    res.render('assign-categories', { title, projectDetails, allCategories, assignedCategories });
};

const processAssignCategoriesForm = async (req, res) => {
    const projectId = req.params.projectId;

    let categoryIds = req.body.categoryIds || [];
    if (!Array.isArray(categoryIds)) {
        categoryIds = [categoryIds];
    }

    if (categoryIds.length === 0) {
        req.flash('error', 'Please select at least one category.');
        return res.redirect(`/assign-categories/${projectId}`);
    }

    await updateCategoryAssignments(projectId, categoryIds);

    req.flash('success', 'Categories updated successfully!');
    res.redirect(`/project/${projectId}`);
};

export { showCategoriesPage, showCategoryDetailsPage, showAssignCategoriesForm, processAssignCategoriesForm };
