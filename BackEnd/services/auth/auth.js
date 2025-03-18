const User = require('../../models/user');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const JWT_SECRET = '122121212121'; 

exports.register = async (req, res) => {
    try {
        const { name, username, email, phone, age, password } = req.body;

        const hashedPassword = await bcrypt.hash(password, 10);

        const user = new User({
            name,
            username,
            email,
            phone,
            age,
            password: hashedPassword,
        });

        await user.save();

        res.status(201).send({ message: 'User registered successfully', user });
    } catch (error) {
        res.status(400).send({ error: 'Error during registration', details: error });
    }
};

exports.login = async (req, res) => {
    try {
        const { email, password } = req.body;

        const user = await User.findOne({ email });
        if (!user) return res.status(404).send({ error: 'User not found' });

        const isPasswordValid = await bcrypt.compare(password, user.password);
        if (!isPasswordValid) return res.status(401).send({ error: 'Invalid credentials' });

        const token = jwt.sign({ userId: user._id }, JWT_SECRET, { expiresIn: '1h' });

        res.send({ message: 'Login successful', token });
    } catch (error) {
        res.status(500).send({ error: 'Error during login', details: error });
    }
};

exports.forgetPassword = async (req, res) => {
    try {
        const { email, newPassword } = req.body;

        const user = await User.findOne({ email });
        if (!user) return res.status(404).send({ error: 'User not found' });

        const hashedPassword = await bcrypt.hash(newPassword, 10);
        user.password = hashedPassword;
        await user.save();

        res.send({ message: 'Password updated successfully' });
    } catch (error) {
        res.status(500).send({ error: 'Error during password reset', details: error });
    }
};
