const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
require('dotenv').config();

const app = express();

// Middlewares
app.use(cors());
app.use(express.json()); // Parses JSON request bodies

// Logger (optional - can remove in production)
app.use((req, res, next) => {
  console.log(`Request: ${req.method} ${req.url}`);
  console.log('Body:', req.body);
  next();
});

// Routes
const authRoutes = require('./src/routes/authRoutes');
const userRoutes = require('./src/routes/userRoutes'); // ✅ new user route

app.use('/api/auth', authRoutes);
app.use('/api/users', userRoutes); // ✅ added user route

// DB + Server
const PORT = process.env.PORT || 3000;

mongoose.connect(process.env.MONGODB_URI)
  .then(() => console.log('Connected to MongoDB Atlas'))
  .catch((err) => console.error('MongoDB connection error:', err));

app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
});
