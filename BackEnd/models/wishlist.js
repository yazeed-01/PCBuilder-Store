const mongoose = require('mongoose');
const { Schema, model } = mongoose;

const wishlistSchema = new Schema({
    user: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    products: [{ type: Schema.Types.ObjectId, ref: 'Product' }],
}, { timestamps: true });

const Wishlist = model('Wishlist', wishlistSchema);

module.exports = Wishlist;