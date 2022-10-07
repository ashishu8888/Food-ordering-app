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

// create a post request route to rate the product.
productRouter.post("/api/rate-product", auth, async (req, res) => {
try {
    const { id, rating } = req.body;
    let product = await Product.findById(id);

    for (let i = 0; i < product.ratings.length; i++) {
    if (product.ratings[i].userId == req.user) {
        product.ratings.splice(i, 1);
        break;
    }
    }

    const ratingSchema = {
    userId: req.user,
    rating,
    };

    product.ratings.push(ratingSchema);
    product = await product.save();
    res.json(product);
} catch (e) {
    res.status(500).json({ error: e.message });
}
});
module.exports = productRouter;