const express = require('express');
const router = express.Router();

const registerController = require('../controllers/registerController');
const loginController = require('../controllers/loginController');
const User = require('../models/userModel'); // ✅ Ensure this is correct

// ✅ Login Route
router.post('/login', loginController.login);

// ✅ Register Route
router.post('/register', registerController.register);

// ✅ Update Provider Route (with enhanced logging and validation)
router.post('/update-provider', async (req, res) => {
  const { userId, provider } = req.body;

  console.log('🔧 Update provider request received:', req.body);

  if (!userId || !provider) {
    return res.status(400).json({ message: 'Missing userId or provider' });
  }

  try {
    const user = await User.findById(userId);
    if (!user) {
      console.warn(`User not found with ID: ${userId}`);
      return res.status(404).json({ message: 'User not found' });
    }

    user.provider = provider;
    await user.save();

    console.log(`Provider updated for ${user.email}: ${provider}`);

    res.status(200).json({
      message: 'Provider updated successfully',
      provider: user.provider,
    });
  } catch (err) {
    console.error('Error updating provider:', err);
    res.status(500).json({ message: 'Server error' })
  }
});

module.exports = router;
