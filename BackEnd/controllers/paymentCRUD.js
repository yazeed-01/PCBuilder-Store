const Payment = require('../models/payment');

exports.createPayment = async (req, res) => {
    try {
        const payment = new Payment(req.body);
        await payment.save();
        res.status(201).send(payment);
    } catch (error) {
        res.status(400).send(error);
    }
};

exports.getPayment = async (req, res) => {
    try {
        const payment = await Payment.findById(req.params.id).populate('order');
        if (!payment) return res.status(404).send('Payment not found');
        res.send(payment);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.getAllPayments = async (req, res) => {
    try {
        const payments = await Payment.find().populate('order');
        res.send(payments);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.updatePayment = async (req, res) => {
    try {
        const payment = await Payment.findByIdAndUpdate(req.params.id, req.body, { new: true, runValidators: true });
        if (!payment) return res.status(404).send('Payment not found');
        res.send(payment);
    } catch (error) {
        res.status(400).send(error);
    }
};

exports.deletePayment = async (req, res) => {
    try {
        const payment = await Payment.findByIdAndDelete(req.params.id);
        if (!payment) return res.status(404).send('Payment not found');
        res.send(payment);
    } catch (error) {
        res.status(500).send(error);
    }
};