const mongoose = require('mongoose');
const { Schema, model } = mongoose;

const paymentSchema = new Schema({
    order: { type: Schema.Types.ObjectId, ref: 'Order', required: true },
    method: { type: String, enum: ['Card', 'PayPal', 'COD'], required: true },
    status: { type: String, enum: ['Pending', 'Completed', 'Failed'], default: 'Pending' },
    transactionId: { type: String },
}, { timestamps: true });

const Payment = model('Payment', paymentSchema);

module.exports = Payment;