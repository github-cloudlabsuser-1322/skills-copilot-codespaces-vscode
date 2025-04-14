// Create web server
const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const cors = require('cors');
const mongoose = require('mongoose');
const Comment = require('./models/comment'); // Import the Comment model                    
const { MongoClient } = require('mongodb');
const uri = 'mongodb://localhost:27017'; // MongoDB connection string
const client = new MongoClient(uri, { useNewUrlParser: true, useUnifiedTopology: true });
const dbName = 'comments'; // Database name
const collectionName = 'comments'; // Collection name
const port = 3000; // Port number
const corsOptions = {
  origin: 'http://localhost:3000', // Replace with your frontend URL
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type'],
};
app.use(cors(corsOptions));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
// Connect to MongoDB
client.connect((err) => {
  if (err) {
    console.error('Error connecting to MongoDB:', err);
    return;
  }
  console.log('Connected to MongoDB');
  const db = client.db(dbName);
  const collection = db.collection(collectionName);

  // Create a new comment
  app.post('/comments', async (req, res) => {
    try {
      const comment = new Comment(req.body);
      await collection.insertOne(comment);
      res.status(201).json(comment);
    } catch (error) {
      res.status(500).json({ error: 'Failed to create comment' });
    }
    });
  });
    // Get all comments
    app.get('/comments', async (req, res) => {
        try {
            const comments = await collection.find().toArray();
            res.status(200).json(comments);
        } catch (error) {
            res.status(500).json({ error: 'Failed to fetch comments' });
        }
        }
    );
    // Get a comment by ID
    app.get('/comments/:id', async (req, res) => {
        try {
            const comment = await collection.findOne({ _id: new mongoose.Types.ObjectId(req.params.id) });
            if (!comment) {
                return res.status(404).json({ error: 'Comment not found' });
            }
            res.status(200).json(comment);
        } catch (error) {
            res.status(500).json({ error: 'Failed to fetch comment' });
        }
    });