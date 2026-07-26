const testErrorPage = async (req, res) => {
    const categories = await getAllCategories();

    const title = 'Categories';
    res.render('categories', { title, categories });
};

export { testErrorPage };
