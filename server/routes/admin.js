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
        price,
    });
    product = await product.save();
    res.json(product);
});

adminRouter.get('/admin-get-products', admin, async (req, res) => {
    try {
        const products = await Product.find({});
        res.json(products);
    } catch (e) {
        res.json({ error: e.message });
    }
});

adminRouter.post('/admin-delete-product', admin, async (req, res) => {
    try {
        const { id } = req.body;
        const product = await Product.findByIdAndDelete(id);
        res.json("sucesss");
    } catch (e) {
        res.json({ error: e.message });
    }
})
module.exports = (adminRouter);