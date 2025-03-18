const Address = require('../models/address');

exports.createAddress = async (req, res) => {
    try {
        const address = new Address(req.body);
        await address.save();
        res.status(201).send(address);
    } catch (error) {
        res.status(400).send(error);
    }
};

exports.getAddress = async (req, res) => {
    try {
        const address = await Address.findById(req.params.id).populate('user');
        if (!address) return res.status(404).send('Address not found');
        res.send(address);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.getAllAddresses = async (req, res) => {
    try {
        const addresses = await Address.find().populate('user');
        res.send(addresses);
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.updateAddress = async (req, res) => {
    try {
        const address = await Address.findByIdAndUpdate(req.params.id, req.body, { new: true, runValidators: true });
        if (!address) return res.status(404).send('Address not found');
        res.send(address);
    } catch (error) {
        res.status(400).send(error);
    }
};

exports.deleteAddress = async (req, res) => {
    try {
        const address = await Address.findByIdAndDelete(req.params.id);
        if (!address) return res.status(404).send('Address not found');
        res.send(address);
    } catch (error) {
        res.status(500).send(error);
    }
};