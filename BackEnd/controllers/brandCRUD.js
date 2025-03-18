const Brand = require('../models/brand');

exports.createBrand = async (req, res) => {
    try {
        const brand = new Brand(req.body);
        await brand.save();
        res.status(201).send(brand);
    } catch (error) {
        res.status(400).send(error);
    }
};

exports.getBrand = async (req, res) => {
    try {
        const brand = await Brand.findById(req.params.id);
        if (!brand) return res.status(404).send('Brand not found');
        res.send(brand);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.getAllBrands = async (req, res) => {
    try {
        const brands = await Brand.find();
        res.send(brands);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.updateBrand = async (req, res) => {
    try {
        const brand = await Brand.findByIdAndUpdate(req.params.id, req.body, { new: true, runValidators: true });
        if (!brand) return res.status(404).send('Brand not found');
        res.send(brand);
    } catch (error) {
        res.status(400).send(error);
    }
};

exports.deleteBrand = async (req, res) => {
    try {
        const brand = await Brand.findByIdAndDelete(req.params.id);
        if (!brand) return res.status(404).send('Brand not found');
        res.send(brand);
    } catch (error) {
        res.status(500).send(error);
    }
};