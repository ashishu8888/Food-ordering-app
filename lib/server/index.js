const express = require('express')
const authRouter = require('./routes/auth.js')
const mongoose = require('mongoose')
const adminRouter = require('./routes/admin.js')

//INTIT
const PORT  = process.env.PORT || 3000
const app = express()
const DB = "mongodb+srv://ashish:ashish123@cluster0.d5p0m.mongodb.net/?retryWrites=true&w=majority"

// middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
//Connecion
mongoose.connect(DB).then(() => {
    console.log("connection successful");
}).catch((e) => {
    console.log(e);
})

app.listen(PORT, "0.0.0.0", () => {
    console.log(`connected at port ${PORT}`)
})
