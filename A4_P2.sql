--COMP2521-001
--Assignment 4 part 2
--Joseph G.

--Queries

--Exercise 1

--2
DROP PROCEDURE addAuthor;

DELIMITER $$
CREATE PROCEDURE addAuthor (
        IN id char(11),
	IN lname varchar(40),
	IN fname varchar(20))
BEGIN
INSERT INTO author(au_id, au_lname, au_fname)
       VALUES(id,lname,fname);
END$$
DELIMITER ;

SHOW PROCEDURE STATUS WHERE db = 'jgere972';

--3
CALL addAuthor('134555', 'Sebastian','John');
CALL addAuthor('1456600', 'Polos',' Mark');

--4
SELECT *
FROM author
WHERE au_id = '1456600' OR au_id = '134555';

--5
DROP PROCEDURE addTitle;

delimiter $$
CREATE PROCEDURE addTitle (
               IN t_id char(6),
               IN tName varchar(80),
	       IN publisher char(4))
BEGIN
INSERT INTO title(title_id, title, pub_id)
       VALUES(t_id, tName, publisher);
END$$
delimiter ;

--6
CALL addTitle ("4567", "Any Life", "0877");
CALL addTitle ("5784", "ABC", "3235");

--7
SELECT *
FROM title
WHERE title_id = '4567' OR title_id = '5784';

--8
DROP FUNCTION find_title;

delimiter $$
CREATE FUNCTION find_title(titleName CHAR(80))
  RETURNS char(6)
BEGIN
  DECLARE id char(6);
  SELECT title_id
  INTO id
  FROM title
  WHERE title = titleName;
  RETURN id;
END$$
delimiter ;

--9
SELECT find_title ("Any Life") as "id";

--10
SELECT *
FROM author_title
ORDER BY 1,2;

--11
DROP PROCEDURE addAuthorTitle;
delimiter $$
CREATE PROCEDURE addAuthorTitle(
  IN auNbr CHAR(11),
  IN titleName VARCHAR(80),
  IN ordering DECIMAL(3,0),
  IN royalty decimal(6,2))
BEGIN
  INSERT INTO author_title (au_id, title_id, au_ord, royaltyshare)
         VALUES (auNbr, find_title(titleName), ordering, royalty);
END$$
delimiter ;

--12
CALL addAuthorTitle(300, "ABC", 1, 0.6);
CALL addAuthorTitle(400, "Any Life", 2, 0.4);

--13
SELECT au_lname, au_fname, title, au_ord, royaltyshare
FROM author_title AT, author A
WHERE AT.au_id = A.au_id
AND AT.title = "Any Life";

--14 
DROP PROCEDURE addAuthorChecker;

delimiter $$
CREATE PROCEDURE addAuthorChecker
(
  IN id char(11),
  IN fname varchar(20),
  IN lname varchar(40),
  IN addr  varchar(50),
  OUT error varchar(20)
)
BEGIN
  IF addr LIKE "%Justin Bieber% THEN SET error = "invalid entry";
  ELSE INSERT INTO author(au_id, au_lname, au_fname, address)
              VALUES(id, lname, fname, addr);
  END IF;
END$$
delimiter ;

--15
CALL addAuthorChecker("3405", "Selena", "Gomez", "Justin Bieber", @just);

--16
SELECT @just;

--Exercise 2

--1&2
DROP TABLE book_price_audit;

CREATE TABLE book_price_audit(
title_id char(6),
type char(12),
old_price decimal(6,2),
new_price decimal(6,2)
) engine = InnoDB;

--3
--4&5&6&7&8&9&10
DROP TRIGGER book_price_audit_BUR;

delimiter $$
CREATE TRIGGER book_price_audit_BUR BEFORE UPDATE ON title
FOR EACH ROW
BEGIN
  IF (NEW.price/OLD.price) >= 1.1 THEN
  INSERT INTO book_price_audit(title_id, type, old_price, new_price)
  VALUES(OLD.title_id, OLD.type, OLD.price, NEW.price);
  END IF;
END$$
delimiter ;

--11
UPDATE title
SET price = 21.00
WHERE title_id = 'PC8888';

UPDATE title
SET price = 25.00
WHERE title_id = 'BU1032';

--12
SELECT * FROM book_price_audit;

--Exerice 3
ALTER TABLE book_price_audit
ADD audit_Nbr INT;

--1
DROP TRIGGER book_price_audit_BUR;

delimiter $$
CREATE TRIGGER book_price_audit_BUR BEFORE UPDATE ON title
FOR EACH ROW
BEGIN
  IF (NEW.price/OLD.price) >= 1.1 THEN
  INSERT INTO book_price_audit(title_id, type, old_price, new_price)
  VALUES(OLD.title_id, OLD.type, OLD.price, NEW.price);
  END IF;
END$$
delimiter ;

--2
DROP TRIGGER generate_audit_nbr_BIR;

delimiter $$
CREATE TRIGGER generate_audit_nbr_BIR BEFORE INSERT ON book_price_audit
FOR EACH ROW
BEGIN
  DECLARE currentNbr INT;
  DECLARE counter INT;

  SELECT COUNT(*) INTO currentNbr FROM book_price_audit;
    IF currentNbr = 0 THEN
    SET counter = 0;
    ELSE
    SELECT MAX(audit_Nbr) INTO counter FROM book_price_audit;
    END IF;
    SET NEW.audit_Nbr = counter + 1;
END$$
delimiter ;

--Originally price = 11.95      --fix prices by updating back to original prices
UPDATE title
SET price = 15.00
WHERE title_id = 'BU1111';

--Originally price = 7.00
UPDATE title
SET price = 10.00
WHERE title_id = 'PS2106';

--Originally price = 2.99
UPDATE title
SET price = 3.00
WHERE title_id = 'MC3021'; 

--Checking
SHOW TRIGGERS FROM jgere972;
SELECT * FROM book_price_audit;

--Excercise 4
--1&2
UPDATE title
SET total_income = price * ytd_sales;

--3
SELECT price, ytd_sales, total_income
FROM title
WHERE title_id = 'BU1111' OR title_id = 'MC2222';

--4
DROP TRIGGER book_price_audit_cngeBUR;

delimiter $$
CREATE TRIGGER book_price_audit_cngeBUR
BEFORE UPDATE ON title
FOR EACH ROW
BEGIN
   IF (new.price / old.price >= 1.1) THEN
     INSERT INTO book_price_audit (title_id, type, old_price, new_price)
     VALUES (new.title_id, new.type, old.price, new.price);
   END IF;
   IF (new.price <> old.price OR new.ytd_sales <> old.ytd_sales) THEN
      SET new.total_income := new.price * new.ytd_sales;
   END IF;
END$$
delimiter ;

--5
UPDATE title
SET ytd_sales = 4000
WHERE title_id = 'MC2222';

UPDATE title
SET price = 21.99
WHERE title_id = 'BU1111';

SELECT title_id, price, ytd_sales, total_income FROM title WHERE title_id = 'BU1111' OR title_id = 'MC2222';


ALTER TRIGGER book_price_audit_cngeBUR disable;
ALTER TRIGGER book_price_audit_cngeBUR enable;
