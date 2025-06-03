const bcrypt = require('bcryptjs');
const User = require('../models/userModel'); // Ensure this path is correct

const register = async (req, res) => {
     console.log('Register endpoint hit');
  const { username, email, password } = req.body;

  try {
    // Check if the email already exists in the database
    const userExists = await User.findOne({ email });
    if (userExists) return res.status(400).json({ message: 'Email already exists' });

    // Create a new user (without provider)
    const newUser = new User({
      username,
      email,
      password,
    });

    // Hash the password before saving
    const salt = await bcrypt.genSalt(10);
    newUser.password = await bcrypt.hash(password, salt);

    await newUser.save();

    // Send the user ID along with a success message
    res.status(201).json({
      success: true,
      message: 'User registered successfully.',
      userId: newUser._id, // Send user ID
    });
  } catch (err) {
    res.status(500).json({ message: 'Server error' });
  }
};

module.exports = { register };
