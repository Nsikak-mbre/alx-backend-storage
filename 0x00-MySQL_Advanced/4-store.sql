-- Trigger decreases the quantity of an item when a new order is placed
DELIMITER //

-- Drop the existing trigger if it exists
DROP TRIGGER IF EXISTS decrease_quantity //

CREATE TRIGGER decrease_quantity
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
  UPDATE items
  SET quantity = quantity - NEW.number
  WHERE name = NEW.item_name;
END //

DELIMITER ;
