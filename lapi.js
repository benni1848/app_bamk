const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();
app.use(express.json());
app.use(cors());

// ✅ Verbindung zu MongoDB Atlas herstellen
mongoose.connect("mongodb+srv://BamkAdmin:Bamk2025@bamk0.ubj9tvi.mongodb.net/", {
  useNewUrlParser: true,
  useUnifiedTopology: true
})
.then(() => console.log("✅ Erfolgreich mit MongoDB Atlas verbunden"))
.catch((err) => console.error("❌ Fehler bei der MongoDB-Verbindung:", err));

// ✅ MongoDB Schema für Filme
const FilmSchema = new mongoose.Schema({
  titel: String,
  genre: [String],
  mitwirkende: [String],
  laufzeit: Number,
  erscheinungsdatum: String,
  nutzerwertung_prozent: Number,
  nutzerwertung_sterne: Number,
  beschreibung: String,
  trailer_link: String,
  altersfreigabe: String
});

const Film = mongoose.model("Film", FilmSchema, "col_bamk");

// ✅ API-Endpunkt: Alle Filme abrufen
app.get("/api/data", async (req, res) => {
  try {
    const data = await Film.find();
    if (data.length === 0) {
      return res.status(404).json({ error: "Keine Daten gefunden" });
    }
    res.json(data);
  } catch (error) {
    res.status(500).json({ error: "Serverfehler" });
  }
});

// ✅ API-Endpunkt: Einzelnen Film nach Titel abrufen
app.get("/api/data/:titel", async (req, res) => {
  try {
    const film = await Film.findOne({ titel: req.params.titel });
    if (!film) {
      return res.status(404).json({ error: "Film nicht gefunden" });
    }
    res.json(film);
  } catch (error) {
    res.status(500).json({ error: "Serverfehler" });
  }
});

// ✅ Starte den Server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`🚀 API läuft auf Port ${PORT}`));