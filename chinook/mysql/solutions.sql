-- 1. How many songs are there in the playlist "Grunge"?
SELECT COUNT(1) FROM PlaylistTrack pt INNER JOIN Playlist p
  ON pt.PlaylistId=p.PlaylistId WHERE p.`Name` = 'Grunge';


-- 2. Show information about artists whose name includes the text "Jack" and about artists whose name
--    includes the text "John", but not the text "Martin".
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
--    bought some song composed by "Miles Davis" in "MPEG Audio File" format.
SELECT Phone FROM Employee em WHERE em.EmployeeId IN (
SELECT DISTINCT e.ReportsTo FROM Employee e
  INNER JOIN Customer c ON c.SupportRepId = e.EmployeeId
  INNER JOIN Invoice iv ON iv.CustomerId = c.CustomerId
  INNER JOIN InvoiceLine ivl ON iv.InvoiceId = ivl.InvoiceId
  INNER JOIN Track t ON t.TrackId = ivl.TrackId
  INNER JOIN MediaType mt ON mt.MediaTypeId = t.MediaTypeId
  WHERE Composer = 'Miles Davis' AND mt.name='MPEG audio file'
  GROUP BY iv.InvoiceId);


-- 5. Show the information, without repeated records, of all albums that feature songs of the "Bossa Nova"
--    genre whose title starts by the word "Samba".
SELECT a.* FROM Album a
  INNER JOIN Track t ON t.AlbumId = a.AlbumId
  INNER JOIN Genre g ON g.GenreId=t.GenreId
  WHERE g.name = 'Bossa Nova' AND t.Name LIKE 'Samba%'
  GROUP BY t.AlbumId;


-- 6. For each genre, show the average length of its songs in minutes (without indicating seconds). Use the
--    headers "Genre" and "Minutes", and include only genres that have any song longer than half an hour.
select g.Name Genre, AVG(t.Milliseconds) DIV 60000 Minutes FROM Genre g
  INNER JOIN Track t on t.GenreId=g.GenreId
  WHERE t.Milliseconds > 30 * 60000
  GROUP BY g.GenreId;


-- 7. How many client companies have no state?
SELECT COUNT(1) FROM Customer WHERE Company IS NOT NULL AND State IS NULL;


-- 8. For each employee with clients in the "USA", "Canada" and "Mexico" show the number of clients from
--    these countries s/he has given support, only when this number is higher than 6. Sort the query by
--    number of clients. Regarding the employee, show his/her first name and surname separated by a
--    space. Use "Employee" and "Clients" as headers.
SELECT COUNT(c.Country) Clients, CONCAT(e.FirstName, ' ', e.LastName) Employee, c.Country FROM Employee e
  INNER JOIN Customer c ON c.SupportRepId = e.EmployeeId
  WHERE c.Country IN ('USA', 'Canada', 'Mexico')
  GROUP BY c.Country HAVING clients > 6
  ORDER BY Clients;


-- 9. For each client from the "USA", show his/her surname and name (concatenated and separated by a
--    comma) and their fax number. If they do not have a fax number, show the text "S/he has no fax". Sort
--    by surname and first name.
SELECT CONCAT(FirstName, ',', LastName) Customer, IFNULL(Fax, 'S/he has no fax') Fax FROM Customer
  WHERE Country = 'USA' ORDER BY Customer;


-- 10. For each employee, show his/her first name, last name, and their age at the time they were hired.

-- This solution should account for leap years
SELECT FirstName, LastName, TIMESTAMPDIFF(YEAR, BirthDate, HireDate) FROM Employee;
