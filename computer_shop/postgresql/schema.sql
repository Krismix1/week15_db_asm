\q
dropdb --if-exists 'computer_shop';
createdb 'computer_shop';
psql -d 'computer_shop';

CREATE TABLE TProduct (
  cModel      varchar(50) NOT NULL,
  cProvider   varchar(10) NOT NULL,
  cType       varchar(50) NOT NULL,
  PRIMARY KEY (cModel)
);

CREATE TABLE TPC (
  nPCID   int NOT NULL,
  cModel  varchar(50) NOT NULL,
  nSpeed  smallint NOT NULL,
  nRAM    smallint NOT NULL,
  nHD     float NOT NULL,
  cCD     varchar(10) NOT NULL,
  nPrice  money,
  PRIMARY KEY (nPCID),
  FOREIGN KEY (cModel) REFERENCES TProduct(cModel)
);

CREATE TABLE TLaptop (
  nLaptopID   int NOT NULL,
  cModel      varchar(50) NOT NULL,
  nSpeed      smallint NOT NULL,
  nRAM        smallint NOT NULL,
  nHD         float NOT NULL,
  cCD         varchar(10) NOT NULL,
  nPrice      money,
  nScreenRes  smallint NOT NULL,
  PRIMARY KEY (nLaptopID),
  FOREIGN KEY (cModel) REFERENCES TProduct (cModel)
);

CREATE TABLE TPrinter (
  nPrinterID int NOT NULL,
  cModel     varchar(50) NOT NULL,
  cType      varchar(10) NOT NULL,
  lColour    boolean NOT NULL,
  nPrice     money,
  PRIMARY KEY (nPrinterID),
  FOREIGN KEY (cModel) REFERENCES TProduct(cModel)
);
