CREATE TABLE Emp_subset
(
  Day INT,
  date_taken text,
  HighTempF INT,
  temp_diff int
);
INSERT INTO Emp_subset (Day, date_taken, HighTempF,temp_diff)
SELECT 
 m1.Day, 
  date_format(m1.Date, '%Y-%m-%d') AS date_taken,
  m1.TempHighF,
  COALESCE(m1.TempHighF - (SELECT m2.TempHighF 
                     FROM weatherhilow AS m2
                     WHERE m2.Day = m1.Day - 1) >10,
           0)  AS temp_diff
FROM weatherhilow AS m1;
SELECT * 
FROM emp_subset
WHERE temp_diff>0