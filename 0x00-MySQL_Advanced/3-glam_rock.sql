DELIMITER //

-- Lists all the band with Glam rock
-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS get_glam_rock_bands //

CREATE PROCEDURE get_glam_rock_bands()
BEGIN
    SELECT 
        band_name,
        CASE 
            WHEN split IS NULL THEN (2022 - formed)
            ELSE (split - formed)
        END AS lifespan
    FROM metal_bands
    WHERE LOWER(style) LIKE '%glam rock%'
    ORDER BY lifespan DESC;
END //

DELIMITER ;
-- Call the stored procedure after it is created
CALL get_glam_rock_bands;
