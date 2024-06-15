/*Part 1: Upper half of the diagram: */

CREATE TABLE Collections (
  /*Title is used as primary Key*/
  title VARCHAR(255) PRIMARY KEY,
  /*Every Collection should have an entry at topic since they are organised by humans*/
  topic VARCHAR(255) NOT NULL
);

/* Creating the Artifact Table*/
CREATE TABLE Artifacts (
  /* id as primary key*/
  id INT PRIMARY KEY,
  /*VARCHAR used for title since the title length 
  can differ but should in general be short phrase at most.
  Also every artefact should at least have a title, i.e. Not Null*/
  title VARCHAR(255) NOT NULL,
  /*Text is used for description because its length is unkown.
  Also every artefact should have at least a short description*/
  description TEXT NOT NULL,
  /*Int is used for year since it is felxible enough and
  allows to represent years BC with negative numbers.
  The year could be unkown*/
  year INT,
  /*DECIMAL is used for best precission
  while making sure that it is given in
  a form of x Euros and y Cents.
  The value could be unkown*/
  value DECIMAL(10,2),
  artistId VARCHAR(255),
  /*The collectionDate can obviously be expressed with the DataType DATE
  It could be unkown*/
  collectionDate DATE,
  /*Reference attribute collectionTitle with the title attribute in Collections*/
  collectionTitle VARCHAR(255),
  FOREIGN KEY (collectionTitle) REFERENCES Collections(title)
);


CREATE TABLE ArtifactPaintings (
  /*The key for the Paintings is the ArtifactId*/
  id INT PRIMARY KEY,
  /*It's unclear how long the canvas information can be, so I use VARCHAR*/
  canvas VARCHAR(255),
  FOREIGN KEY (id) REFERENCES Artifacts(id)
);

CREATE TABLE ArtifactSculptures (
  /*The key for the Paintings is the ArtifactId*/
  id INT PRIMARY KEY,
  /*It's unclear how long the material information can be, so I use VARCHAR*/
  material VARCHAR(255),
  /*Same for the colour*/
  color VARCHAR(255),
  FOREIGN KEY (id) REFERENCES Artifacts(id)
);


CREATE TABLE Artists (
  id INT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  /*Birthdate and deathdate could be unkown (or artist could stillt be alive)
  but can be expressed with DATE DataType*/
  birthDate DATE,
  deathDate DATE,
  /*If a bio exists for an artist it should be unique*/
  bio TEXT UNIQUE
);

CREATE TABLE Influencedby (
  /*Both attributes are references to the id of the artists*/
  id INT PRIMARY KEY,
  influencerId INT NOT NULL,
  influenceeId INT NOT NULL,
  FOREIGN KEY (influencerId) REFERENCES Artists(id),
  FOREIGN KEY (influenceeId) REFERENCES Artists(id)
);


/*Part 2: Lower half of the diagram: */

CREATE TABLE Exhibitions (
  /*All Atributes are NOT NULL because
  they are asigned by humans and should therefore be known*/
  title VARCHAR(255) PRIMARY KEY,
  topic VARCHAR(255) NOT NULL,
  room VARCHAR(255) NOT NULL,
  startDate DATE NOT NULL,
  endDate DATE
);

CREATE TABLE Media (
  name VARCHAR(255) PRIMARY KEY,
  /*type could be unkown*/
  typ VARCHAR(255)
);

CREATE TABLE Advertisements (
  exhibitionTitle VARCHAR(255),
  date DATE,
  mediumName VARCHAR(255),
  /*I'm using the same DataType for money as used for the value of an Artifacts
  cost could still be unkown for example while still in production or ongoing costs*/
  cost DECIMAL(10,2),
  /*Duration given as an integer (i.e. the number of days)
  could be unkown, for example when the ad is still running*/
  duration INT,
  PRIMARY KEY (exhibitionTitle, date, mediumName),
  FOREIGN KEY (exhibitionTitle) REFERENCES Exhibitions(title),
  FOREIGN KEY (mediumName) REFERENCES Media(name)
);

/*Part 3: Combining the two parts*/
CREATE TABLE ExhibitedAt (
  artifactId INT,
  exhibitionTitle VARCHAR(255),
  FOREIGN KEY (artifactId) REFERENCES Artifacts(id),
  FOREIGN KEY (exhibitionTitle) REFERENCES Exhibitions(title)
);

