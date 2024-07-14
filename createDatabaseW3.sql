-- Läuft ohne Fehler durch
DROP TABLE Artifacts;
DROP TABLE ArtifactPaintings;
DROP TABLE ArtifactSculptures;
DROP TABLE Artists;
DROP TABLE Collections;
DROP TABLE Exhibitions;
DROP TABLE Advertisements;
DROP TABLE Media;
DROP TABLE InfluencedBy;
DROP TABLE ExhibitedAt;

CREATE TABLE Artifacts (
    id INT PRIMARY KEY,
    title VARCHAR(420) NOT NULL,
    description TEXT,
    value DECIMAL(42,2),
    year INT,
    artistId INT,
    collectionTitle VARCHAR(420),
    collectionDate VARCHAR(420)
);

CREATE TABLE ArtifactPaintings (
    id INT PRIMARY KEY,
    canvas VARCHAR(42) NOT NULL
);

CREATE TABLE ArtifactSculptures (
    id INT PRIMARY KEY,
    material VARCHAR(42),
    color VARCHAR(42)
);

CREATE TABLE Artists (
    id INT PRIMARY KEY,
    name VARCHAR(42) NOT NULL,
    birthDate DATE,
    deathDate DATE,
    bio TEXT UNIQUE
);

CREATE TABLE Collections (
    title VARCHAR(42) PRIMARY KEY,
    topic VARCHAR(42)
);

CREATE TABLE Exhibitions (
    title VARCHAR(42) PRIMARY KEY,
    topic VARCHAR(42),
    room VARCHAR(42),
    startDate DATE,
    endDate DATE
);

CREATE TABLE Advertisements (
    exhibitionTitle VARCHAR(42),
    date DATE,
    mediumName VARCHAR(42), 
    cost DECIMAL(10,2),
    duration INT,
    PRIMARY KEY (exhibitionTitle, date, mediumName)
);

CREATE TABLE Media (
    name VARCHAR(42) PRIMARY KEY,
    type VARCHAR(42)
);

CREATE TABLE InfluencedBy (
    influenceeId INT,
    influencerId INT, 
    PRIMARY KEY (influenceeId, influencerId)
);

CREATE TABLE ExhibitedAt (
    artifactId INT,
    exhibitionTitle VARCHAR(42),
    PRIMARY KEY ( artifactId, exhibitionTitle)
);