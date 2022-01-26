import { Client } from "pg";
import { config } from "dotenv";
import express from "express";
import cors from "cors";

config(); //Read .env file lines as though they were env vars.

//Call this script with the environment variable LOCAL set if you want to connect to a local db (i.e. without SSL)
//Do not set the environment variable LOCAL if you want to connect to a heroku DB.

//For the ssl property of the DB connection config, use a value of...
// false - when connecting to a local DB
// { rejectUnauthorized: false } - when connecting to a heroku DB
const herokuSSLSetting = { rejectUnauthorized: false };
const sslSetting = process.env.LOCAL ? false : herokuSSLSetting;
const dbConfig = {
  connectionString: process.env.DATABASE_URL,
  ssl: sslSetting,
};

const app = express();

app.use(express.json()); //add body parser to each following route handler
app.use(cors()); //add CORS support to each following route handler

const client = new Client(dbConfig);
client.connect();

app.get("/songs", async (req, res) => {
  const dbres = await client.query("SELECT * FROM songs");
  const response = [];

  for (const song of dbres.rows) {
    const artistGenre: { [key: string]: Array<string> } = {};
    const dbresArtist = await client.query(
      "SELECT * FROM artists WHERE song_uri = $1",
      [song.uri]
    );
    // Get artists associated with song
    for (const artist of dbresArtist.rows) {
      const dbresGenre = await client.query(
        "SELECT genre FROM genres WHERE artist_uri = $1",
        [artist.artist_uri]
      );
      // Append genres to associated artist
      artistGenre[artist.artist_name] = [
        ...dbresGenre.rows.map((genre) => genre.genre),
      ];
    }
    response.push({
      ...song,
      artists: artistGenre,
    });
  }
  res.status(200).json({ message: "success", data: response });
});

app.get("/songs/popular", async (req, res) => {
  try {
    const dbresPopular = await client.query(
      "SELECT * FROM songs ORDER BY likes desc LIMIT 5;"
    );
    const dbresUnpopular = await client.query(
      "SELECT * FROM songs ORDER BY dislikes desc LIMIT 5;"
    );
    res.status(200).json({
      message: "success",
      data: { popular: dbresPopular.rows, unpopular: dbresUnpopular.rows },
    });
  } catch (e) {
    res.status(500).json({
      message: "Internal server error trying to fetch popular songs",
      data: {},
    });
  }
});

// When adding a song, also add any new artists and their genres
app.post("/songs", async (req, res) => {
  const { uri, name, album, album_art, release_date, artists } = req.body;
  const checkURI = await client.query("SELECT * FROM songs where uri = $1", [
    uri,
  ]);
  let dbresSong;
  try {
    if (checkURI.rowCount === 0) {
      dbresSong = await client.query(
        "INSERT INTO songs VALUES ($1, $2, $3, $4, $5) RETURNING *",
        [uri, name, album, album_art, release_date]
      );
      for (let artist of artists) {
        await client.query(
          "INSERT INTO artists (artist_uri,song_uri,artist_name) VALUES ($1, $2, $3)\
       ON CONFLICT (artist_uri, song_uri) DO NOTHING",
          [artist.artist_uri, uri, artist.artist_name]
        );
        const checkArtistGenre = await client.query(
          "SELECT * FROM genres where artist_uri = $1",
          [artist.artist_uri]
        );
        if (checkArtistGenre.rowCount === 0) {
          for (let genre of artist.genres)
            await client.query(
              "INSERT INTO genres (artist_uri,genre) VALUES ($1, $2)",
              [artist.artist_uri, genre]
            );
        }
      }
      res.status(201).json({ message: "Success", data: dbresSong.rows });
    } else {
      res
        .status(409)
        .json({ message: "Conflict - duplicate song URI found", data: {} });
    }
  } catch (e) {
    res.status(500).json({
      message: "Internal server error trying to create add new song",
      data: {},
    });
  }
});

app.put("/songs/:uri/:option", async (req, res) => {
  const { uri, option } = req.params;
  let dbres;
  try {
    if (option === "likes") {
      dbres = await client.query(
        "UPDATE songs SET likes = likes + 1 WHERE uri=$1 RETURNING *",
        [uri]
      );
    } else {
      dbres = await client.query(
        "UPDATE songs SET dislikes = dislikes + 1 WHERE uri=$1 RETURNING *",
        [uri]
      );
    }
    res.status(200).json({ messsage: "Success", data: dbres.rows });
  } catch (e) {
    res.status(500).json({
      message: "Internal server error trying to update song",
      data: {},
    });
  }
});

//Start the server on the given port
const port = process.env.PORT;
if (!port) {
  throw "Missing PORT environment variable.  Set it in .env file.";
}
app.listen(port, () => {
  console.log(`Server is up and running on port ${port}`);
});
