const mongoose = require('mongoose');
const { Schema, model } = mongoose;

const productSchema = new Schema({
    name: { type: String, required: true },
    description: { type: String, required: true },
    specifications: { type: String, required: true },
    category: { type: Schema.Types.ObjectId, ref: 'Category', required: true },
    price: { type: Number, required: true },
    brand: { type: Schema.Types.ObjectId, ref: 'Brand', required: true },
    image: { type: String },
    quantity: { type: Number, required: true },
}, { timestamps: true });

const Product = model('Product', productSchema);

module.exports = Product;