const Product = require('../models/product');

exports.createProduct = async (req, res) => {
    try {
        const product = new Product(req.body);
        await product.save();
        res.status(201).send(product);
    } catch (error) {
        res.status(400).send(error);
    }
};

exports.getProduct = async (req, res) => {
    try {
        const products = await Product.find({ category: req.params.id })
            .populate('category');
        if (!products || products.length === 0) return res.status(404).send('No products found for this category');
        res.send(products);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.getAllProducts = async (req, res) => {
    try {
        const products = await Product.find()
            .populate('category')
            .populate('brand');
        res.send(products);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.updateProduct = async (req, res) => {
    try {
        const product = await Product.findByIdAndUpdate(req.params.id, req.body, { new: true, runValidators: true });
        if (!product) return res.status(404).send('Product not found');
        res.send(product);
    } catch (error) {
        res.status(400).send(error);
    }
};

exports.deleteProduct = async (req, res) => {
    try {
        const product = await Product.findByIdAndDelete(req.params.id);
        if (!product) return res.status(404).send('Product not found');
        res.send(product);
    } catch (error) {
        res.status(500).send(error);
    }
};