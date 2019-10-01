--BEGIN REPEATABLE SCRIPT
--Dropping Constraints from tables if they exist; Tested and works
IF OBJECT_ID('sw_OlympicRecord' , 'U') IS NOT NULL
	ALTER TABLE sw_OlympicRecord
		DROP CONSTRAINT FK1_sw_OlympicRecord ;
IF OBJECT_ID('sw_Event' , 'U') IS NOT NULL
	ALTER TABLE sw_Event
		DROP CONSTRAINT FK1_sw_Event ;
IF OBJECT_ID('sw_OlympicGames' , 'U') IS NOT NULL
	ALTER TABLE sw_OlympicGames
		DROP CONSTRAINT FK1_sw_OlympicGames ;
IF OBJECT_ID('sw_OlympicGames' , 'U') IS NOT NULL
	ALTER TABLE sw_OlympicGames
		DROP CONSTRAINT FK2_sw_OlympicGames ;
IF OBJECT_ID('sw_Athlete' , 'U') IS NOT NULL
	ALTER TABLE sw_Athlete
		DROP CONSTRAINT FK1_sw_Athlete ;
IF OBJECT_ID('sw_Athlete' , 'U') IS NOT NULL
	ALTER TABLE sw_Athlete
		DROP CONSTRAINT FK2_sw_Athlete ;
IF OBJECT_ID('sw_AthleteEvent' , 'U') IS NOT NULL
	ALTER TABLE sw_AthleteEvent
		DROP CONSTRAINT FK1_sw_AthleteEvent ;
IF OBJECT_ID('sw_AthleteEvent' , 'U') IS NOT NULL
	ALTER TABLE sw_AthleteEvent
		DROP CONSTRAINT FK2_sw_AthleteEvent ;
IF OBJECT_ID('sw_AthleteEvent' , 'U') IS NOT NULL
	ALTER TABLE sw_AthleteEvent
		DROP CONSTRAINT FK3_sw_AthleteEvent ;

--Dropping tables; Tested and works
IF OBJECT_ID('sw_Gender' , 'U') IS NOT NULL
	DROP TABLE sw_Gender ;
IF OBJECT_ID('sw_Country' , 'U') IS NOT NULL
	DROP TABLE sw_Country ;
IF OBJECT_ID('sw_Event' , 'U') IS NOT NULL
	DROP TABLE sw_Event ;
IF OBJECT_ID('sw_OlympicGames' , 'U') IS NOT NULL
	DROP TABLE sw_OlympicGames ;
IF OBJECT_ID('sw_GamesEvent' , 'U') IS NOT NULL
	DROP TABLE sw_GamesEvent ;
IF OBJECT_ID('sw_Athlete' , 'U') IS NOT NULL
	DROP TABLE sw_Athlete ;
IF OBJECT_ID('sw_AthleteEvent' , 'U') IS NOT NULL
	DROP TABLE sw_AthleteEvent ;
IF OBJECT_ID('sw_OlympicRecord' , 'U') IS NOT NULL
	DROP TABLE sw_OlympicRecord ;
IF OBJECT_ID('sw_Year' , 'U') IS NOT NULL
	DROP TABLE sw_Year ;

--Dropping Procedures
IF OBJECT_ID('sw_NewGames') IS NOT NULL
	DROP PROCEDURE sw_NewGames ;
IF OBJECT_ID('sw_AddAthlete') IS NOT NULL
	DROP PROCEDURE sw_AddAthlete ;
IF OBJECT_ID('sw_AddAthleteEvent') IS NOT NULL
	DROP PROCEDURE sw_AddAthleteEvent ;
IF OBJECT_ID('sw_AddOlympicRecord') IS NOT NULL
	DROP PROCEDURE sw_AddOlympicRecord ;

--Creating the Tables; Tested and works
CREATE TABLE sw_Gender
	(
			Gender char(1) NOT NULL ,
		CONSTRAINT PK_sw_Gender PRIMARY KEY (Gender)
	);
