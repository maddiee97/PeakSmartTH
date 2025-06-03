const mongoose = require('mongoose');

// Define the schema for User
const userSchema = new mongoose.Schema(
  {
    username: { type: String, required: true, unique: true },
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    provider: { type: String, default: '' }, // Add provider to user schema
  },
  { timestamps: true }
);

// Create model from schema
const User = mongoose.model('User', userSchema);

module.exports = User;
