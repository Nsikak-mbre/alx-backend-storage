DELIMITER //

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS create_user_table_if_not_exists //

CREATE PROCEDURE create_user_table_if_not_exists()
BEGIN
    -- Declare variables to store the results of checks
    DECLARE table_exists INT DEFAULT 0;
    DECLARE column_exists INT DEFAULT 0;

    -- Check if the users table exists
    SELECT COUNT(*) INTO table_exists
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE table_schema = DATABASE() -- current database
    AND table_name = 'users';

    -- If the table does not exist, create it
    IF table_exists = 0 THEN
        CREATE TABLE users (
            id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
            email VARCHAR(255) NOT NULL UNIQUE,
            name VARCHAR(255),
            country ENUM('US', 'CO', 'TN') NOT NULL DEFAULT 'US'
        );
    END IF;

    -- Check if the country column exists in the users table
    SELECT COUNT(*) INTO column_exists
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE table_schema = DATABASE()
    AND table_name = 'users'
    AND column_name = 'country';

    -- Add the country column if it does not exist
    IF column_exists = 0 THEN
        ALTER TABLE users ADD COLUMN country ENUM('US', 'CO', 'TN') NOT NULL DEFAULT 'US';
    END IF;
END //

DELIMITER ;

-- Call the stored procedure to ensure the table and column are created/modified as needed
CALL create_user_table_if_not_exists();
