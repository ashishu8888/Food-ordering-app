const express = require('express')
const adminRouter = express.Router()
const admin = require('../middlewares/admin_middleware')
const {Product} = require('../models/product')
const { Shop } = require('../models/shop')
const Order = require('../models/order')
adminRouter.post('/admin/add-shop', admin, async (req, res) => {
    try {
        const { ownerName, shopName, avgPrice, imageUrl, tags, } = req.body
        
        let shop = new Shop({
            ownerName,
            shopName,
            avgPrice,
            imageUrl,
            tags,
        });
        shop = await shop.save();
        res.json(shop);
    }
    catch (err) {
        res.status(500).json({ error: err.message })
    }
});

adminRouter.get('/user/get-shops', admin, async (req, res) => {
    try {
        const shops = await Shop.find({});
        res.json(shops);
    }
    catch (err) {
        res.json({ error: err.message })
    }
});

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

adminRouter.get('/admin/get-products', admin, async (req, res) => {
    try {
        const products = await Product.find({});
        res.json(products);
    }
    catch (err) {
        res.json({ error: err.message })
    }
});

//delete the prodct...

adminRouter.post('/admin/delete-product', admin, async (req, res) => {
    try {
        const { id } = req.body;
        let product = await Product.findByIdAndDelete(id);
        // product = await product.save();
        res.json(product);
    }
    catch (err) {
        res.status(500).json({ error: err.message })
    }
});

adminRouter.get('/admin/get-orders', admin, async (req, res) => {
    try {
        const orders = await Order.find({})
        res.json(orders);
    }
    catch (e)
    {
        res.status(500).json({error : e.message})
    }
})

module.exports = adminRouter;