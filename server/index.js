// importing express
const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth")
const adminRouter = require("./routes/admin");
const catogeryProduct = require("./routes/catogery_wise_product");
const userRouter = require("./routes/user");

// INIT
const app = express();
const PORT = 3000;
const DBuri = "mongodb+srv://Abhinav:abhinavamazonclone@cluster1.2u63vh0.mongodb.net/?appName=Cluster1";

app.use(express.json()); // alows to parse the json and make req.bpdy defined
// Middleware
app.use(authRouter, adminRouter, catogeryProduct, userRouter);


// connecting to mongoDB
mongoose.connect(DBuri).then(() => {
    console.log('connected to mongoDB')
}
).catch(e => {
    console.log(`causing issue to connect ${e}`)
});

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Server started and listening at PORT ${PORT}`)
});