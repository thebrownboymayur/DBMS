DELIMITER //
CREATE PROCEDURE BookFine(roll_new INT, book_name VARCHAR(30))
BEGIN
    DECLARE X INT;
    DECLARE CONTINUE HANDLER FOR NOT FOUND
    BEGIN
        SELECT CONCAT('ROLL NO ', roll_new, ' NOT FOUND') AS NoRecord;
    END;

    SELECT DATEDIFF(CURDATE(), DateofIssue) INTO X 
    FROM Borrower 
    WHERE Roll_no = roll_new;

    IF (X > 15 AND X <= 30) THEN
        INSERT INTO Fine VALUES (roll_new, CURDATE(), (X * 5));
    ELSEIF (X > 30) THEN
        INSERT INTO Fine VALUES (roll_new, CURDATE(), (X * 50));
    END IF;

    UPDATE Borrower SET Status = 'R' WHERE Roll_no = roll_new;
END //
DELIMITER ;
