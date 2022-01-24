CREATE TABLE songs (
  uri VARCHAR(255) PRIMARY KEY NOT NULL,
  name VARCHAR(255) NOT NULL,
  album VARCHAR(255) NOT NULL,
  album_artwork VARCHAR(255),
  release_date VARCHAR(255),
  popularity INT
)

CREATE TABLE artists (
  artist_uri VARCHAR(255) PRIMARY KEY,
  song_uri VARCHAR(255) NOT NULL,
  artist_name VARCHAR(255) NOT NULL,
  FOREIGN KEY (song_uri) REFERENCES songs(uri)
)

CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    artist_uri VARCHAR(255) NOT NULL,
    genre VARCHAR(255) NOT NULL,
    FOREIGN KEY (artist_uri) REFERENCES artists(artist_uri)
)

INSERT INTO songs VALUES 
  ('02MWAaffLxlfxAUY7c5dvx', 'Heat Waves', 'Dreamland (+ Bonus Levels)','https://i.scdn.co/image/ab67616d00001e02eeef81a914a1db21799c8322', '2020-08-06'),
  ('04QTmCTsaVjcGaoxj8rSjE', 'Know Your Worth', 'Know Your Worth','https://i.scdn.co/image/ab67616d00001e026d8139ae2807fb26071e75d9', '2020-04-23'),
  ('0ERnYArznxdTBEIj1VSta8', 'man i is', 'No Pressure','https://i.scdn.co/image/ab67616d00001e021c76e29153f29cc1e1b2b434', '2020-07-24')

  INSERT INTO artists VALUES 
  ('4yvcSjfu4PC0CYQyLy4wSq','02MWAaffLxlfxAUY7c5dvx','Glass Animals'),
  ('6LuN9FCkKOj5PcnpouEgny','04QTmCTsaVjcGaoxj8rSjE','Khalid'),
  ('6nS5roXSAGhTGr34W6n7Et','04QTmCTsaVjcGaoxj8rSjE','Disclosure'),
  ('0Y3agQaa6g2r0YmHPOO9rh','04QTmCTsaVjcGaoxj8rSjE','DaVido'),
  ('4xRYI6VqpkE3UwrDrAZL8L','0ERnYArznxdTBEIj1VSta8','Logic')

  INSERT INTO genres VALUES
  (DEFAULT, '4yvcSjfu4PC0CYQyLy4wSq', 'gauze pop;indietronica;shiver pop'),
  (DEFAULT, '6LuN9FCkKOj5PcnpouEgny', 'pop;pop r&b'),
  (DEFAULT, '6nS5roXSAGhTGr34W6n7Et', 'house;pop;tropical house;uk dance'),
  (DEFAULT, '0Y3agQaa6g2r0YmHPOO9rh', 'afropop;ghanaian hip hop;nigerian pop'),
  (DEFAULT, '4xRYI6VqpkE3UwrDrAZL8L', 'conscious hip hop;dmv rap;hip hop;pop rap;rap')
