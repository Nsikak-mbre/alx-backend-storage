-- Create an index named idx_name_first on the first letter of the name column
DELIMITER //

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS create_name_first_index //

CREATE PROCEDURE create_name_first_index()
BEGIN
    -- Check if the index already exists
    IF NOT EXISTS (
        SELECT 1 
        FROM information_schema.statistics 
        WHERE table_schema = DATABASE() 
        AND table_name = 'names' 
        AND index_name = 'idx_name_first'
    ) THEN
        -- If the index doesn't exist, create it
        CREATE INDEX idx_name_first ON names (name(1));
    END IF;
END //

DELIMITER ;

-- Optionally, call the procedure after it is created
CALL create_name_first_index;

