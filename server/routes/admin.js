const express = require("express");
const admin = require("../middlewares/admin");
const { Product } = require("../models/product");

const adminRouter = express.Router();

adminRouter.post('/admin/add-product', admin, async (req, res) => {
    const { name, description, quantity, images, category, price } = req.body;
    let product = Product({
        name,
        description,
        quantity,
        images,
        category,
        price
    });
    product = await product.save();
    res.json(product);
});
module.exports = (adminRouter);