CREATE TABLE sw_Country
	(
			CountryName varchar(40) NOT NULL,
		CONSTRAINT PK_sw_Country PRIMARY KEY (CountryName)
	);
CREATE TABLE sw_Year
	(
			Year int NOT NULL
		CONSTRAINT PK_sw_Year PRIMARY KEY (year)
	);
CREATE TABLE sw_Event
	(
			sw_EventID int identity NOT NULL ,
			Distance int NOT NULL ,
			Stroke varchar(20) NOT NULL ,
			Gender char(1) NOT NULL ,
		CONSTRAINT PK_sw_Event PRIMARY KEY (sw_eventID) ,
		CONSTRAINT FK1_sw_Event FOREIGN KEY (Gender) REFERENCES sw_Gender(Gender)
	);
CREATE TABLE sw_OlympicGames
	(
			sw_gamesID int identity NOT NULL ,
			year int NOT NULL ,
			city varchar(30) NOT NULL ,
			CountryName varchar(40) NOT NULL
		CONSTRAINT PK_sw_OlympicGames PRIMARY KEY (sw_gamesID) ,
		CONSTRAINT FK1_sw_OlympicGames FOREIGN KEY (year) REFERENCES sw_Year(year) ,
		CONSTRAINT FK2_sw_OlympicGames FOREIGN KEY (CountryName) REFERENCES sw_Country(CountryName)
	);

CREATE TABLE sw_Athlete
	(
			sw_AthleteID int identity NOT NULL ,
			FirstName varchar(20) ,
			LastName varchar(20) NOT NULL ,
			Gender char(1) NOT NULL ,
			CountryName varchar(40) NOT NULL ,
			DateOfBirth date NOT NULL ,
		CONSTRAINT PK_sw_Athlete PRIMARY KEY (sw_AthleteID) ,
		CONSTRAINT FK1_sw_Athlete FOREIGN KEY (Gender) REFERENCES sw_Gender(Gender) ,
		CONSTRAINT FK2_sw_Athlete FOREIGN KEY (CountryName) REFERENCES sw_Country(CountryName)
	);
CREATE TABLE sw_AthleteEvent
	(
			sw_AthleteEventID int identity NOT NULL ,
			sw_AthleteID int NOT NULL ,
			year int NOT NULL ,
			sw_EventID int NOT NULL ,
			EventTime decimal(5, 2) NOT NULL ,
			Ranking int NOT NULL ,
			Age int NOT NULL ,
		CONSTRAINT PK_sw_AthleteEvent PRIMARY KEY (sw_AthleteEventID) ,
		CONSTRAINT FK1_sw_AthleteEvent FOREIGN KEY (sw_AthleteID) REFERENCES sw_Athlete(sw_AthleteID) ,
		CONSTRAINT FK2_sw_AthleteEvent FOREIGN KEY (Year) REFERENCES sw_Year(year) ,
		CONSTRAINT FK3_sw_AthleteEvent FOREIGN KEY (sw_EventID) REFERENCES sw_Event(sw_EventID)
	);
