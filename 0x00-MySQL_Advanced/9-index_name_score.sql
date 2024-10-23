DELIMITER //

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS create_idx_name_first_score //

-- Create the stored procedure to add the index
CREATE PROCEDURE create_idx_name_first_score()
BEGIN
    -- Check if the generated column exists, if not, add it
    IF NOT EXISTS (
        SELECT 1
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE table_schema = DATABASE() -- Current database
        AND table_name = 'names'
        AND column_name = 'first_letter'
    ) THEN
        -- Add a generated column for the first letter of name
        ALTER TABLE names ADD COLUMN first_letter CHAR(1) AS (LEFT(name, 1)) STORED;
    END IF;
    
    -- Check if the index already exists, drop it if necessary
    IF EXISTS (
        SELECT 1
        FROM INFORMATION_SCHEMA.STATISTICS
        WHERE table_schema = DATABASE() -- Current database
        AND table_name = 'names'
        AND index_name = 'idx_name_first_score'
    ) THEN
        -- Drop the index if it exists
        DROP INDEX idx_name_first_score ON names;
    END IF;

    -- Create the index on the first_letter and score
    CREATE INDEX idx_name_first_score
    ON names (first_letter, score);
END //

DELIMITER ;

-- Call the stored procedure to create the index
CALL create_idx_name_first_score();
