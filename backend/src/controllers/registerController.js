const bcrypt = require('bcryptjs');
const User = require('../models/userModel'); // Ensure this path is correct

const register = async (req, res) => {
  console.log('Register endpoint hit');
  const { username, email, password } = req.body;

  try {
    const userExists = await User.findOne({ email });
    if (userExists) return res.status(400).json({ message: 'Email already exists' });

    // ✅ Match frontend validation:
    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$/;
    if (!passwordRegex.test(password)) {
      return res.status(400).json({
        message: 'Password must be at least 8 characters, include 1 uppercase letter, 1 lowercase letter, and 1 number.',
      });
    }

    const newUser = new User({ username, email, password });

    const salt = await bcrypt.genSalt(10);
    newUser.password = await bcrypt.hash(password, salt);

    await newUser.save();

    res.status(201).json({
      success: true,
      message: 'User registered successfully.',
      userId: newUser._id,
    });
  } catch (err) {
    res.status(500).json({ message: 'Server error' });
  }
};

module.exports = { register };
