const User = require('../models/userModel');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const login = async (req, res) => {
  const { email, password } = req.body;

  try {
    const user = await User.findOne({ email });
    if (!user) return res.status(400).json({ message: 'Invalid credentials' });

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) return res.status(400).json({ message: 'Invalid credentials' });

    const token = jwt.sign(
      { id: user._id },
      process.env.JWT_SECRET, // make sure this is defined!
      { expiresIn: '1d' }
    );

    res.status(200).json({
      token,
      username: user.username,
      email: user.email,
      provider: user.provider || 'PEA',
    });
  } catch (err) {
  console.error('Login error:', err); // ← add this
  res.status(500).json({ message: 'Server error' });
  }
};

module.exports = { login };
