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