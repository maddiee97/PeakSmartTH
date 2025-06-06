const express = require('express');
const router = express.Router();
const registerController = require('../controllers/registerController');
const loginController = require('../controllers/loginController'); // ✅ Add this

// ✅ Add this route
router.post('/login', loginController.login);

router.post('/register', registerController.register);

router.post('/update-provider', async (req, res) => {
  const { userId, provider } = req.body;
  const user = await User.findById(userId);
  if (!user) return res.status(404).json({ message: 'User not found' });

  user.provider = provider;
  await user.save();
  res.status(200).json({ message: 'Provider updated', provider: user.provider });
});

module.exports = router;
