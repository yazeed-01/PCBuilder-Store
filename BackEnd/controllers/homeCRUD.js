const FeaturedProduct = require('../models/home').FeaturedProduct;
const NewProduct = require('../models/home').NewProduct;
const Offer = require('../models/home').Offer;

// Featured Products Controller
exports.createFeaturedProduct = async (req, res) => {
    try {
        const featuredProduct = new FeaturedProduct(req.body);
        await featuredProduct.save();
        res.status(201).send(featuredProduct);
    } catch (error) {
        res.status(400).send(error);
    }
};

exports.getFeaturedProduct = async (req, res) => {
    try {
        const featuredProduct = await FeaturedProduct.findById(req.params.id).populate('productID');
        if (!featuredProduct) return res.status(404).send('Featured product not found');
        res.send(featuredProduct);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.getAllFeaturedProducts = async (req, res) => {
    try {
        const featuredProducts = await FeaturedProduct.find().populate('productID');
        res.send(featuredProducts);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.deleteFeaturedProduct = async (req, res) => {
    try {
        const featuredProduct = await FeaturedProduct.findByIdAndDelete(req.params.id);
        if (!featuredProduct) return res.status(404).send('Featured product not found');
        res.send(featuredProduct);
    } catch (error) {
        res.status(500).send(error);
    }
};

// New Products Controller
exports.createNewProduct = async (req, res) => {
    try {
        const newProduct = new NewProduct(req.body);
        await newProduct.save();
        res.status(201).send(newProduct);
    } catch (error) {
        res.status(400).send(error);
    }
};

exports.getNewProduct = async (req, res) => {
    try {
        const newProduct = await NewProduct.findById(req.params.id).populate('productID');
        if (!newProduct) return res.status(404).send('New product not found');
        res.send(newProduct);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.getAllNewProducts = async (req, res) => {
    try {
        const newProducts = await NewProduct.find().populate('productID');
        res.send(newProducts);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.deleteNewProduct = async (req, res) => {
    try {
        const newProduct = await NewProduct.findByIdAndDelete(req.params.id);
        if (!newProduct) return res.status(404).send('New product not found');
        res.send(newProduct);
    } catch (error) {
        res.status(500).send(error);
    }
};

// Offers Controller
exports.createOffer = async (req, res) => {
    try {
        const offer = new Offer(req.body);
        await offer.save();
        res.status(201).send(offer);
    } catch (error) {
        res.status(400).send(error);
    }
};

exports.getOffer = async (req, res) => {
    try {
        const offer = await Offer.findById(req.params.id).populate('productID');
        if (!offer) return res.status(404).send('Offer not found');
        res.send(offer);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.getAllOffers = async (req, res) => {
    try {
        const offers = await Offer.find().populate('productID');
        res.send(offers);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.updateOffer = async (req, res) => {
    try {
        const offer = await Offer.findByIdAndUpdate(req.params.id, req.body, { new: true, runValidators: true });
        if (!offer) return res.status(404).send('Offer not found');
        res.send(offer);
    } catch (error) {
        res.status(400).send(error);
    }
};

exports.deleteOffer = async (req, res) => {
    try {
        const offer = await Offer.findByIdAndDelete(req.params.id);
        if (!offer) return res.status(404).send('Offer not found');
        res.send(offer);
    } catch (error) {
        res.status(500).send(error);
    }
};