const mongoose = require('mongoose');

mongoose.connect(process.env.MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
}).then(() => console.log("MongoDB verbunden"))
  .catch(err => console.error("Fehler:", err));

module.exports = mongoose;