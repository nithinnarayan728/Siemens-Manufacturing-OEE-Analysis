USE ManufacturingOEE ;

-- conversion of date column from varchar to date datatype
UPDATE OEE_Data
SET `date` = STR_TO_DATE(`date`,'%c/%e/%Y');

SET SQL_SAFE_UPDATES = 0;  -- turnsoff the safetylock

UPDATE OEE_Data
SET `date` = STR_TO_DATE(`date`, '%c/%e/%Y');

SET SQL_SAFE_UPDATES = 1; -- turnson the safety lock again

SELECT `date` -- Crosschecks
FROM OEE_Data
LIMIT 20;

SELECT COUNT(*) -- Crosschecks
FROM OEE_Data
WHERE `date` IS NULL;

ALTER TABLE OEE_Data -- Altering_datatype
MODIFY `date` DATE ;

DESCRIBE OEE_Data ;