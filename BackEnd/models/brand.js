const mongoose = require('mongoose');
const { Schema, model } = mongoose;

const brandSchema = new Schema({
    name: { type: String, required: true, unique: true, trim: true },
}, { timestamps: true });

const Brand = model('Brand', brandSchema);

module.exports = Brand;