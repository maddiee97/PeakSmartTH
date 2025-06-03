const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
require('dotenv').config();

const app = express();

app.use(cors());
app.use(express.json());  // This is needed to parse JSON bodies

app.use((req, res, next) => {
  console.log('Request body:', req.body);
  next();
});

const authRoutes = require('./src/routes/authRoutes'); // your routes file path

app.use('/api/auth', authRoutes);

const PORT = process.env.PORT || 3000;

mongoose.connect(process.env.MONGODB_URI)
  .then(() => console.log('Connected to MongoDB Atlas'))
  .catch((err) => console.error('MongoDB connection error:', err));

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
