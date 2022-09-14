
const mongoose = require("mongoose");


const productSchema = mongoose.Schema({
ownerName: {
    type: String,
    required: true,
    trim: true,
},
shopName: {
    type: String,
    required: true,
    trim: true,
},
imageUrl: [
    {
    type: String,
    required: true,
    },
],
avgPrice: {
    type: Number,
    required: true,
},
tags: [
    {
    type: String,
    required: true,
    },
],

});

const Shop = mongoose.model("Shop", productSchema);
module.exports = { Shop, productSchema };