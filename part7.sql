
--List the films where the yr is 1962 [Show id, title]
1.
SELECT id, title
 FROM movie
 WHERE yr=1962;

--When was Citizen Kane released
2.
 SELECT yr
FROM movie
WHERE title='Citizen Kane';


--List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
3.SELECT id,title,yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;


--What id number does the actor 'Glenn Close' have
4.
SELECT id
FROM actor
WHERE name='Glenn Close';


--what is the id of the film 'Casablanca'
5.
SELECT id
FROM movie
WHERE title='Casablanca'


--obtain the cast list for 'Casablanca'
6.
SELECT name
FROM actor JOIN casting ON actor.id=casting.actorid
WHERE movieid=11768;


--obtain the cast list for the film 'Alien'
7.
SELECT name
FROM actor JOIN casting ON actor.id=casting.actorid
JOIN movie ON movie.id=casting.movieid
WHERE title='Alien';

--list the films in which 'Harrison Ford' has appeared
8.
SELECT title
FROM movie JOIN casting ON movie.id=casting.movieid
JOIN actor on actor.id=casting.actorid
WHERE name='Harrison Ford';

--List the films where 'Harrison Ford' has appeared - but not in the starring role.
9.
SELECT title
FROM movie JOIN casting ON movie.id=casting.movieid
JOIN actor ON actor.id=casting.actorid
WHERE ord<>1 AND name='Harrison Ford';


--List the films together with the leading star for all 1962 films.
10.
SELECT title,name
FROM movie JOIN casting ON movie.id=casting.movieid
JOIN actor ON actor.id=casting.actorid
WHERE yr=1962 AND ord=1;


--show year and number of movies made by 'Rock Hudson' each year for any year in which he made more then 2 movies.
11.
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;


--ist the film title and the leading actor for all of the films 'Julie Andrews' played in
12.
SELECT title, name
  FROM movie, casting, actor
  WHERE movieid=movie.id
    AND actorid=actor.id
    AND ord=1
    AND movieid IN
    (SELECT movieid FROM casting, actor
     WHERE actorid=actor.id
     AND name='Julie Andrews');

--Obtain a list, in alphabetical order, of actors whove had at least 15 starring roles
13.
SELECT name
FROM actor JOIN casting ON actor.id=casting.actorid
WHERE ord=1 
GROUP BY name
HAVING COUNT(movieid)>=15;

--List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
14.
SELECT title, COUNT(actorid)
FROM movie JOIN casting ON movie.id = movieid 
WHERE yr = 1978
GROUP BY title ORDER BY COUNT(actorid) DESC, title;


--List all of the people who have worked with 'Art Garfunkel'
15.
SELECT distinct actor.name
FROM movie
JOIN casting
ON casting.movieid = movie.id
JOIN actor
ON actor.id = casting.actorid
where movie.id in (select movieid from casting join actor on id =actorid where 
actor.name = 'Art Garfunkel') and actor.name <> 'Art Garfunkel'