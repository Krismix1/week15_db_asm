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
