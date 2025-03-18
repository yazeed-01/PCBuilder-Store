const Review = require('../models/review');

exports.createReview = async (req, res) => {
    try {
        const review = new Review(req.body);
        await review.save();
        res.status(201).send(review);
    } catch (error) {
        res.status(400).send(error);
    }
};

exports.getReview = async (req, res) => {
    try {
        const review = await Review.findById(req.params.id);
        if (!review) return res.status(404).send('review not found');
        res.send(review);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.getAllReviews = async (req, res) => {
    try {
        const review = await Review.find();
        res.send(review);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.updateReview = async (req, res) => {
    try {
        const review = await Review.findByIdAndUpdate(req.params.id, req.body, { new: true, runValidators: true });
        if (!review) return res.status(404).send('review not found');
        res.send(review);
    } catch (error) {
        res.status(400).send(error);
    }
};

exports.deleteReview = async (req, res) => {
    try {
        const review = await Review.findByIdAndDelete(req.params.id);
        if (!review) return res.status(404).send('Review not found');
        res.send(review);
    } catch (error) {
        res.status(500).send(error);
    }
};
