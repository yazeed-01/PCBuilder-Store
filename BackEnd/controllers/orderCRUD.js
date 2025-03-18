const Order = require('../models/order');

exports.createOrder = async (req, res) => {
    try {
        const order = new Order(req.body);
        await order.save();
        res.status(201).send(order);
    } catch (error) {
        res.status(400).send(error);
    }
};

exports.getOrder = async (req, res) => {
    try {
        const order = await Order.findById(req.params.id)
            .populate('user')
            .populate('items.product');
        if (!order) return res.status(404).send('Order not found');
        res.send(order);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.getAllOrders = async (req, res) => {
    try {
        const orders = await Order.find()
            .populate('user')
            .populate('items.product');
        res.send(orders);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.updateOrder = async (req, res) => {
    try {
        const order = await Order.findByIdAndUpdate(req.params.id, req.body, { new: true, runValidators: true });
        if (!order) return res.status(404).send('Order not found');
        res.send(order);
    } catch (error) {
        res.status(400).send(error);
    }
};

exports.deleteOrder = async (req, res) => {
    try {
        const order = await Order.findByIdAndDelete(req.params.id);
        if (!order) return res.status(404).send('Order not found');
        res.send(order);
    } catch (error) {
        res.status(500).send(error);
    }
};