CREATE TABLE sw_OlympicRecord
	(
			sw_OlympicRecordID int identity NOT NULL ,
			time decimal(5, 2) NOT NULL ,
	  	DateSet int NOT NULL ,
	  	sw_AthleteEventID int NOT NULL
		CONSTRAINT PK_sw_OlympicRecord PRIMARY KEY (sw_OlympicRecordID) ,
		CONSTRAINT FK1_sw_OlympicRecord FOREIGN KEY (sw_AthleteEventID) REFERENCES sw_AthleteEvent(sw_AthleteEventID)
	);

	--Inserting data into Gender table
	INSERT INTO sw_Gender (Gender)
		VALUES
		('M') ,
		('F');

	--Inserting Data into Country Table
	INSERT INTO sw_Country (CountryName)
	  Values
	    ('Afghanistan') ,
	    ('Albania') ,
	    ('Algeria') ,
	    ('American Samoa') ,
	    ('Andorra') ,
	    ('Angola') ,
	    ('Antigua and Barbuda') ,
	    ('Argentina') ,
	    ('Armenia') ,
	    ('Aruba') ,
	    ('Australia') ,
	    ('Austria') ,
	    ('Azerbaijan') ,
	    ('Bahamas') ,
	    ('Bahrain') ,
	    ('Bangladesh') ,
	    ('Barbados') ,
	    ('Belarus') ,
	    ('Belgium') ,
	    ('Belize') ,
	    ('Benin') ,
	    ('Bermuda') ,
	    ('Bhutan') ,
	    ('Bolivia') ,
	    ('Bosnia and Herzegovina') ,
	    ('Botswana') ,
	    ('Brazil') ,
	    ('British Virgin Islands') ,
	    ('Brunei') ,
	    ('Bulgaria') ,
	    ('Burkina Faso') ,
	    ('Burundi') ,
	    ('Cambodia') ,
	    ('Cameroon') ,
	    ('Canada') ,
	    ('Cape Verde') ,
	    ('Cayman Islands') ,
	    ('Central African Republic') ,
	    ('Chad') ,
	    ('Chile') ,
	    ('China') ,
	    ('Chinese Taipei') ,
	    ('Republic of China') ,
	    ('Colombia') ,
	    ('Comoros') ,
	    ('Republic of the Congo') ,
	    ('Democratic Republic of the Congo') ,
	    ('Cook Islands') ,
	    ('Costa Rica') ,
	    ('Ivory Coast') ,
	    ('Croatia') ,
	    ('Cuba') ,
	    ('Cyprus') ,
	    ('Czech Republic') ,
	    ('Czechoslovakia') ,
	    ('Bohemia') ,
	    ('Denmark') ,
	    ('Djibouti') ,
	    ('Dominica') ,
	    ('Dominican Republic') ,
	    ('Ecuador') ,
	    ('Egypt') ,
	    ('El Salvador') ,
	    ('Equatorial Guinea') ,
	    ('Eritrea') ,
	    ('Estonia') ,
	    ('Ethiopia') ,
	    ('Fiji') ,
	    ('Finland') ,
	    ('France') ,
	    ('Gabon') ,
	    ('The Gambia') ,
	    ('Georgia') ,
	    ('Germany') ,
	    ('East Germany') ,
	    ('West Germany') ,
	    ('United Team of Germany') ,
	    ('Saar') ,
	    ('Ghana') ,
	    ('Great Britain') ,
	    ('Greece') ,
	    ('Grenada') ,
	    ('Guam') ,
	    ('Guatemala') ,
	    ('Guinea') ,
	    ('Guinea-Bissau') ,
	    ('Guyana') ,
	    ('Haiti') ,
	    ('Honduras') ,
	    ('Hong Kong') ,
	    ('Hungary') ,
	    ('Iceland') ,
	    ('India') ,
	    ('Indonesia') ,
	    ('Iran') ,
	    ('Iraq') ,
	    ('Ireland') ,
	    ('Israel') ,
	    ('Italy') ,
	    ('Jamaica') ,
	    ('Japan') ,
	    ('Jordan') ,
	    ('Kazakhstan') ,
	    ('Kenya') ,
	    ('Kiribati') ,
	    ('North Korea') ,
	    ('South Korea') ,
	    ('Kosovo') ,
	    ('Kuwait') ,
	    ('Kyrgyzstan') ,
	    ('Laos') ,
	    ('Latvia') ,
	    ('Lebanon') ,
	    ('Lesotho') ,
	    ('Liberia') ,
	    ('Libya') ,
	    ('Liechtenstein') ,
	    ('Lithuania') ,
	    ('Luxembourg') ,
	    ('Macedonia') ,
	    ('Madagascar') ,
	    ('Malawi') ,
	    ('Malaysia') ,
	    ('Malaya') ,
	    ('North Borneo') ,
	    ('Maldives') ,
	    ('Mali') ,
	    ('Malta') ,
	    ('Marshall Islands') ,
	    ('Mauritania') ,
	    ('Mauritius') ,
	    ('Mexico') ,
	    ('Federated States of Micronesia') ,
	    ('Moldova') ,
	    ('Monaco') ,
	    ('Mongolia') ,
	    ('Montenegro') ,
	    ('Morocco') ,
	    ('Mozambique') ,
	    ('Myanmar') ,
	    ('Namibia') ,
	    ('Nauru') ,
	    ('Nepal') ,
	    ('Netherlands') ,
	    ('Netherlands Antilles') ,
	    ('New Zeland') ,
	    ('Nicaragua') ,
	    ('Niger') ,
	    ('Nigeria') ,
	    ('Norway') ,
	    ('Oman') ,
	    ('Pakistan') ,
	    ('Palau') ,
	    ('Palestine') ,
	    ('Panama') ,
	    ('Papua New Guinea') ,
	    ('Paraguay') ,
	    ('Peru') ,
	    ('Philippines') ,
	    ('Poland') ,
	    ('Portugal') ,
	    ('Puerto Rico') ,
	    ('Qatar') ,
	    ('Romania') ,
	    ('Russia') ,
	    ('Unified Team') ,
	    ('Soviet Union') ,
	    ('Russian Empire') ,
	    ('Rwanda') ,
	    ('Saint Kitts and Nevis') ,
	    ('Saint Lucia') ,
	    ('Saint Vicent and the Grenadines') ,
	    ('Samoa') ,
	    ('San Marino') ,
	    ('Sao Tome and Principe') ,
	    ('Saudi Arabia') ,
	    ('Senegal') ,
	    ('Serbia') ,
	    ('Serbia and Montenegro') ,
	    ('Independent Olympic Participants') ,
	    ('Yugoslavia') ,
	    ('Seychelles') ,
	    ('Sierra Leone') ,
	    ('Singapore') ,
	    ('Slovakia') ,
	    ('Slovenia'),
	    ('Solomon Islands') ,
	    ('Somalia') ,
	    ('South Africa'),
	    ('Spain') ,
	    ('Sri Lanka') ,
	    ('Sudan') ,
	    ('South Sudan') ,
	    ('Suriname') ,
	    ('Swaziland') ,
	    ('Sweden') ,
	    ('Switzerland') ,
	    ('Syria') ,
	    ('Tajikistan') ,
	    ('Tanzania') ,
	    ('Thailand') ,
	    ('East Timor') ,
	    ('Togo') ,
	    ('Tonga') ,
	    ('Trinidad and Tobago') ,
	    ('British West Indies') ,
	    ('Tunisia') ,
	    ('Turkey') ,
	    ('Turmenistan') ,
	    ('Tuvalu') ,
	    ('Uganda') ,
	    ('Ukraine') ,
	    ('United Arab Emirates') ,
	    ('United States') ,
	    ('Uruguay') ,
	    ('Uzbekistan') ,
	    ('Vanuatu') ,
	    ('Venezuela') ,
	    ('Vietnam') ,
	    ('Virgin Islands') ,
	    ('Yemen') ,
	    ('South Yemen') ,
	    ('North Yemen') ,
	    ('Zambia') ,
	    ('Zimbabwe') ,
	    ('Mixed Team') ,
	    ('Independent Olympic Athletes') ,
	    ('Refugee Olympic Team');

	--Inserting years
	--1916 was canceled due to WWI; 1940 & 1944 Canceled due to WWII
	INSERT INTO sw_Year
		VALUES
			(1896) ,
			(1900) ,
			(1904) ,
			(1908) ,
			(1912) ,
			(1920) ,
			(1924) ,
			(1928) ,
			(1932) ,
			(1936) ,
			(1948) ,
			(1952) ,
			(1956) ,
			(1960) ,
			(1964) ,
			(1968) ,
			(1972) ,
			(1976) ,
			(1980) ,
			(1984) ,
			(1988) ,
			(1992) ,
			(1996) ,
			(2000) ,
			(2004) ,
			(2008) ,
			(2012) ,
			(2016) ;

	--Inserting locations and years into Olympic Games
	INSERT INTO sw_OlympicGames(year, city, CountryName)
		VALUES
			(1896 , 'Athens' , 'Greece') ,
			(1900 , 'Paris' , 'France') ,
			(1904 , 'St. Louis' , 'United States') ,
			(1908 , 'London' , 'Great Britain') ,
			(1912 , 'Stockholm' , 'Sweden') ,
			(1920 , 'Antwerp' , 'Belgium') ,
			(1924 , 'Paris' , 'France') ,
			(1928 , 'Amsterdam' , 'Netherlands') ,
			(1932 , 'Los Angeles' , 'United States') ,
			(1936 , 'Berlin' , 'Germany') ,
			(1948 , 'London' , 'Great Britain') ,
			(1952 , 'Helsinki' , 'Finland') ,
			(1956 , 'Melbourne' , 'Australia') ,
			(1960 , 'Rome' , 'Italy') ,
			(1964 , 'Tokyo' , 'Japan') ,
			(1968 , 'Mexico City' , 'Mexico') ,
			(1972 , 'Munich' , 'West Germany') ,
			(1976 , 'Montreal' , 'Canada') ,
			(1980, 'Moscow' , 'Soviet Union') ,
			(1984 , 'Los Angeles' , 'United States') ,
			(1988 , 'Seoul' , 'South Korea') ,
			(1992 , 'Barcelona' , 'Spain') ,
			(1996 , 'Atlanta' , 'United States') ,
			(2000 , 'Sydney' , 'Australia') ,
			(2004 , 'Athens' , 'Greece') ,
			(2008 , 'Beijing' , 'China') ,
			(2012 , 'London' , 'Great Britain') ,
			(2016 , 'Rio de Janeiro' , 'Brazil')

