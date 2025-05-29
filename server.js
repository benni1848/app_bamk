/*require('dotenv').config(); // Lädt Umgebungsvariablen

const express = require('express'); 
const mongoose = require('mongoose'); 
const cors = require('cors'); 

const app = express();
app.use(express.json());
app.use(cors());

// Geheimen Schlüssel laden
const secretKey = process.env.SECRET_KEY; 
console.log("Geheimer Schlüssel:", secretKey); // Testausgabe

// MongoDB verbinden
mongoose.connect(process.env.MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
}).then(() => console.log(" MongoDB verbunden"))
  .catch(err => console.error(" Fehler:", err));

const PORT = process.env.PORT || 27017;
app.listen(PORT, () => console.log(`Server läuft auf Port ${PORT}`));

console.log("MongoDB URI:", process.env.MONGO_URI);*/