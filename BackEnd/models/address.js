const mongoose = require('mongoose');
const { Schema, model } = mongoose;

const addressSchema = new Schema({
    user: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    addressLine1: { type: String, required: true },
    addressLine2: { type: String },
    city: { type: String, required: true },
    state: { type: String, required: true },
    postalCode: { type: String, required: true },
    country: { type: String, required: true },
}, { timestamps: true });

const Address = model('Address', addressSchema);

module.exports = Address;