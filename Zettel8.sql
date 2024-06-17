
-- where is a museum.sql file provided???

-- Exercise 1:



-- Exercise 2

-- Example 1
-- Creating a view to see all the influencers for all the artists:
CREATE MATERIALIZED VIEW ArtistInfluences AS
SELECT a1.name AS ArtistName, a2.name AS InfluencerName
FROM Artists a1
-- Joining the Artists with the InfluencedBy Table, with each artist having n copies
-- for the n other artists that influenced them (i.e. artist id must equal influencee id)
JOIN InfluencedBy ON a1.id = InfluencedBy.influenceeId
-- Joining that again with artists, to get the name of the influencers
-- in addition to their ids 
JOIN Artists a2 ON InfluencedBy.influencerId = a2.id;

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

-- Exercsie 3 
-- Part ii) 
-- adding artifact to an exhibition is not allowed if the dates of two exhibitions overlap
CREATE TRIGGER ArtifactOverlap
AFTER INSERT ON ExhibitedAt 
FOR EACH ROW
BEGIN
    -- idk
END;

-- Part iii)
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

-- Part iv)
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








