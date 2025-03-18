const mongoose = require('mongoose');
const { Schema, model } = mongoose;

const orderSchema = new Schema({
    user: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    items: [{
        product: { type: Schema.Types.ObjectId, ref: 'Product' },
        quantity: { type: Number, required: true },
        price: { type: Number, required: true },
    }],
    total: { type: Number, required: true },
    status: { type: String, default: 'Pending' },
}, { timestamps: true });

const Order = model('Order', orderSchema);

module.exports = Order;