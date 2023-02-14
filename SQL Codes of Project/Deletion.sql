-- Deleting student by its ID
DELETE FROM student
WHERE SId = 13;

-- Deleting Associate Professsor
DELETE FROM assistant_prof WHERE AssistPId = 22;

-- Can't delete a prof from a table since they may be a dean or chair.
DELETE FROM prof WHERE PId = 1;

-- Delete Database Management from Courses
DELETE FROM course WHERE CoName = 'DATABASE MANAGEMENT';
