drop database Apple;
Create database Apple;
Use Apple;
/*Create Entity Table*/

-- Create Multivalue attribute:Language
CREATE TABLE Account (
    AccountID INT(50) NOT NULL,
    FName VARCHAR(30) NOT NULL,
    LName VARCHAR(30) NOT NULL,
    Phone INT(20),
    Email VARCHAR(50),
    Age INT(10),
    HomeAddress TEXT,
    PRIMARY KEY (AccountID)
);


CREATE TABLE Category (
    CategoryID INT(100) NOT NULL,
    CategoryName VARCHAR(100),
    PRIMARY KEY (CategoryID)
);


CREATE TABLE Developer (
    DeveloperID INT(100) NOT NULL,
    CompanyName VARCHAR(200),
    Website TEXT,
    RegisteredAddress TEXT,
    PRIMARY KEY (DeveloperID)
);

CREATE TABLE AdvertisementManager (
    ManagerID INT(100) NOT NULL,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    PRIMARY KEY (ManagerID)
);
CREATE TABLE Advertisement (
    AdID INT(100) NOT NULL,
    AdType VARCHAR(100),
    Position VARCHAR(50),
    Cost DECIMAL(10,2),
    Duration VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    ManagerID INT,
    PRIMARY KEY (AdID),
    FOREIGN KEY (ManagerID)
    REFERENCES AdvertisementManager (ManagerID)
);
-- drop table Advertisement ;
-- drop table  AdvertisementManager;
CREATE TABLE Regulator (
    EmployeeID INT(100) NOT NULL,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    PRIMARY KEY (EmployeeID)
);

CREATE TABLE Device (
    DeviceID INT(100) NOT NULL,
    DeviceName VARCHAR(50),
    PRIMARY KEY (DeviceID)
);

CREATE TABLE App (
    AppID INT(20) NOT NULL,
    Name VARCHAR(20) NOT NULL,
    Size VARCHAR(20),
    Copyright VARCHAR(100),
    Slogan TEXT,
    PublishedDate DATE,
    PrivacyPolicy TEXT,
    Age_Rating VARCHAR(20),
    PublishedBy_DeveloperID INT,
    MonitoredBy_EmployeeID INT,
    DeveloperID INT UNIQUE,
    EmployeeID INT,
    PRIMARY KEY (AppID),
    FOREIGN KEY (DeveloperID) 
  REFERENCES Developer (DeveloperID),
 FOREIGN KEY (EmployeeID) 
  REFERENCES Regulator (EmployeeID)
);

-- Weak entity
CREATE TABLE AppVersion (
    VersionID VARCHAR(100) NOT NULL,
    UpdateHistory DATE,
    UpdateContent TEXT,
    AppID INT,
    PRIMARY KEY (AppID, VersionID),
    FOREIGN KEY (AppID) 
  REFERENCES App(AppID)
);

