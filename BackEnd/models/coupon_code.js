const mongoose = require('mongoose');
const { Schema, model } = mongoose;

const couponCodeSchema = new Schema({
    code: { type: String, required: true, unique: true, trim: true },
    discount: { type: Number, required: true },
    expiryDate: { type: Date, required: true },
    usageLimit: { type: Number, default: 1 },
    status: { type: String, default: 'active', enum: ['active', 'inactive'] },
}, { timestamps: true });

const CouponCode = model('CouponCode', couponCodeSchema);

module.exports = CouponCode;