--Inserting data into Events table
INSERT INTO sw_Event(distance , stroke , Gender)
	VALUES
		(50 , 'Freestyle' , 'M') ,
		(100 , 'Freestyle' , 'M') ,
		(200 , 'Freestyle' , 'M') ,
		(400 , 'Freestyle' , 'M') ,
		(1500 , 'Freestyle' , 'M') ,
		(100 , 'Backstroke' , 'M') ,
		(200 , 'Backstroke' , 'M') ,
		(100 , 'Butterfly' , 'M') ,
		(200 , 'Butterfly' , 'M') ,
		(100 , 'Breaststroke' , 'M') ,
		(200 , 'Breaststroke' , 'M') ,
		(200 , 'Individual Medley' , 'M') ,
		(400 , 'Individual Medley' , 'M') ,
		(400 , 'Freestyle Relay' , 'M') ,
		(800 , 'Freestyle Relay' , 'M') ,
		(400 , 'Medley Relay' , 'M') ,
		(50 , 'Freestyle' , 'F') ,
		(100 , 'Freestyle' , 'F') ,
		(200 , 'Freestyle' , 'F') ,
		(400 , 'Freestyle' , 'F') ,
		(800 , 'Freestyle' , 'F') ,
		(100 , 'Backstroke' , 'F') ,
		(200 , 'Backstroke' , 'F') ,
		(100 , 'Butterfly' , 'F') ,
		(200 , 'Butterfly' , 'F') ,
		(100 , 'Breaststroke' , 'F') ,
		(200 , 'Breaststroke' , 'F') ,
		(200 , 'Individual Medley' , 'F') ,
		(400 , 'Individual Medley' , 'F') ,
		(400 , 'Freestyle Relay' , 'F') ,
		(800 , 'Freestyle Relay' , 'F') ,
		(400 , 'Medley Relay' , 'F');

