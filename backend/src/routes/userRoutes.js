const express = require('express');
const router = express.Router();
const User = require('../models/userModel'); // ✅ make sure this matches your model file

// GET /users/:id
router.get('/:id', async (req, res) => {
  try {
    const user = await User.findById(req.params.id).select('username email provider');
    if (!user) return res.status(404).json({ error: 'User not found' });
    res.json(user);
  } catch (err) {
    console.error('Error fetching user:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
