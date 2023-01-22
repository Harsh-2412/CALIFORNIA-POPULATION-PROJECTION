/* check the loaded data */
SELECT 
  * 
FROM 
  CALI_POPULATION;
  

/* Inital list of male and female populations per county for 2014 */

select 
  county_name, 
  gender, 
  Sum(population) AS total_population 
from 
  cali_population 
where 
  Date_year = 2014 
group by 
  county_name, 
  Gender 
order by 
  county_name;
/* return information in specially formatted table */

/*1. WRITING THE QUERY USING 'CASE' to list of male and female populations per county for 2014 */
SELECT 
  county_name, 
  SUM(
    CASE WHEN gender = 'Female' THEN population ELSE 0 END
  ) as Female, 
  SUM(
    CASE WHEN gender = 'Male' THEN population ELSE 0 END
  ) as Male 
FROM 
  Cali_population 
WHERE 
  Date_year = 2014 
GROUP BY 
  county_name 
ORDER BY 
  county_name;
/* 2. writing the the same query with a CTE(common table expressions)*/
with female_pop AS (
  select 
    county_name, 
    sum(population) AS female 
  from 
    cali_population 
  where 
    Date_year = 2014 
    and gender = 'female' 
  group by 
    County_name
), 
male_pop AS (
  select 
    county_name, 
    sum(population) AS male 
  from 
    cali_population 
  where 
    date_year = 2014 
    and gender = 'male' 
  group by 
    County_name
) 
SELECT 
  f.county_name, 
  f.female, 
  m.male 
from 
  female_pop f 
  join male_pop m ON f.county_name = m.county_name 
order by 
  f.county_name;
