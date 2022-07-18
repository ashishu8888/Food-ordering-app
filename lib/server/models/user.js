const mongoose = require('mongoose')
const { productSchema } = require("./product");

const userSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re)
            },
            message: "please enter a valid email address"
        }
        
    },

    password: {
        required: true,
        type: String,
        validate: {
            validator: (value) => {
                return value.length > 6;
            },
            message: "please enter a password > 6"
        }
    
    },

    address: {
        type: String,
        default: '',
    },
    type: {
        type: String,
        default: 'user',
    },

    whichShop: {
        type: String,
        default : '',
    },
    cart: [
        {
            product: productSchema,
            quantity: {
                type: Number,
                required: true,
        },
},
    ]
});

const User = mongoose.model("User", userSchema)
module.exports = User