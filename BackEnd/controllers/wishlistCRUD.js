const Wishlist = require('../models/wishlist');

exports.createWishlist = async (req, res) => {
    try {
        const wishlist = new Wishlist(req.body);
        await wishlist.save();
        res.status(201).send(wishlist);
    } catch (error) {
        res.status(400).send(error);
    }
};

exports.getWishlist = async (req, res) => {
    try {
        const wishlist = await Wishlist.findById(req.params.id);
        if (!wishlist) return res.status(404).send('wishlist not found');
        res.send(wishlist);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.getAllWishlists = async (req, res) => {
    try {
        const wishlists = await Wishlist.find();
        res.send(wishlists);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.updateWishlist = async (req, res) => {
    try {
        const wishlist = await Wishlist.findByIdAndUpdate(req.params.id, req.body, { new: true, runValidators: true });
        if (!wishlist) return res.status(404).send('wishlist not found');
        res.send(wishlist);
    } catch (error) {
        res.status(400).send(error);
    }
};

exports.deleteWishlist = async (req, res) => {
    try {
        const wishlist = await Wishlist.findByIdAndDelete(req.params.id);
        if (!wishlist) return res.status(404).send('wishlist not found');
        res.send(wishlist);
    } catch (error) {
        res.status(500).send(error);
    }
};
