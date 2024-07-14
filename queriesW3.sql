-- Nr.1
SELECT title, value
FROM Artifacts
WHERE value >= 100000
ORDER BY value;

-- Nr.2
SELECT DISTINCT collectionTitle
FROM Artifacts
WHERE title LIKE '%sun%';

-- Nr.3
SELECT COUNT(*)
FROM Advertisements
WHERE exhibitionTitle = 'Dutch painters' AND mediumName = 'Daily Planet';

-- Nr.4
SELECT influencerId
FROM InfluencedBy
GROUP BY influencerId
HAVING COUNT(influenceeId) >= 10;

-- Nr.5
SELECT mediumName, AVG(cost)
FROM Advertisements
GROUP BY mediumName;

-- Nr.6
SELECT title, topic
FROM Exhibitions
WHERE startDate >= '2017-06-01' AND endDate <= '2017-12-31';