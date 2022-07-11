SELECT Name, Release_date
FROM albums
WHERE release_date BETWEEN '01.01.2018' AND '31.12.2018';

SELECT Name, Duration
FROM tracks
ORDER BY duration DESC 
LIMIT 1;

SELECT Name
FROM tracks
WHERE duration > '0:3:30';

SELECT Name
FROM collections
WHERE realease_date BETWEEN '01.01.2018' AND '31.12.2020';

SELECT Name
FROM artists
WHERE Name NOT LIKE '% %';

SELECT Name
FROM tracks
WHERE Name LIKE '% My %';