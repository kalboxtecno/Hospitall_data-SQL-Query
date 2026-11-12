CREATE TABLE HOSPITAL_DATA (
	"Hospital Name" VARCHAR(100),
	"Location" VARCHAR(100),
	"Department" VARCHAR(100),
	"Doctors Count" INT,
	"Patients Count" INT,
	"Admission Date" DATE,
	"Discharge Date" DATE,
	"Medical Expenses" DECIMAL(10, 2)
);

SET
	DATESTYLE = 'ISO, DMY';

COPY HOSPITAL_DATA
FROM
	'C:\Users\ankit\OneDrive\Desktop\Hospital_Data.csv'
WITH
	(FORMAT CSV, HEADER TRUE);

SELECT
	*
FROM
	HOSPITAL_DATA;

--Write an SQL query to find the total number of patients across all hospitals.
SELECT
	SUM("Patients Count") AS TOTALL_PATIENTS
FROM
	HOSPITAL_DATA;

--o Retrieve the average count of doctors available in each hospital. 
SELECT
	"Hospital Name",
	AVG("Doctors Count") AS AVERAGE_DOCTOR
FROM
	HOSPITAL_DATA
GROUP BY
	"Hospital Name";

--Find the top 3 hospital departments that have the highest number of patients. 
SELECT
	"Department",
	SUM("Patients Count") AS NO_PATIENTS
FROM
	HOSPITAL_DATA
GROUP BY
	"Department"
ORDER BY
	NO_PATIENTS DESC
LIMIT
	3;

--Identify the hospital that recorded the highest medical expenses. 
SELECT
	"Hospital Name",
	MAX("Medical Expenses") AS HIGHEST_EXPENSES
FROM
	HOSPITAL_DATA
GROUP BY
	"Hospital Name"
ORDER BY
	HIGHEST_EXPENSES DESC
LIMIT
	1;

--Calculate the average medical expenses per day for each hospital.
SELECT
	"Hospital Name",
	AVG(
		"Medical Expenses" / NULLIF("Discharge Date" - "Admission Date", 0)
	) AS AVERAGE_EXPENSES
FROM
	HOSPITAL_DATA
GROUP BY
	"Hospital Name";

--Find the patient with the longest stay by calculating the difference between Discharge Date and Admission Date.
select "Patients Count" ,"Discharge Date"-"Admission Date" as longest_stay
from hospital_data
order by longest_stay desc
limit 1;

--Count the total number of patients treated in each city. 
select * from hospital_data
order by "Location";
select "Location" as city, sum("Patients Count") as totall_no_patients
from hospital_data
group by "Location";

--Calculate the average number of days patients spend in each department. 
select "Department",Round(Avg("Discharge Date"-"Admission Date"),2) as average_no_days
from hospital_data
group by "Department";

--Find the department with the least number of patients. 
select "Department",sum("Patients Count") as least_No_patients
from hospital_data
group by "Department"
order by least_No_patients;

--Group the data by month and calculate the total medical expenses for each month. 
Select Extract(month From "Admission Date") as month,sum("Medical Expenses") as Totall_expenses
from hospital_data
group by month
order by Month;

Select To_char("Admission Date",'Month')as month,sum("Medical Expenses") as Totall_expenses
from hospital_data
group by month
order by Month asc;


