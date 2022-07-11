INSERT INTO albums (album_id ,Name, release_date)
VALUES (1,'Teenage Dream', '01.01.2010'),
	(2,'The Bass', '08.06.2018'),
	(3,'You Make It Feel Like Christmas', '22.10.2020'),
	(4,'Make Me Like You', '21.04.2016'),
	(5,'BOOM.', '07.04.2018'),
	(6,'Lover', '21.09.2019'),
	(7,'Positions', '28.10.2020'),
	(8,'Dangerous Woman', '01.04.2016'),
	(9,'As She Pleases', '01.02.2018'),
	(10,'Cry Baby', '14.08.2015'),
	(11,'K-12', '24.09.2020');

INSERT INTO tracks (track_id,Name, duration, album_id)
VALUES (1,'Firework', '0:3:48', 1),
	(2,'Pearl', '0:4:07', 1),
	(3,'Bass Has Got Me On', '0:5:36', 2),
	(4,'My Gift is You', '0:3:06', 3),
	(5,'Sleigh Ride', '0:4:20', 3),
	(6,'Make Me Like You', '0:3:36', 4),
	(7,'Dont Even Try', '0:3:30', 5),
	(8,'Happy', '0:3:37', 5),
	(9,'Cruel Summer', '0:3:40', 6),
	(10,'Paper Rings', '0:5:02', 6),
	(11,'My Hair', '0:3:20', 7),
	(12,'Positions', '0:4:40', 7),
	(13,'Moonlight', '0:3:58', 8),
	(14,'Sometimes', '0:4:12', 8),
	(15,'Say It To My Face', '0:4:24', 9),
	(16,'Fools', '0:3:58', 9),
	(17,'Cry Baby', '0:4:37', 10),
	(18,'Carousel', '0:4:20', 10),
	(19,'Pacify Her', '0:4:23', 10),
	(20,'Filed Trip', '0:3:28', 11),
	(21,'Notebook', '0:5:17', 11),
	(22,'Detention', '0:4:27', 11);

INSERT INTO genre (Name)
VALUES ('Pop'),
	('Dance'),
	('Hip-Hop'),
	('Rock'),
	('Indie'),
	('RnB'),
	('Country');

INSERT INTO artists (Name)
VALUES ('Katy Perry'),
	('Fergie'),
	('Gwen Stefany'),
	('Rihanna'),
	('Taylor Swift'),
	('Ariana Grande'),
	('Madison Beer'),
	('Melanie Martinez');

INSERT INTO collections (Name, realease_date)
VALUES ('One', '02.02.2017'),
	('Two', '03.02.2018'),
	('Three', '05.07.2019'),
	('Four', '23.05.2020'),
	('Five', '04.09.2016'),
	('Six', '12.12.2019'),
	('Seven', '28.11.2021'),
	('Eight', '24.12.2018');

INSERT INTO artistsalbums (album_id, artist_id)
VALUES (1, 1),
	(2, 2),
	(3, 3),
	(4, 3),
	(5, 4),
	(6, 5),
	(7, 6),
	(8, 6),
	(9, 7),
	(10, 8),
	(11, 8);

INSERT INTO artistsgenre (genre_id, artist_id)
VALUES (1, 1),
	(1, 2),
	(2, 1),
	(2, 2),
	(3, 2),
	(4, 3),
	(1, 3),
	(3, 4),
	(1, 4),
	(4, 8),
	(5, 2),
	(5, 4),
	(6, 5);

INSERT INTO colectionstracks (collection_id, track_id)
VALUES (1, 1),
	(1, 2),
	(2, 6),
	(2, 13),
	(2, 14),
	(3, 3),
	(3, 15),
	(3, 16),
	(4, 1),
	(4, 2),
	(4, 3),
	(5, 1),
	(5, 2),
	(5, 17),
	(5, 18),
	(5, 19),
	(6, 9),
	(6, 10),
	(7, 20),
	(7, 21),
	(7, 22),
	(8, 7),
	(8, 8);

