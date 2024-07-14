DELETE FROM Artifacts;
DELETE FROM Collections;
DELETE FROM Exhibitions;
DELETE FROM Advertisements;
DELETE FROM Media;
DELETE FROM InfluencedBy;

INSERT INTO Artifacts VALUES (1, 'Scheißendes Einhorn', NULL, 500.00, NULL, NULL, NULL, NULL);
INSERT INTO Artifacts VALUES (2, 'Graziles Stinktier', NULL, 10000002.00, NULL, NULL, NULL, NULL);
INSERT INTO Artifacts VALUES (3, 'Graziles Stinktier2', NULL, 20000003.00, NULL, NULL, NULL, NULL);
INSERT INTO Artifacts VALUES (4, 'Graziles Stinktier3', NULL, 10000004.00, NULL, NULL, NULL, NULL);

INSERT INTO Collections VALUES('Sunny Artifacts 1', NULL);
INSERT INTO Collections VALUES('Sunny Artifacts 2', NULL);
INSERT INTO Collections VALUES('Sonny Artifacts 3', NULL);

INSERT INTO Artifacts VALUES (5, 'Sun1', NULL, 10000004.00, NULL, NULL, 'Sunny Artifacts 1', NULL);
INSERT INTO Artifacts VALUES (6, 'Sun2', NULL, 10000004.00, NULL, NULL, 'Sunny Artifacts 1', NULL);
INSERT INTO Artifacts VALUES (7, 'sun3', NULL, 10000004.00, NULL, NULL, 'Sunny Artifacts 2', NULL);
INSERT INTO Artifacts VALUES (8, 'Sun4', NULL, 10000004.00, NULL, NULL, 'Sunny Artifacts 2' , NULL);
INSERT INTO Artifacts VALUES (9, 'Son5', NULL, 10000004.00, NULL, NULL, 'Sonny Artifacts 3' , NULL);

INSERT INTO Media VALUES ('Daily Planet', NULL);

INSERT INTO Exhibitions VALUES ('Dutch painters',   'Nice paintes', NULL, '2017-06-01','2017-06-25');
INSERT INTO Exhibitions VALUES ('Dutch painters 1', 'Nice paintes', NULL, '2017-06-01','2017-06-25');
INSERT INTO Exhibitions VALUES ('Dutch painters 2', 'Nice paintes', NULL, '2017-05-01','2017-06-25');
INSERT INTO Exhibitions VALUES ('Dutch painters 3', 'Nice paintes', NULL, '2017-06-01','2024-07-01');
INSERT INTO Exhibitions VALUES ('Dutch painters 4', 'Nice paintes', NULL, '2024-05-01','2024-07-01');

INSERT INTO Advertisements VALUES ('Dutch painters', '2024-07-14', 'Daily Planet', 0, NULL);
INSERT INTO Advertisements VALUES ('Dutch painters', '2024-07-15', 'Daily Planet', 42, NULL);
INSERT INTO Advertisements VALUES ('Dutch painters', '2024-07-16', 'Daily Planet', 84, NULL);
INSERT INTO Advertisements VALUES ('Dutch painters', '2024-07-16', 'Weekly Planet', 21, NULL);

INSERT INTO InfluencedBy VALUES (2,1);
INSERT INTO InfluencedBy VALUES (3,1);
INSERT INTO InfluencedBy VALUES (4,1);
INSERT INTO InfluencedBy VALUES (5,1);
INSERT INTO InfluencedBy VALUES (6,1);
INSERT INTO InfluencedBy VALUES (7,1);
INSERT INTO InfluencedBy VALUES (8,1);
INSERT INTO InfluencedBy VALUES (9,1);
INSERT INTO InfluencedBy VALUES (10,1);
INSERT INTO InfluencedBy VALUES (11,1);
INSERT INTO InfluencedBy VALUES (12,1);
INSERT INTO InfluencedBy VALUES (1,2);
INSERT INTO InfluencedBy VALUES (2,2);
INSERT INTO InfluencedBy VALUES (3,2);
INSERT INTO InfluencedBy VALUES (4,2);
INSERT INTO InfluencedBy VALUES (5,2);