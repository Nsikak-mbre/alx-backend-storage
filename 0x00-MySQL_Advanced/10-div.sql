DELIMITER //

-- Drop the function if it already exists
DROP FUNCTION IF EXISTS SafeDiv //

-- Create the SafeDiv function
CREATE FUNCTION SafeDiv(a INT, b INT) 
RETURNS DECIMAL(10, 4) -- Adjust the precision as needed
DETERMINISTIC
BEGIN
    -- Check if b is zero and return 0, otherwise perform the division
    RETURN IF(b = 0, 0, a / b);
END //

DELIMITER ;