-- show tables;

-- insert
INSERT INTO Collections VALUES ('MyCollection1', 'Tests');
INSERT INTO Collections VALUES ('MyCollection2', 'Tests');
INSERT INTO Collections VALUES ('MyCollection3', 'Tests');
INSERT INTO Artifacts VALUES (01, 'Test1', 'ttTest2', 2014, 100000.01,02, '2000/12/03', 'MyCollection1');
INSERT INTO Artifacts VALUES (02, 'Test2', 'ttTest2', 2012, 101000.00,01, '2000/01/03', 'MyCollection1');
INSERT INTO Artifacts VALUES (03, 'sun', 'sonnig', 2012, 100,03, '2010/01/03', 'MyCollection2');
INSERT INTO Artifacts VALUES (04, 'sunier', 'sonniger', 2020, 1000, 01 ,'2010/01/03', 'MyCollection2');
INSERT INTO Artifacts VALUES (05, 'not sunny', 'bewoelkt', 2020, 1000000,03, '2012/02/03', 'MyCollection1');
INSERT INTO Artifacts VALUES (06, 'Vans painting', 'bewoelkt', 2020,1000000,07, '2012/02/03', 'MyCollection1');
INSERT INTO Artifacts VALUES (07, 'Vans painting 2', 'bewoelkt', 2020,1000000,07, '2012/02/03', 'MyCollection1');

INSERT INTO ArtifactPaintings VALUES (01, 'Good Canvas');
INSERT INTO ArtifactPaintings VALUES (06, 'Good Canvas');
INSERT INTO ArtifactPaintings VALUES (07, 'Nice Canvas');

INSERT INTO ArtifactSculptures VALUES (02, 'niceMaterial', 'Blood red');

INSERT INTO Exhibitions VALUES('Dutch Painters',  'Niederländische Kunst', '3A', '2017/01/01', '2025/01/01');
INSERT INTO Exhibitions VALUES('Dutch Painters 2',  'Niederländische Kunst', '3A', '2025/01/02', '2026/01/01');
INSERT INTO Exhibitions VALUES('German Painters',  'Deutsche Kunst', '3b', '2014/01/01', '2017/09/01');   
INSERT INTO Exhibitions VALUES('English Painters',  'Englische Kunst', '3C-1', '2017/08/01', '2017/11/01');   
INSERT INTO Media VALUES ('Daily Planet', 'Newspaper');
INSERT INTO Media VALUES ('New York Times', 'Newspaper');
INSERT INTO Advertisements VALUES('Dutch Painters', '2024/06/01', 'Daily Planet', 5, 14);
INSERT INTO Advertisements VALUES('German Painters', '2024/06/02', 'Daily Planet', 10, 7);
INSERT INTO Advertisements VALUES('Dutch Painters', '2024/06/03', 'New York Times', 15, 7);

INSERT INTO ExhibitedAt VALUES(06, 'Dutch Painters');
INSERT INTO ExhibitedAt VALUES(06, 'Dutch Painters 2');
INSERT INTO ExhibitedAt VALUES(02, 'Dutch Painters');

INSERT INTO Artists VALUES(01, 'Da Vinci', NULL, NULL, 'He died in Italy.');
INSERT INTO Artists VALUES(02, 'Aristoteles', NULL, NULL, NULL);
INSERT INTO Artists VALUES(03, 'Caesar', NULL, NULL, NULL);
INSERT INTO Artists VALUES(04, 'Erik', NULL, NULL, NULL);
INSERT INTO Artists VALUES(05, 'Philipp', NULL, NULL, NULL);
INSERT INTO Artists VALUES(06, 'Tiago', NULL, NULL, NULL);
INSERT INTO Artists VALUES(07, 'Vincent Van Gogh', NULL, NULL, NULL);

INSERT INTO Influencedby VALUES (1000, 01, 04);
INSERT INTO Influencedby VALUES (1001, 02, 05);
INSERT INTO Influencedby VALUES (1002, 02, 06);
INSERT INTO Influencedby VALUES (1003, 02, 03);

INSERT INTO Influencedby VALUES (1004, 02, 04);
INSERT INTO Influencedby VALUES (1005, 03, 05);
INSERT INTO Influencedby VALUES (1006, 03, 06);