/* 1. Show the model, speed, and hard drive capacity of those PCs whose price is lesser than 500 euros. */
SELECT cModel, nSpeed, nHD FROM TPC WHERE nPrice::numeric < 500;

/* 2. Show the model, speed, and screen size of those laptops whose price is over 1000 euros. */
SELECT cModel, nSpeed, nScreenRes FROM TLaptop WHERE nPrice::numeric > 1000;

/* 3. Show the data of all colour printers. */
SELECT * FROM TPrinter WHERE lColour;

/* 4. Show the names of printer providers. */
SELECT DISTINCT prod.cProvider FROM TProduct prod
  INNER JOIN TPrinter prin ON prin.cModel = prod.cModel;

/* 5. Show the provider and speed of those laptops whose hard drive capacity is equal or higher than 10 GB. */
SELECT prod.cProvider, laptop.nSpeed FROM TProduct prod
  INNER JOIN TLaptop laptop ON laptop.cModel = prod.cModel
  WHERE laptop.nHD >= 10;

/* 6. Show the providers of those PCs whose speed is not lower than 450 Mhz. */
SELECT prod.cProvider FROM TProduct prod
  INNER JOIN TPC pc ON pc.cModel = prod.cModel
  WHERE pc.nSpeed >= 450;

/* 7. Show the model, speed, and hard drive capacity of those PCs whose CD is 12x and whose price is less
      than 600 euros, or of those PCs whose CD is 24x and whose price is less than 600 euros. Write the SQL
      sentence in three different ways. */
SELECT cModel, nSpeed, nHD FROM TPC
  WHERE (cCD = '12x' AND nPrice::numeric < 600) OR (cCD = '24x' AND nPrice::numeric < 600);

SELECT cModel, nSpeed, nHD FROM TPC
  WHERE (cCD = '12x' OR cCD = '24x') AND nPrice::numeric < 600;

SELECT cModel, nSpeed, nHD FROM TPC
  WHERE cCD IN ('12x', '24x') AND nPrice::numeric < 600;

/* 8. Show the average speed of those PCs sold by the provider named "InfoChip". */
SELECT AVG(nSpeed) FROM TPC p, TProduct pr
  WHERE p.cModel = pr.cModel AND pr.cProvider = 'InfoChip';

/* 9. Show the models and prices of those products whose provider is "InfoChip". */
SELECT TProduct.cModel, TPC.nPrice
  FROM TProduct INNER JOIN TPC
  ON TProduct.cModel = TPC.cModel
  WHERE TProduct.cProvider = 'InfoChip'
UNION
  (SELECT TProduct.cModel, TLaptop.nPrice
  FROM TProduct INNER JOIN TLaptop
  ON TProduct.cModel = TLaptop.cModel
  WHERE TProduct.cProvider = 'InfoChip')
UNION
  (SELECT TProduct.cModel, TPrinter.nPrice
  FROM TProduct INNER JOIN TPrinter
  ON TProduct.cModel = TPrinter.cModel
  WHERE TProduct.cProvider = 'InfoChip');

/* 10. Show the providers that sell PCs but not laptops. Write the SQL sentence in two different ways. */
SELECT cProvider FROM TProduct
  WHERE cModel IN (SELECT cModel FROM TPC) AND cModel NOT IN (SELECT cModel from TLaptop);

SELECT prod.cProvider FROM TPC pc
  INNER JOIN TProduct prod ON prod.cModel = pc.cModel
  LEFT OUTER JOIN TLaptop l ON l.cModel = prod.cModel;

SELECT cProvider FROM TProduct prod
  INNER JOIN TPC pc ON prod.cModel = pc.cModel
  WHERE prod.cModel NOT IN (SELECT cModel from TLaptop);

/* 11. Show the printers with the highest price. */
SELECT * FROM TPrinter
  WHERE nPrice = (SELECT MAX(nPrice) FROM TPrinter);

/* 12. Show the providers of the cheapest colour printers. */
SELECT prod.cProvider FROM TProduct prod
  INNER JOIN TPrinter p ON p.cModel = prod.cModel
  WHERE nPrice = (SELECT MIN(nPrice) FROM TPrinter) AND lColour;

/* 13. Show the average speed of PCs. */
SELECT AVG(nSpeed) FROM TPC;

/* 14. Show the average speed of those laptops that cost more than 1000 euros. */
SELECT AVG(nSpeed) FROM TLaptop WHERE nPrice::numeric > 1000;

/* 15. For each PC speed, show the price average. */
SELECT AVG(nPrice::numeric), nSpeed FROM TPC GROUP BY nSpeed;

/* 16. Show the different hard drive capacities used by more than one PC. */
SELECT nHD FROM TPC GROUP BY nHD HAVING COUNT(1) > 1;

/* 17. For each provider, show the average screen size of the laptops it sells. */
SELECT AVG(nScreenRes), prod.cProvider FROM TProduct prod
  INNER JOIN TLaptop l ON l.cModel = prod.cModel
  GROUP BY prod.cProvider;

/* 18. Show each provider that sells PCs along with the maximum price of the PCs it sells */
SELECT prod.cProvider, MAX(nPrice::numeric) FROM TProduct prod
  INNER JOIN TPC ON TPC.cModel = prod.cModel GROUP BY prod.cProvider;

/* 19. For each processing speed over 600 Mhz, show the average price. */
SELECT AVG(nPrice::numeric) FROM TPC
  WHERE nSpeed > 600 GROUP BY nSpeed;

/* 20. For each provider that manufactures printers, show the average capacity of the hard drives of the PCs it
       manufactures. */
SELECT prod.cProvider, AVG(p.nHD) FROM TProduct prod
  INNER JOIN TPC p ON p.cModel = prod.cModel
  INNER JOIN TPrinter pr ON pr.cModel = prod.cModel
  GROUP BY prod.cProvider;

SELECT prod.cProvider, AVG(p.nHD) FROM TProduct prod
  INNER JOIN TPC p ON p.cModel = prod.cModel
  WHERE prod.cModel IN (SELECT DISTINCT pr.cModel FROM TPrinter pr)
  GROUP BY prod.cProvider;
