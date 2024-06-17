-- Getting most of this to run without errors was quite hard. 
-- Thats why most test and/or good examples are missng

-- Excercise 1 and 3 i

CREATE TABLE Artists (
  id INT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  birthDate DATE CHECK (birthDate < '2025-01-01'),
  deathDate DATE,
  bio TEXT UNIQUE,
  CHECK (birthDate < deathDate OR deathDate IS NULL)
);

CREATE TABLE InfluencedBy (
  influencerId INT NOT NULL,
  influenceeId INT NOT NULL,
  PRIMARY KEY(influencerId, influenceeId),
  FOREIGN KEY (influencerId) REFERENCES Artists(id)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  FOREIGN KEY (influenceeId) REFERENCES Artists(id)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);
/*
Everything should be cascaded. When the database doesnt care about an artist anymore, 
it doesnt care about his influences too.
*/

CREATE TABLE Exhibitions (
  title VARCHAR(255) PRIMARY KEY,
  topic VARCHAR(255) NOT NULL,
  room VARCHAR(255) NOT NULL,
  startDate DATE NOT NULL,
  endDate DATE,
  CHECK (startDate < endDate or endDate IS NULL)
);

CREATE TABLE Media (
  name VARCHAR(255) PRIMARY KEY,
  typ VARCHAR(255)
);

CREATE TABLE Advertisements (
  exhibitionTitle VARCHAR(255),
  date DATE,
  mediumName VARCHAR(255),
  cost DECIMAL(10,2) CHECK (cost>=0),
  duration INT,
  PRIMARY KEY (exhibitionTitle, date, mediumName),
  FOREIGN KEY (exhibitionTitle) REFERENCES Exhibitions(title)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  FOREIGN KEY (mediumName) REFERENCES Media(name)
  ON DELETE RESTRICT
  ON UPDATE CASCADE
);
/*
Deletion of the medium should be restricted, since the advertisments needs a medium.
Everything else can be cascaded.
*/

CREATE TABLE Collections (
  title VARCHAR(255) PRIMARY KEY,
  topic VARCHAR(255) NOT NULL
);

CREATE TABLE Artifacts (
  id INT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  year INT CHECK (year <= 2024),                
  value DECIMAL(10,2) CHECK (value >= 0),       
  artistId INT,
  collectionDate DATE,
  collectionTitle VARCHAR(255),
  FOREIGN KEY (collectionTitle) REFERENCES Collections(title)
  ON DELETE SET NULL
  ON UPDATE CASCADE,
  FOREIGN KEY (artistId) REFERENCES Artists(id) 
  ON DELETE RESTRICT 
  ON UPDATE CASCADE 
);
/*
It shouldn't be possible to delete artists that have created artifacts in the museum. 
If the artist id changes, the update should just cascade.
If a collection disappears, the artifact doesnt belong to a collection anymore.
If the title of a collection is updated, the artifacts still belong to the collection -> Update the title
*/

CREATE TABLE ExhibitedAt (
  artifactId INT,
  exhibitionTitle VARCHAR(255),
  PRIMARY KEY (artifactId, exhibitionTitle),
  FOREIGN KEY (artifactId) REFERENCES Artifacts(id)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  FOREIGN KEY (exhibitionTitle) REFERENCES Exhibitions(title)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);
/*
Everything should be cascaded. If an artifact or an exhibiton gets updated/deleted, 
the correspondig rows should change too.
*/

CREATE TABLE ArtifactPaintings (
  id INT PRIMARY KEY,
  canvas VARCHAR(255),
  FOREIGN KEY (id) REFERENCES Artifacts(id)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

CREATE TABLE ArtifactSculptures (
  id INT PRIMARY KEY,
  material VARCHAR(255),
  color VARCHAR(255),
  FOREIGN KEY (id) REFERENCES Artifacts(id)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);
/*
Both paintings and sculptures only exist to store additional data about their corresponding artifact.
Thus both updating and deletion should be cascasded. 
*/