--Inserting Some Athletes
INSERT INTO sw_Athlete (FirstName , LastName , DateOfBirth , Gender , CountryName)
	VALUES ('Michael' , 'Phelps' , '1985-06-30' , 'M' , 'United States') ,
					('Missy' , 'Franklin' , '1995-05-10' , 'F' , 'United States') ,
					('Katie' , 'Ledecky' , '1997-03-17' , 'F' , 'United States') ,
					('Joseph' , 'Schooling' , '1995-06-16' , 'M' , 'Singapore') ,
					('Ryan' , 'Lochte' , '1984-08-03' , 'M' , 'United States') ,
					('Chad' , 'le Clos' , '1992-04-12' , 'M' , 'South Africa') ,
					('Amaury' , 'Leveaux' , '1985-12-02' , 'M' , 'France') ,
					('Matt' , 'Grevers' , '1985-03-26' , 'M' , 'United States') ,
					('Ryan' , 'Murphy' , '1995-07-02' , 'M' , 'United States') ,
					('Alexander' , 'Popov' , '1971-11-16' , 'M' , 'Russia') ;





--END REPEATABLE SCRIPT



--Procedure for adding a new Olympic Games
CREATE PROCEDURE sw_NewGames(@year int , @city varchar(50) , @country varchar(50))
AS
BEGIN
	INSERT INTO sw_Year(year)
		VALUES (@year)
	INSERT INTO sw_OlympicGames(year, City, CountryName)
		VALUES (@year , @city , @country)
