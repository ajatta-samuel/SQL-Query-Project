--1. Query the NAME field for all American cities in the CITY table
--with populations larger than 120000. The CountryCode for America is USA.
SELECT NAME 
FROM CITY 
WHERE COUNTRYCODE = 'USA' 
AND POPULATION > 120000;

--2. Query all columns for a city in CITY with the ID 1661.
SELECT * 
FROM 
CITY 
WHERE ID = 1661;

--3. Query all attributes of every Japanese city in the CITY 
--table. The COUNTRYCODE for Japan is JPN.
SELECT * 
FROM CITY 
WHERE ID = 1661;

--4. Query all attributes of every Japanese city in the CITY table. 
--The COUNTRYCODE for Japan is JPN.
SELECT NAME 
FROM CITY 
WHERE COUNTRYCODE = 'JPN';

--5. Query a list of CITY and STATE from the STATION table.
SELECT CITY, STATE 
FROM STATION;

--6 Query a list of CITY names from STATION for cities that have an even ID number. 
--Print the results in any order, but exclude duplicates from the answer.
SELECT DISTINCT CITY
FROM STATION
WHERE MOD(ID,2)=0
ORDER BY CITY ASC;

--7. Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name).
--If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
(SELECT CITY, LENGTH(CITY)
 FROM STATION 
 ORDER BY LENGTH(CITY)ASC,CITY LIMIT 1)
UNION
(SELECT CITY, LENGTH(CITY)
 FROM STATION 
 ORDER BY LENGTH(CITY)DESC, CITY LIMIT 1);
 
 --8. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates. 
(SELECT DISTINCT CITY
FROM STATION
WHERE CITY LIKE 'A%')
UNION
(SELECT DISTINCT CITY
FROM STATION
WHERE CITY LIKE 'E%')
UNION
(SELECT DISTINCT CITY
FROM STATION
WHERE CITY LIKE 'I%')
UNION
(SELECT DISTINCT CITY
FROM STATION
WHERE CITY LIKE 'O%')
UNION
(SELECT DISTINCT CITY
FROM STATION
WHERE CITY LIKE 'U%');

--9. Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates. 
(SELECT DISTINCT CITY
FROM STATION
WHERE CITY LIKE '%A')
UNION
(SELECT DISTINCT CITY
FROM STATION
WHERE CITY LIKE '%E')
UNION
(SELECT DISTINCT CITY
FROM STATION
WHERE CITY LIKE '%I')
UNION
(SELECT DISTINCT CITY
FROM STATION
WHERE CITY LIKE '%O')
UNION
(SELECT DISTINCT CITY
FROM STATION
WHERE CITY LIKE '%U');

--10.Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u)
--as both their first and last characters. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION
WHERE (CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%')
AND (CITY LIKE '%A' OR CITY LIKE '%E' OR CITY LIKE '%I' OR CITY LIKE '%O' OR CITY LIKE '%U');

--11. Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION
WHERE NOT (CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%'); 

--12. Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY 
FROM STATION
WHERE NOT (CITY LIKE '%A' OR CITY LIKE '%E' OR CITY LIKE '%I' OR CITY LIKE '%O' OR CITY LIKE '%U');

--13. Query the list of CITY names from STATION that either do not start 
--with vowels or do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY 
FROM STATION 
WHERE LEFT(CITY,1) 
NOT IN ('a', 'o', 'u', 'i', 'e') 
OR RIGHT(City, 1) 
NOT IN ('a', 'o', 'u', 'i', 'e');

--14. Query the list of CITY names from STATION that do not start
--with vowels and do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY 
FROM STATION 
WHERE LEFT(CITY,1) 
NOT IN ('a', 'o', 'u', 'i', 'e') 
AND RIGHT(City, 1) 
NOT IN ('a', 'o', 'u', 'i', 'e');

--15. Query the Name of any student in STUDENTS who scored higher than  Marks. Order your output by the last three characters of 
--each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.
SELECT NAME
FROM STUDENTS
WHERE MARKS > 75
ORDER BY RIGHT(NAME,3), ID ASC;

--16. Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order. 
SELECT NAME
FROM EMPLOYEE
ORDER BY NAME;

--17. Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having
--a salary greater than  per month who have been employees for less than  months. Sort your result by ascending employee_id.
SELECT NAME 
FROM EMPLOYEE
WHERE SALARY > 2000
AND MONTHS < 10
ORDER BY EMPLOYEE_ID;

--18. P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):
* * * * * 
* * * * 
* * * 
* * 
*
--Write a query to print the pattern P(20).

DELIMITER //

CREATE PROCEDURE print (IN n INTEGER)
BEGIN
    WHILE n > 0 DO
        SELECT REPEAT('* ', n);
        SET n = n - 1;
    END WHILE;
END //

CALL print(20);

--19. P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):
* 
* * 
* * * 
* * * * 
* * * * *
Write a query to print the pattern P(20).

DELIMITER //

CREATE PROCEDURE print (IN n INTEGER) BEGIN DECLARE x INTEGER; SET x = n;

WHILE n > 0 DO
    SELECT REPEAT('* ', x - n + 1);
    SET n = n - 1 ;
END WHILE;
END //

CALL print(20);

--20. Write a query to print all prime numbers less than or equal to 1000. Print your result on a single line, and use the ampersand (&) character as your separator (instead of a space).
--For example, the output for all prime numbers <= would be:
2&3&5&7

delimiter $$
create procedure prime()
begin
    declare i,d,c int;
    declare result VARCHAR(1000);
    set i = 2;
    set d = 1;
    set c = 1;
    set result = '';
    
    while (i<1000) do
        
        l: while (d<=i) do
            if(i%d=0) then
                set c = c + 1;
                if (c>3) then
                    leave l;
                end if;
                if (i=d) then
                    set result = concat(result, i, "&");
                    set c = 0;
                end if;
                
            end if;
            set d = d + 1;
        end while l;
        set d = 1;
        set i = i + 1;
        set c = 1;
        
    end while;
    select left(result, CHAR_LENGTH(result)-1);
end $$

call prime()


