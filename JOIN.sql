/*1-й запрос*/
SELECT name,  COUNT(*)
  FROM genre
  	   JOIN artistsgenre 
  	     ON genre.genre_id = artistsgenre.genre_id
 GROUP BY name;

/*2-й запрос*/
SELECT COUNT(release_date)  
  FROM tracks
	   JOIN albums 
	     ON tracks.album_id = albums.album_id
 WHERE release_date BETWEEN '01.01.2019' AND '31.12.2020'

 /*3-й запрос*/
SELECT albums."name", tracks.album_id, AVG(duration) 
  FROM tracks
	   JOIN albums 
	     ON tracks.album_id = albums.album_id
 GROUP BY tracks.album_id, albums."name" ;

/*4-й запрос*/
SELECT name 
  FROM artists 
 WHERE name NOT IN 
 	   (SELECT artists."name" 
 	      FROM artists 	      
		  JOIN artistsalbums 
		    ON artists.artist_id = artistsalbums.artist_id		    
		  JOIN albums 
		    ON artistsalbums.album_id = albums.album_id		    
		 WHERE release_date BETWEEN '01.01.2020' AND '31.12.2020');

/*5-й запрос*/
SELECT DISTINCT collections.name 
  FROM collections
	   JOIN colectionstracks 
	     ON collections.collection_id = colectionstracks.collection_id	     
	   JOIN tracks 
	     ON colectionstracks.track_id = tracks.track_id	     
	   JOIN albums 
	     ON tracks.album_id = albums.album_id	     
	   JOIN artistsalbums 
	   	 ON albums.album_id = artistsalbums.album_id	   	 
	   JOIN artists 
	     ON artistsalbums.artist_id = artists.artist_id	     
 WHERE artists.name LIKE 'Melanie Martinez';

/*6-й запрос*/
SELECT albums.name, COUNT(artistsgenre.genre_id), artistsgenre.artist_id 
  FROM albums
	   JOIN artistsalbums 
	     ON albums.album_id = artistsalbums.album_id	     
	   JOIN artists 
	     ON artistsalbums.artist_id = artists.artist_id	     
	   JOIN artistsgenre 
	     ON artists.artist_id = artistsgenre.artist_id	     
 GROUP BY artistsgenre.artist_id, albums."name" 
HAVING COUNT(artistsgenre.genre_id) > 1;

/*7-й запрос*/
SELECT tracks."name" 
  FROM tracks
	   LEFT OUTER JOIN colectionstracks 
	                ON tracks.track_id = colectionstracks.track_id
 WHERE colectionstracks.collection_id IS NULL;

/*8-й запрос*/
SELECT artists."name" 
  FROM artists  
	   JOIN artistsalbums 
	     ON artists.artist_id = artistsalbums.artist_id	     
	   JOIN albums 
	     ON artistsalbums.album_id = albums.album_id	     
	   JOIN tracks 
	     ON albums.album_id = tracks.album_id	     
 WHERE tracks.duration = 
	   (SELECT MIN(duration) 
	      FROM tracks);

/*9-й запрос*/
SELECT albums."name", COUNT(albums."name")  
  FROM albums  
	   JOIN tracks 
	     ON albums.album_id = tracks.album_id 
 GROUP BY albums.album_id 
HAVING COUNT(albums."name") = 
	   (SELECT MIN(min_count) 
		  FROM 
		  	   (SELECT COUNT(album_id) min_count 
				  FROM tracks 
				 GROUP BY album_id) AS foo);
				
/*ѕредложенна€ ¬ами реализаци€ 9го запроса*/
SELECT albums."name", COUNT(tracks."name") 
  FROM albums
	   JOIN tracks 
	     ON albums.album_id = tracks.album_id 
 GROUP BY albums."name" 
HAVING COUNT(tracks."name") = 
	   (SELECT COUNT(tracks."name") 
		  FROM albums 
			   JOIN tracks 
			     ON albums.album_id = tracks.album_id 
		 GROUP BY albums."name"
		 ORDER BY COUNT(tracks."name")
		 LIMIT 1);