const express = require('express')
const productRouter = express.Router()
const {Product} = require("../models/product")
const auth = require('../middlewares/auth_middleware')


productRouter.get('/api/products', auth, async (req, res) => {
    try {
        const products = await Product.find({category:req.query.category,});
        res.json(products);
}
    catch (err) {
        res.json({ error: err.message +'ll'})
    }
});

// create a get request to search and get them
productRouter.get('/api/products/search/:query', auth, async (req, res) => {
    try {
        const products = await Product.find({
            query: {$regex: req.params.query,$options : "i"},
        });
        res.json(products);
}
    catch (err) {
        res.json({ error: err.message })
    }
});

module.exports = productRouter;