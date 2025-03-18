const CouponCode = require('../models/coupon_code');

exports.createCouponCode = async (req, res) => {
    try {
        const couponCode = new CouponCode(req.body);
        await couponCode.save();
        res.status(201).send(couponCode);
    } catch (error) {
        res.status(400).send(error);
    }
};

exports.getCouponCode = async (req, res) => {
    try {
        const couponCode = await CouponCode.findById(req.params.id);
        if (!couponCode) return res.status(404).send('Coupon code not found');
        res.send(couponCode);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.getAllCouponCodes = async (req, res) => {
    try {
        const couponCodes = await CouponCode.find();
        res.send(couponCodes);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.updateCouponCode = async (req, res) => {
    try {
        const couponCode = await CouponCode.findByIdAndUpdate(req.params.id, req.body, { new: true, runValidators: true });
        if (!couponCode) return res.status(404).send('Coupon code not found');
        res.send(couponCode);
    } catch (error) {
        res.status(400).send(error);
    }
};

exports.deleteCouponCode = async (req, res) => {
    try {
        const couponCode = await CouponCode.findByIdAndDelete(req.params.id);
        if (!couponCode) return res.status(404).send('Coupon code not found');
        res.send(couponCode);
    } catch (error) {
        res.status(500).send(error);
    }
};