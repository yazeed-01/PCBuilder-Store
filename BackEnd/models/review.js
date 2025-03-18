const mongoose = require('mongoose');
const { Schema, model } = mongoose;

const reviewSchema = new Schema({
    user: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    product: { type: Schema.Types.ObjectId, ref: 'Product', required: true },
    rating: { type: Number, required: true },
    comment: { type: String },
}, { timestamps: true });

const Review = model('Review', reviewSchema);

module.exports = Review;