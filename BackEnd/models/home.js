const mongoose = require('mongoose');
const { Schema, model } = mongoose;

const featuredProductSchema = new Schema({
    product: { type: Schema.Types.ObjectId, ref: 'Product', required: true },
}, { timestamps: true });

const newProductSchema = new Schema({
    product: { type: Schema.Types.ObjectId, ref: 'Product', required: true },
}, { timestamps: true });

const offerSchema = new Schema({
    product: { type: Schema.Types.ObjectId, ref: 'Product', required: true },
    discount: { type: Number, required: true },
    offerDetails: { type: String },
}, { timestamps: true });

const FeaturedProduct = model('FeaturedProduct', featuredProductSchema);
const NewProduct = model('NewProduct', newProductSchema);
const Offer = model('Offer', offerSchema);

module.exports = { FeaturedProduct, NewProduct, Offer };