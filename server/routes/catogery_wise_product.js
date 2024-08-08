const express = require("express");
const auth = require("../middlewares/auth");
const { Product } = require("../models/product");
const rating = require("../models/rating");

const catogeryProduct = express.Router();

catogeryProduct.get('/getproduct/catogerywise', auth, async (req, res) => {
    try {
        const fetchedProducts = await Product.find({
            "category": req.query.category
        })
        res.json(fetchedProducts);
    } catch (e) {
        res.json({ error: e.message });
    }
});

// create a get request to search products and get them
// /api/products/search/i
catogeryProduct.get("/api/products/search/:name", auth, async (req, res) => {
    try {
        const products = await Product.find({
            name: { $regex: req.params.name, $options: "i" },
        });
        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});


// create a post request route to rate the product.
catogeryProduct.post("/api/rate-product", auth, async (req, res) => {
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

catogeryProduct.get("/api/highratedpro", auth, async (req, res) => {
    try {
        const result = await Product.aggregate([
            {
                $addFields: {
                    totalRating: {
                        $sum: {
                            $map: {
                                input: "$ratings",
                                as: "rating",
                                in: "$$rating.rating"
                            }
                        }
                    }
                }
            },
            { $sort: { totalRating: -1 } },
            { $limit: 1 }
        ]);
        res.json(result[0]);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
})

module.exports = (catogeryProduct);