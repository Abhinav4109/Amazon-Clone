const express = require('express');
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const User = require('../models/user');
const auth = require('../middlewares/auth');


const authRouter = express.Router();

authRouter.post('/api/siginup', async (req, res) => {
    try {
        const { name, email, password } = req.body;
        const exsitingUser = await User.findOne({ email });
        if (exsitingUser) {
            return res.status(400).json({ msg: 'User with same email address already exists.' })
        };
        const hashedPassword = await bcrypt.hash(password, 8);
        let user = new User({
            name: name,
            email: email,
            password: hashedPassword
        });
        user = await user.save();
        res.json(user);
        console.log(user);
    } catch (e) {
        res.status(500).json({ error: e.message })
    }
});

authRouter.post('/api/signin', async (req, res) => {
    try {
        const { email, password } = req.body;
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ msg: "User with this email address does not exist!" });
        }
        const isPassMatch = await bcrypt.compare(password, user.password);
        if (!isPassMatch) {
            return res.status(400).json({ msg: "Incorrect password." });
        }
        const token = jwt.sign({ id: user._id }, "secretkey")
        res.json({ token, ...user._doc });
    } catch (e) {
        res.json({ error: e.message });
    }
});

authRouter.post('/isTokenValid', async (req, res) => {
    const token = req.header('x-auth-token');
    console.log(token)
    if (!token) return res.json(false);
    const verified = jwt.verify(token, "secretkey");
    if (!verified) return res.json(false);
    const user = User.findById(verified.id);
    if (!user) return res.json(false);
    res.json(true);
});

// getting user data
authRouter.get('/', auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token });
});
module.exports = (authRouter);