CREATE TABLE Belongs_To (
    AppID INT(20) NOT NULL,
    CategoryID INT(100) NOT NULL,
    PRIMARY KEY (AppID , CategoryID),
    FOREIGN KEY (AppID)
        REFERENCES App (AppID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (CategoryID)
        REFERENCES Category (CategoryID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Deploy (
    AppID INT,
    AdID INT,
    Start_time DATE,
    End_time DATE,
    PRIMARY KEY (AppID , AdID),
    FOREIGN KEY (AppID)
        REFERENCES App (AppID),
    FOREIGN KEY (AdID)
        REFERENCES Advertisement (AdID)
);


CREATE TABLE BeUsedBy (
    AccountID INT,
    DeviceID INT,
    PRIMARY KEY (AccountID , DeviceID),
    FOREIGN KEY (AccountID)
        REFERENCES Account (AccountID),
    FOREIGN KEY (DeviceID)
        REFERENCES Device (DeviceID)
);

CREATE TABLE Compatible (
AppID INT,
DeviceID INT,
PRIMARY KEY (AppID, DeviceID),
   FOREIGN KEY (AppID)
        REFERENCES App (AppID),
     FOREIGN KEY (DeviceID)
        REFERENCES Device (DeviceID)
);


CREATE TABLE IsFriendWith (
AccountID INT,
Friends_AccountID INT, 
PRIMARY KEY (AccountID, Friends_AccountID),
    FOREIGN KEY (AccountID) 
  REFERENCES Account(AccountID),
    FOREIGN KEY (Friends_AccountID) 
  REFERENCES Account(AccountID),
CHECK (AccountID != Friends_AccountID)
);

CREATE TABLE AppLanguage (
    AppID INT,
    Language VARCHAR(100),
    PRIMARY KEY (AppID , Language),
    FOREIGN KEY (AppID)
        REFERENCES App (AppID)
);

CREATE TABLE Transaction (
    TransactionID INT(100) NOT NULL,
    PurchaseMethod VARCHAR(50),
    Price DECIMAL(10, 2),
    PurchaseAddress TEXT,
    Of_AppID INT,
    MadeBy_AccountID INT,
    AppID INT,
    AccountID INT,
    PRIMARY KEY (TransactionID),
 FOREIGN KEY (AppID)
        REFERENCES App (AppID),
 FOREIGN KEY (AccountID)
  REFERENCES Account (AccountID)
);

-- subtype of Transaction-One Time App purchase
CREATE TABLE OneTimeAppPurchase (
    TransactionID INT(100),
    PRIMARY KEY (TransactionID),
    CONSTRAINT fk_Transaction_OneTime FOREIGN KEY (TransactionID)
        REFERENCES Transaction (TransactionID)
        ON DELETE CASCADE ON UPDATE CASCADE
);
-- subtype of Transaction: In App purchase
CREATE TABLE InAppPurchase (
    TransactionID INT(100),
    Detail TEXT,
    PRIMARY KEY (TransactionID),
    CONSTRAINT fk_Transaction_InApp FOREIGN KEY (TransactionID)
        REFERENCES Transaction (TransactionID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Rating_And_Comment (
    RID INT(50) AUTO_INCREMENT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comments TEXT,
    Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    AppID INT,
    AccountID INT,
    PRIMARY KEY (RID),
 FOREIGN KEY (AppID)
        REFERENCES App (AppID),
 FOREIGN KEY (AccountID)
  REFERENCES Account (AccountID)
);

CREATE TABLE BrowseHistory (
    BrowseID INT(100),
    Browse_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    AppID INT,
    AccountID INT,
    PRIMARY KEY (BrowseID),
    FOREIGN KEY (AccountID)
  REFERENCES Account(AccountID),
    FOREIGN KEY (AppID)
  REFERENCES App(AppID)
);


-- drop table App;
INSERT INTO Developer (DeveloperID, CompanyName, Website, RegisteredAddress)
VALUES 
(1, 'Developer A', 'https://www.developera.com', 'Address 1'),
(2, 'Developer B', 'https://www.developerb.com', 'Address 2'),
(3, 'Developer C', 'https://www.developerc.com', 'Address 3'),
(4, 'Developer D', 'https://www.developerd.com', 'Address 4'),
(5, 'Developer E', 'https://www.developere.com', 'Address 5'),
(6, 'Developer F', 'https://www.developerf.com', 'Address 6'),
(7, 'Developer G', 'https://www.developerg.com', 'Address 7'),
(8, 'Developer H', 'https://www.developerh.com', 'Address 8'),
(9, 'Developer I', 'https://www.developeri.com', 'Address 9'),
(10, 'Developer J', 'https://www.developerj.com', 'Address 10');

INSERT INTO Regulator (EmployeeID, FirstName, LastName)
VALUES 
(1, 'Regulator', 'One'),
(2, 'Regulator', 'Two'),
(3, 'Regulator', 'Three'),
(4, 'Regulator', 'Four'),
(5, 'Regulator', 'Five'),
(6, 'Regulator', 'Six'),
(7, 'Regulator', 'Seven'),
(8, 'Regulator', 'Eight'),
(9, 'Regulator', 'Nine'),
(10, 'Regulator', 'Ten');

-- Insert data into database
INSERT INTO App (AppID, Name, Size, Copyright, Slogan, PublishedDate, PrivacyPolicy, Age_Rating, PublishedBy_DeveloperID, MonitoredBy_EmployeeID, DeveloperID, EmployeeID)
VALUES 
(1, 'Genshin Impact', '10GB', '© miHoYo', 'Adventure Awaits', '2020-09-28', 'Privacy Policy Text', '12+', 1, 1, 1, 1),
(2, 'Among Us', '200MB', '© Innersloth', 'Who is the Impostor?', '2018-06-15', 'Privacy Policy Text', '10+', 2, 1, 2, 1),
(3, 'Minecraft', '150MB', '© Mojang', 'Create your world', '2011-11-18', 'Privacy Policy Text', '7+', 3, 2, 3, 2),
(4, 'Call of Duty', '1.8GB', '© Activision', 'Warfare Redefined', '2019-10-01', 'Privacy Policy Text', '16+', 4, 2, 4, 2),
(5, 'Clash Royale', '120MB', '© Supercell', 'Epic Real-Time Battles', '2016-03-02', 'Privacy Policy Text', '9+', 5, 3, 5, 3),
(6, 'PUBG Mobile', '2GB', '© Tencent Games', 'Battle Royale Pioneer', '2018-03-19', 'Privacy Policy Text', '16+', 6, 3, 6, 3),
(7, 'Candy Crush', '80MB', '© King', 'Sweet Puzzle Adventure', '2012-04-12', 'Privacy Policy Text', '4+', 7, 4, 7, 4),
(8, 'Fortnite', '2GB', '© Epic Games', 'The Battle is Building', '2018-08-09', 'Privacy Policy Text', '12+', 8, 4, 8, 4),
(9, 'Subway Surfers', '100MB', '© Kiloo', 'Escape the Grumpy Guard', '2012-05-24', 'Privacy Policy Text', '9+', 9, 5, 9, 5),
(10, 'Temple Run', '60MB', '© Imangi Studios', 'Run for your life!', '2011-08-04', 'Privacy Policy Text', '9+', 10, 5, 10, 5);

INSERT INTO Account (AccountID, FName, LName, Phone, Email, Age, HomeAddress)
VALUES 
(1, 'John', 'Doe', 1234567890, 'john.doe@example.com', 30, '123 Main St'),
(2, 'Jane', 'Smith', 1234567891, 'jane.smith@example.com', 28, '456 Oak St'),
(3, 'Alice', 'Johnson', 1234567892, 'alice.johnson@example.com', 35, '789 Pine Rd'),
(4, 'Bob', 'Brown', 1234567893, 'bob.brown@example.com', 40, '101 Maple Ave'),
(5, 'Carol', 'Davis', 1234567894, 'carol.davis@example.com', 22, '202 Birch Ln'),
(6, 'David', 'Wilson', 1234567895, 'david.wilson@example.com', 27, '303 Cedar Blvd'),
(7, 'Eve', 'Miller', 1234567896, 'eve.miller@example.com', 31, '404 Spruce St'),
(8, 'Frank', 'Taylor', 1234567897, 'frank.taylor@example.com', 36, '505 Elm St'),
(9, 'Grace', 'Anderson', 1234567898, 'grace.anderson@example.com', 29, '606 Oak Dr'),
(10, 'Hank', 'Harris', 1234567899, 'hank.harris@example.com', 42, '707 Pine Pl');

INSERT INTO Transaction (TransactionID, PurchaseMethod, Price, PurchaseAddress, AppID, AccountID)
VALUES 
(1, 'Credit Card', 4.99, '123 Main St', 1, 1),
(2, 'Debit Card', 2.99, '456 Oak St', 2, 2),
(3, 'Credit Card', 1.99, '789 Pine Rd', 3, 3),
(4, 'PayPal', 3.99, '101 Maple Ave', 4, 4),
(5, 'Credit Card', 0.99, '202 Birch Ln', 5, 5),
(6, 'Credit Card', 5.49, '303 Cedar Blvd', 1, 6),
(7, 'Debit Card', 4.49, '404 Spruce St', 2, 7),
(8, 'Credit Card', 3.49, '505 Elm St', 3, 8),
(9, 'PayPal', 6.99, '606 Oak Dr', 4, 9),
(10, 'Credit Card', 2.49, '707 Pine Pl', 5, 10);

INSERT INTO InAppPurchase (TransactionID, Detail)
VALUES 
(1, '500 Gems'),
(2, '100 Coins'),
(3, 'Special Skin'),
(4, 'Extra Lives'),
(5, 'Premium Package'),
(6, '500 Gems'),
(7, '100 Coins'),
(8, 'Special Skin'),
(9, 'Extra Lives'),
(10, 'Premium Package');

INSERT INTO Rating_And_Comment (RID, Rating, Comments, AppID, AccountID)
VALUES 
(1, 5, 'Awesome game!', 1, 1),
(2, 4, 'Really fun to play', 1, 2),
(3, 3, 'Good, but needs some updates', 2, 3),
(4, 5, 'Best game ever!', 2, 4),
(5, 2, 'Not what I expected', 3, 5),
(6, 4, 'Great app, very useful', 3, 6),
(7, 1, 'Did not enjoy it', 4, 7),
(8, 3, 'Decent, but can be better', 4, 8),
(9, 5, 'Highly recommended!', 5, 9),
(10, 4, 'Good experience overall', 5, 10);

INSERT INTO AppLanguage (AppID, Language)
VALUES 
(1, 'English'),
(1, 'Spanish'),
(2, 'English'),
(2, 'French'),
(3, 'English'),
(3, 'German'),
(4, 'English'),
(4, 'Japanese'),
(5, 'English'),
(5, 'Korean');

INSERT INTO Category (CategoryID, CategoryName)
VALUES 
(1, 'Action'),
(2, 'Adventure'),
(3, 'Puzzle'),
(4, 'Strategy'),
(5, 'RPG'),
(6, 'Sports'),
(7, 'Racing'),
(8, 'Simulation'),
(9, 'Education'),
(10, 'Music');

INSERT INTO AdvertisementManager (ManagerID, FirstName, LastName)
VALUES 
(1, 'Alice', 'Johnson'),
(2, 'Bob', 'Smith'),
(3, 'Charlie', 'Brown'),
(4, 'Diana', 'Miller'),
(5, 'Ethan', 'Wilson'),
(6, 'Fiona', 'Taylor'),
(7, 'George', 'Anderson'),
(8, 'Hannah', 'Thomas'),
(9, 'Ian', 'Jackson'),
(10, 'Julia', 'White');

INSERT INTO Belongs_To (AppID, CategoryID)
VALUES
(1, 2),
(2, 4),
(3, 8),
(4, 1),
(5, 4),
(6, 1),
(7, 3),
(8, 1),
(9, 1),
(10, 1);

INSERT INTO Advertisement(AdID, AdType, Position, Cost, Duration, StartDate, EndDate, ManagerID)
VALUES
(1, 'TYPE1', 'Top', '100', '30', '2023-01-01', '2023-12-31', '1'),
(2, 'TYPE2', 'Bottom', '80', '50', '2023-01-01', '2023-12-31', '2');

INSERT INTO Deploy(AppID, AdID, Start_time, End_time)
VALUES
(1, 1, '2023-01-01', '2023-12-31'),
(2, 1, '2023-01-01', '2023-12-31'),
(3, 1, '2023-01-01', '2023-12-31'),
(4, 1, '2023-01-01', '2023-12-31'),
(5, 1, '2023-01-01', '2023-12-31'),
(6, 2, '2023-01-01', '2023-12-31'),
(7, 2, '2023-01-01', '2023-12-31'),
(8, 2, '2023-01-01', '2023-12-31'),
(9, 2, '2023-01-01', '2023-12-31'),
(10, 2, '2023-01-01', '2023-12-31');

-- Display all ratings and comments from reviews of the App "Genshin Impact" from Accounts having an in-app purchase for this app.
SELECT Rating_And_Comment.Rating, Rating_And_Comment.Comments
FROM Rating_And_Comment
INNER JOIN Account ON Rating_And_Comment.AccountID = Account.AccountID
INNER JOIN App ON Rating_And_Comment.AppID = App.AppID
INNER JOIN Transaction ON Account.AccountID = Transaction.AccountID AND App.AppID = Transaction.AppID
INNER JOIN InAppPurchase ON Transaction.TransactionID = InAppPurchase.TransactionID
WHERE App.Name = 'Genshin Impact';

-- Display the descending total price of all transactions of Apps with an average rating of more than 4 stars for each Category.
SELECT Category.CategoryName, SUM(Transaction.Price) AS Total_Price, AVG(Rating_And_Comment.Rating) AS Average_Rating
FROM Transaction
INNER JOIN App ON Transaction.AppID = App.AppID
INNER JOIN Rating_And_Comment ON App.AppID = Rating_And_Comment.AppID
INNER JOIN Belongs_To ON App.AppID = Belongs_to.AppID
INNER JOIN Category ON Belongs_To.CategoryID = Category.CategoryID
GROUP BY Category.CategoryID
HAVING Average_Rating > 4
ORDER BY Total_Price DESC;

-- Display the decending total amount of money paid by each developer for deploying ads on apps with the category "Action".
SELECT Developer.CompanyName, SUM(Advertisement.Cost * Advertisement.Duration) AS Total_Price
FROM Advertisement
INNER JOIN Deploy ON Advertisement.AdID = Deploy.AdID
INNER JOIN App ON Deploy.AppID = App.AppID
INNER JOIN Belongs_To ON App.AppID = Belongs_to.AppID
INNER JOIN Category ON Belongs_To.CategoryID = Category.CategoryID
INNER JOIN Developer on App.DeveloperID = Developer.DeveloperID
WHERE Category.CategoryName = 'Action'
GROUP BY Developer.DeveloperID
ORDER BY Total_Price DESC;