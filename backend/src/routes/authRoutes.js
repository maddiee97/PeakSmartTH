const express = require('express');
const router = express.Router();
const registerController = require('../controllers/registerController');
const User = require('../models/userModel'); // Add this import!

// Register Route
router.post('/register', registerController.register);

router.get('/test', (req, res) => {
  res.json({ message: 'Auth route working!' });
});

router.post('/register', (req, res, next) => {
  console.log('POST /api/auth/register route reached');
  next();
}, registerController.register);

// Update provider route
router.post('/update-provider', async (req, res) => {
  const { userId, provider } = req.body;

  try {
    const user = await User.findById(userId);
    if (!user) return res.status(404).json({ message: 'User not found' });

    user.provider = provider;
    await user.save();

    res.status(200).json({ message: 'Provider updated successfully', provider: user.provider });
  } catch (err) {
    res.status(500).json({ message: 'Server error' });
  }
});

module.exports = router;
