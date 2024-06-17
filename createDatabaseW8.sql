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


--  Part 3 ii
CREATE TRIGGER ArtifactOverlap
  BEFORE INSERT ON ExhibitedAt 
  FOR EACH ROW
  BEGIN
      -- idk
  END;


-- Part 3 iii
CREATE TRIGGER move_artifacts_on_collection_delete
BEFORE DELETE ON Collections
FOR EACH ROW
BEGIN
  UPDATE Artifacts
  -- Changing Collection Name if the currnt collection is deleted
  SET collectionTitle = 'General paintings'
  WHERE collectionTitle = OLD.title
    -- Check if the id is in Paintings
    AND id IN (SELECT a.id FROM Artifacts a
               JOIN ArtifactPaintings ap ON a.id = ap.id
               WHERE a.collectionTitle = OLD.title);

    -- Update sculptures
    UPDATE Artifacts
    -- Changing Collection Name if the currnt collection is deleted
    SET collectionTitle = 'General sculptures'
    WHERE collectionTitle = OLD.title
      -- Check if the id is in Sculptures
      AND id IN (SELECT a.id FROM Artifacts a
                 JOIN ArtifactSculptures asculp ON a.id = asculp.id
                 WHERE a.collectionTitle = OLD.title);
END;


-- Part 3 iv
-- keeping track of advertising cost every artifact has received
CREATE TRIGGER money_spend_on_advertisments
-- cost increases after each new add
AFTER INSERT ON Advertisements
FOR EACH ROW
BEGIN
  -- Increase the cost by the amount of the cost of the new add
  UPDATE AdPerArtifact SET cost = cost + NEW.cost
  -- for those artifacts whose id is listed in the exhibition 
  WHERE id IN (SELECT exhibat.artifactId FROM ExhibitedAt exihbat
              WHERE exhibat.exhibitionTitle = NEW.exhibitionTitle
)
END;



-- Exercise 2

-- Example 1
-- Creating a view to see all the influencers for all the artists:
CREATE VIEW ArtistInfluences AS
SELECT a1.name AS ArtistName
FROM Artists AS a1
-- Joining the Artists with the InfluencedBy Table, with each artist having n copies
-- for the n other artists that influenced them (i.e. artist id must equal influencee id)
JOIN InfluencedBy AS a2 ON a1.id = a2.influenceeId;

/* This one should be materilaized since the Artists
   and InfluencedBy Tables should rarely chnage so that frequent
   recomputition isn't really an issue 
   On the other hand this decreases the runtime for queries because
   we don't have to repeat the two inner joins over and over again*/
   
-- Example for a querie: Find all the influencers on Van Gogh
SELECT *
FROM ArtistInfluences
WHERE ArtistName = 'Vincent van Gogh';


-- Example 2 
/* Creating a view to see the age of the collections by taking the 
   the average year of the artifacts in them */
CREATE VIEW CollectionAverageYear AS
SELECT collectionTitle, AVG(year) AS averageYear
FROM Artifacts
-- Group by title to calculate the average of the year of the artifact per collection
GROUP BY collectionTitle;


-- Example for a querie: Find the oldest collection
SELECT collectionTitle
FROM CollectionAverageYear
WHERE AverageYear = (SELECT MIN(AverageYear) FROM CollectionAverageYear);