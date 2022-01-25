CREATE TABLE songs (
  uri VARCHAR(255) PRIMARY KEY NOT NULL,
  name VARCHAR(255) NOT NULL,
  album VARCHAR(255) NOT NULL,
  album_art VARCHAR(255),
  release_date VARCHAR(255),
  likes INT,
  dislikes INT
);

CREATE TABLE artists (
  artist_uri VARCHAR(255) NOT NULL,
  song_uri VARCHAR(255) NOT NULL,
  artist_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (artist_uri, song_uri),
  FOREIGN KEY (song_uri) REFERENCES songs(uri)
);

CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    artist_uri VARCHAR(255) NOT NULL,
    genre VARCHAR(255) NOT NULL
);

INSERT INTO songs VALUES 
  ('02MWAaffLxlfxAUY7c5dvx', 'Heat Waves', 'Dreamland (+ Bonus Levels)','https://i.scdn.co/image/ab67616d00001e029e495fb707973f3390850eea', '2020-08-06'),
  ('04QTmCTsaVjcGaoxj8rSjE', 'Know Your Worth', 'Know Your Worth','https://i.scdn.co/image/ab67616d00001e026d8139ae2807fb26071e75d9', '2020-04-23'),
  ('0ERnYArznxdTBEIj1VSta8', 'man i is', 'No Pressure','https://i.scdn.co/image/ab67616d00001e021c76e29153f29cc1e1b2b434', '2020-07-24');

  INSERT INTO artists VALUES 
  ('4yvcSjfu4PC0CYQyLy4wSq','02MWAaffLxlfxAUY7c5dvx','Glass Animals'),
  ('6LuN9FCkKOj5PcnpouEgny','04QTmCTsaVjcGaoxj8rSjE','Khalid'),
  ('6nS5roXSAGhTGr34W6n7Et','04QTmCTsaVjcGaoxj8rSjE','Disclosure'),
  ('0Y3agQaa6g2r0YmHPOO9rh','04QTmCTsaVjcGaoxj8rSjE','DaVido'),
  ('4xRYI6VqpkE3UwrDrAZL8L','0ERnYArznxdTBEIj1VSta8','Logic');

  INSERT INTO genres VALUES
  (DEFAULT, '4yvcSjfu4PC0CYQyLy4wSq', 'gauze pop'),
  (DEFAULT, '4yvcSjfu4PC0CYQyLy4wSq', 'indietronica'),
  (DEFAULT, '4yvcSjfu4PC0CYQyLy4wSq', 'shiver pop'),
  (DEFAULT, '6LuN9FCkKOj5PcnpouEgny', 'pop'),
  (DEFAULT, '6LuN9FCkKOj5PcnpouEgny', 'pop r&b'),
  (DEFAULT, '6nS5roXSAGhTGr34W6n7Et', 'house'),
  (DEFAULT, '6nS5roXSAGhTGr34W6n7Et', 'pop'),
  (DEFAULT, '6nS5roXSAGhTGr34W6n7Et', 'tropical house'),
  (DEFAULT, '6nS5roXSAGhTGr34W6n7Et', 'uk dance'),
  (DEFAULT, '0Y3agQaa6g2r0YmHPOO9rh', 'afropop'),
  (DEFAULT, '0Y3agQaa6g2r0YmHPOO9rh', 'ghanaian hip hop'),
  (DEFAULT, '0Y3agQaa6g2r0YmHPOO9rh', 'nigerian pop'),
  (DEFAULT, '4xRYI6VqpkE3UwrDrAZL8L', 'conscious hip hop'),
  (DEFAULT, '4xRYI6VqpkE3UwrDrAZL8L', 'dmv rap'),
  (DEFAULT, '4xRYI6VqpkE3UwrDrAZL8L', 'hip hop'),
  (DEFAULT, '4xRYI6VqpkE3UwrDrAZL8L', 'pop rap'),
  (DEFAULT, '4xRYI6VqpkE3UwrDrAZL8L', 'rap');
