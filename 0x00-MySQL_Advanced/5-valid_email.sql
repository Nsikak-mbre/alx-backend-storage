-- creates a trigger that resets the attribute valid_email
-- only when the email has been changed

-- Drop the exisitng trigger if it exists
DROP TRIGGER IF EXISTS reset_valid_email;

DELIMITER //

CREATE TRIGGER reset_valid_email
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    IF NEW.email != OLD.email THEN
        SET NEW.valid_email = FALSE;
    END IF;
END //

DELIMITER ;