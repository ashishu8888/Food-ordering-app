const express = require('express')
const adminRouter = express.Router()
const admin = require('../middlewares/admin_middleware')
const {Product} = require('../models/product')


adminRouter.post('/admin/add-product', admin, async (req, res) => {
    try {
        const { name, description, images, quantity, price, category, whichShop } = req.body
        
        let product = new Product({
            name,
            description,
            images,
            quantity,
            price,
            category,
            whichShop,
        });

        product = await product.save();
        res.json(product);
    }
    catch (err) {
        res.status(500).json({ error: err.message })
    }
});

// Get all product...

adminRouter.get('/admin/get-products', admin, async (req,res) => {
    try {
        const products = await Product.find({});
        res.json(products);
    }
    catch (err)
    {
        res.json({error : err.message})
    }
})

module.exports = adminRouter;