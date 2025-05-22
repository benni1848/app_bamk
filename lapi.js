const express = require("express");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const cors = require("cors");

const app = express();
app.use(express.json());
app.use(cors());

const users = {}; // Simulierte Datenbank

app.post("/login", async (req, res) => {
  const { username, password } = req.body;
  const user = users[username];

  if (!user || !(await bcrypt.compare(password, user.password))) {
    return res.status(401).json({ message: "Ungültige Anmeldeinformationen" });
  }

  const token = jwt.sign({ username }, "geheimer_schlüssel", { expiresIn: "1h" });
  res.json({ token });
});

app.listen(3000, () => console.log("Server läuft auf Port 3000"));