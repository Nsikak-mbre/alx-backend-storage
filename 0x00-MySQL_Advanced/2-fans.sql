DELIMITER //

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS rank_country_origins;

-- Create the procedure
CREATE PROCEDURE rank_country_origins()
BEGIN
    -- Rank country origins of bands by the number of fans
    SELECT origin, SUM(fans) AS nb_fans
    FROM metal_bands
    GROUP BY origin
    ORDER BY nb_fans DESC;
END //

DELIMITER ;

-- Call the procedure
CALL rank_country_origins();
