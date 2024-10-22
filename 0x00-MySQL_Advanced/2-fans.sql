-- Import the table dump
SOURCE /home/nk/alx-backend-storage/0x00-MySQL_Advanced/metal_bands.sql;

-- Rank country origins of bands by the number of fans
SELECT origin, SUM(fans) AS nb_fans
FROM metal_bands
GROUP BY origin
ORDER BY nb_fans DESC;