END
GO

EXEC sw_NewGames 2020 , 'Tokyo' , 'Japan'

--Entering Games-Event data
CREATE PROCEDURE sw_AddAthlete (@LastName varchar(20) , @FirstName varchar(20) , @DOB date , @Gender char(1) ,
@Country varchar(50))
AS
BEGIN
	DECLARE @AthleteID AS int

	SELECT @AthleteID = sw_Athlete.sw_AthleteID
	FROM sw_Athlete
	WHERE LastName = @LastName AND FirstName = @FirstName

	IF(@AthleteID IS NULL)
	BEGIN
		INSERT INTO sw_Athlete(FirstName , LastName , DateOfBirth , Gender , CountryName)
		VALUES (@FirstName , @LastName , @DOB , @Gender , @Country)
		SELECT @AthleteID = SCOPE_IDENTITY()
	END
END

Exec sw_AddAthlete 'Adrian' , 'N' , '1988-12-07' , 'M' , 'United States' --Intentionally just using first intial so I can update this record
EXEC sw_Athlete 'Spitz' , 'M' , '1950-02-10' , 'M' , 'United States' --Intentionally just using first intial so I can update this record
--Updating Athlete entry for Nathan Adrian
UPDATE sw_Athlete SET FirstName = 'Nathan'
WHERE lastName = 'Adrian'

UPDATE sw_Athlete SET FirstName = 'Mark'
WHERE LastName = 'Spitz'

--Creating a procedure for entering Athlete Event
CREATE PROCEDURE sw_AddAthleteEvent (@LastName varchar(50) , @FirstName varchar(50) , @Distance int , @Stroke varchar(20) ,
@year int , @time decimal (5,2) , @ranking int , @age int)
AS
BEGIN
 DECLARE @AthleteID int
 DECLARE @EventID int

 SELECT @AthleteID = sw_AthleteID
 FROM sw_Athlete
 WHERE @LastName = LastName AND @FirstName = FirstName

 SELECT @EventID = sw_EventID
 FROM sw_Event
 WHERE @Distance = Distance AND @stroke = Stroke

 INSERT INTO sw_AthleteEvent (sw_AthleteID , year , sw_EventID , EventTime , ranking , age)
	 VALUES (@AthleteID , @year , @EventID , @time , @ranking , @age)
END
GO

