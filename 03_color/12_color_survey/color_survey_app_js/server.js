//////////////////////////////////////////
// "Color Survey" (Server)              //
// Exercise on page 156 of CCM          //
// demo code by Lingdong Huang          //
//////////////////////////////////////////

// hosted on: https://color-survey.glitch.me/

// this is the server code. see sketches/ for the frontend

// init project
const express = require("express");
const bodyParser = require("body-parser");
var cors = require('cors');
const app = express();
const fs = require("fs");
app.use(bodyParser.urlencoded({extended:true}));
app.use(bodyParser.json());
app.use(cors());

// init sqlite db
const dbFile = "./.data/data.db";
const exists = fs.existsSync(dbFile);
const sqlite3 = require("sqlite3").verbose();
const db = new sqlite3.Database(dbFile);

// if ./.data/data.db does not exist, create it
db.serialize(() => {
  if (!exists) {
    db.run(
      "CREATE TABLE Data (colors TEXT)"
    );
    console.log("New table created!");
  }
});

app.use(express.static('sketches'));

function sendRows(response){
  db.all(`SELECT * from Data`, (err, rows) => {
    if (err){
      response.status(500).send("Unknown database error");
    }else{
      for (var i = 0; i < rows.length; i++){
        rows[i].colors = unescape(rows[i].colors);
      }
      response.status(200).send(JSON.stringify(rows));
    }
  });
}

// endpoint to get all the data in the database
app.get("/pull", (request, response) => {
  sendRows(response);
});

app.get("/push", (request, response) => {
  let q = request.query;
  console.log(q);
  
  db.run(`INSERT INTO Data (colors) VALUES ("${escape(q.colors)}")`, error => {
    if (error) {
      response.status(500).send("Unknown database error");
    }else{
      db.serialize(()=>{
        sendRows(response);
      })
    }
  });
});


// listen for requests :)
var listener = app.listen(process.env.PORT, () => {
  console.log(`Your app is listening on port ${listener.address().port}`);
});