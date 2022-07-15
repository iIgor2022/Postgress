SELECT name,  COUNT(*)
FROM genre
JOIN artistsgenre ON genre.genre_id = artistsgenre.genre_id
GROUP BY name;

SELECT COUNT(release_date)  FROM tracks
JOIN albums ON tracks.album_id = albums.album_id
WHERE release_date BETWEEN '01.01.2019' AND '31.12.2020'

SELECT albums."name", tracks.album_id, AVG(duration) FROM tracks
JOIN albums ON tracks.album_id = albums.album_id
GROUP BY tracks.album_id, albums."name" ;

SELECT artists."name", release_date FROM artists
JOIN artistsalbums ON artists.artist_id = artistsalbums.artist_id
JOIN albums ON artistsalbums.album_id = albums.album_id
WHERE release_date NOT BETWEEN '01.01.2020' AND '31.12.2020';

SELECT DISTINCT collections.name FROM collections
JOIN colectionstracks ON collections.collection_id = colectionstracks.collection_id
JOIN tracks ON colectionstracks.track_id = tracks.track_id
JOIN albums ON tracks.album_id = albums.album_id
JOIN artistsalbums ON albums.album_id = artistsalbums.album_id
JOIN artists ON artistsalbums.artist_id = artists.artist_id
WHERE artists.name LIKE 'Melanie Martinez';

SELECT albums.name, COUNT(artistsgenre.genre_id), artistsgenre.artist_id FROM albums
JOIN artistsalbums ON albums.album_id = artistsalbums.album_id
JOIN artists ON artistsalbums.artist_id = artists.artist_id
JOIN artistsgenre ON artists.artist_id = artistsgenre.artist_id
GROUP BY artistsgenre.artist_id, albums."name" 
HAVING COUNT(artistsgenre.genre_id) > 1;

SELECT tracks."name" FROM tracks
LEFT OUTER JOIN colectionstracks ON tracks.track_id = colectionstracks.track_id
WHERE colectionstracks.collection_id IS NULL;

SELECT MIN(artists."name"), MIN(tracks.duration) FROM artists
JOIN artistsalbums ON artists.artist_id = artistsalbums.artist_id
JOIN albums ON artistsalbums.album_id = albums.album_id
JOIN tracks ON albums.album_id = tracks.album_id;

SELECT albums."name", COUNT(albums."name")  FROM albums
JOIN tracks ON albums.album_id = tracks.album_id 
GROUP BY albums.album_id 
HAVING COUNT(albums."name") = (SELECT MIN(min_count) FROM (SELECT COUNT(album_id) min_count FROM tracks GROUP BY album_id) AS foo); 