EXEC sw_AddAthleteEvent 'Phelps' , 'Michael' , 400 , 'Individual Medley' , 2008 , 247.82 , 1 , 24 ;
EXEC sw_AddAthleteEvent 'Leveaux' , 'Amaury' , 100 , 'Freestyle' , 2008 , 47.76 , 1 , 23 ;
EXEC sw_AddAthleteEvent 'Grevers' , 'Matt' , 100 , 'Backstroke' , 2008 , 53.41 , 1 , 24 ;
EXEC sw_AddAthleteEvent 'Phelps' , 'Michael' , 200 , 'Freestyle' , 2008 , 102.96 , 1 , 24 ;
EXEC sw_AddAthleteEvent 'Murphy' , 'Ryan' , 100 , 'Backstroke' , 2016 , 51.85 , 1, 21 ;
EXEC sw_AddAthleteEvent 'Schooling' , 'Joseph' , 100 , 'Butterfly' , 2016 , 50.39 , 21 ;
EXEC sw_AddAthleteEvent 'Popov' , 'Alexander' , 50 , 'Freestyle' , 1996 , 22.13 , 25 ;
--Procedure for inserting Olympic Records
CREATE PROCEDURE sw_AddOlympicRecord (@time decimal (5,2) , @dateset int)
AS
BEGIN
	DECLARE @AthleteEventID int

	SELECT @AthleteEventID = sw_AthleteEventID
	FROM sw_AthleteEvent
	WHERE @time = EventTime AND @dateSet = year

	INSERT INTO sw_OlympicRecord (time , DateSet , sw_AthleteEventID)
		VALUES (@time , @dateset , @AthleteEventID)
END
GO

EXEC sw_AddOlympicRecord 47.76 , 2008 ;
EXEC sw_AddOlympicRecord 247.82 , 2008 ;
EXEC sw_AddOlympicRecord 53.41 , 2008 ;
EXEC sw_AddOlympicRecord 102.96 , 2008 ;
EXEC sw_AddOlympicRecord 51.85 , 2016 ;
EXEC sw_AddOlympicRecord 50.39 , 2016 ;

--Creating reports for the 5 data questions
--Question 1: In which year did the most Olympic Records get broken?
SELECT COUNT(year) AS NumberRecordsBroken ,
		year
FROM sw_OlympicRecord
JOIN sw_AthleteEvent ON sw_OlympicRecord.sw_AthleteEventID = sw_AthleteEvent.sw_AthleteEventID
GROUP BY year
ORDER BY NumberRecordsBroken DESC

--Question 2: Have the US Men won more medals than the US Women?
SELECT COUNT(sw_AthleteEventID) AS MedalCount ,
	sw_Athlete.CountryName ,
	sw_Athlete.Gender
FROM sw_AthleteEvent
JOIN sw_Athlete ON sw_AthleteEvent.sw_AthleteID = sw_Athlete.sw_AthleteID
WHERE sw_Athlete.CountryName LIKE '%United States%'
GROUP BY (sw_Athlete.CountryName) , (sw_Athlete.Gender)


--Question 3: Which country has won more medals, the US or Russia?
SELECT COUNT(sw_AthleteEvent.sw_AthleteEventID) AS MedalCount ,
		sw_Athlete.CountryName
FROM sw_AthleteEvent
JOIN sw_Athlete ON sw_AthleteEvent.sw_AthleteID = sw_Athlete.sw_AthleteID
WHERE CountryName LIKE '%United States%' OR CountryName LIKE '%Russia%'
GROUP BY sw_Athlete.CountryName
ORDER BY MedalCount DESC

--Question 4: Who is the oldest man or woman to win an Olympic Medal in Swimming
SELECT age ,
		LastName ,
		FirstName
FROM sw_AthleteEvent
JOIN sw_Athlete ON sw_AthleteEvent.sw_AthleteID = sw_Athlete.sw_AthleteID
ORDER BY age DESC

--Question 5: Which countries have fewer total medals than Michael Phelps does alone?
SELECT CountryName ,
	COUNT(sw_AthleteEventID) AS CountryMedalCount
FROM sw_AthleteEvent
JOIN sw_Athlete ON sw_AthleteEvent.sw_AthleteID = sw_Athlete.sw_AthleteID
GROUP BY sw_Athlete.CountryName
ORDER BY CountryMedalCount DESC

SELECT COUNT(sw_AthleteEventID) AS PhelpsMedalCount ,
	LastName
FROM sw_AthleteEvent
JOIN sw_Athlete ON sw_AthleteEvent.sw_AthleteID = sw_Athlete.sw_AthleteID
WHERE LastName LIKE '%Phelps%'
GROUP BY LastName
