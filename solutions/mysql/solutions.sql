-- 1. How many songs are there in the playlist “Grunge”?
SELECT COUNT(1) FROM PlaylistTrack pt INNER JOIN Playlist p
  ON pt.PlaylistId=p.PlaylistId WHERE p.`Name` = 'Grunge';


-- 2. Show information about artists whose name includes the text “Jack” and about artists whose name
--    includes the text “John”, but not the text “Martin”.
SELECT * FROM Artist
  WHERE `name` LIKE '%Jack%'
  OR (`name` LIKE '%John%' AND `name` NOT LIKE '%Martin%');


-- 3. For each country where some invoice has been issued, show the total invoice monetary amount, but
--    only for countries where at least $100 have been invoiced. Sort the information from higher to lower
--    monetary amount.
SELECT SUM(Total) AS total_per_country, BillingCountry
  FROM Invoice
  GROUP BY BillingCountry HAVING total_per_country >= 100
  ORDER BY total_per_country DESC;


-- 4. Get the phone number of the boss of those employees who have given support to clients who have
--    bought some song composed by “Miles Davis” in “MPEG Audio File” format.
SELECT Phone FROM Employee em WHERE em.EmployeeId IN (
SELECT DISTINCT e.ReportsTo FROM Employee e
  INNER JOIN Customer c ON c.SupportRepId = e.EmployeeId
  INNER JOIN Invoice iv ON iv.CustomerId = c.CustomerId
  INNER JOIN InvoiceLine ivl ON iv.InvoiceId = ivl.InvoiceId
  INNER JOIN Track t ON t.TrackId = ivl.TrackId
  INNER JOIN MediaType mt ON mt.MediaTypeId = t.MediaTypeId
  WHERE Composer = 'Miles Davis' AND mt.name='MPEG audio file'
  GROUP BY iv.InvoiceId);


-- 5. Show the information, without repeated records, of all albums that feature songs of the “Bossa Nova”
--    genre whose title starts by the word “Samba”.
SELECT a.* FROM Album a
  INNER JOIN Track t ON t.AlbumId = a.AlbumId
  INNER JOIN Genre g ON g.GenreId=t.GenreId
  WHERE g.name = 'Bossa Nova' AND t.Name LIKE 'Samba%'
  GROUP BY t.AlbumId;
