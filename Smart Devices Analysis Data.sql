use fixity;
select * from dailyactivity;
select * from sleepday;
select * from hourlysteps;
select * from hourlycalories;
select max(StepTotal) as MaxHourlySteps,max(Calories) as MaxCalories from 
hourlysteps left join hourlycalories on hourlysteps.Id=hourlycalories.Id;
select avg(TotalMinutesAsleep) as AverageMinutesSleep from sleepday;
select avg(SedentaryMinutes+LightlyActiveMinutes+FairlyActiveMinutes+VeryActiveMinutes)
 as AvgActiveMinutes from dailyactivity;
 select avg(TotalDistance) as AvgTotalDistance from dailyactivity;
 SELECT AVG(Calories) AS AvgCaloriesPerHour FROM hourlycalories;
 select max(TotalDistance) as MaxDistance from dailyactivity;
 select min(TotalDistance) as MinDistance from dailyactivity;
 select min(StepTotal) as MinHourlySteps,min(Calories) as MinCalories from 
hourlysteps left join hourlycalories on hourlysteps.Id=hourlycalories.Id;
select max(TotalSteps) as MaxSteps from  dailyactivity;
select min(TotalSteps) as MinSteps from  dailyactivity;
select Id from dailyactivity where TotalSteps=36019;
select distinct Id from dailyactivity where TotalSteps=0;
select distinct Id from dailyactivity where TotalDistance>28;
select distinct Id from dailyactivity where TotalDistance=0;
select distinct Id from sleepday where (TotalTimeInBed-TotalMinutesAsleep)>360;
select distinct Id from sleepday where (TotalTimeInBed-TotalMinutesAsleep)=0;
select distinct Id from dailyactivity where Calories>2000 group by Id;






  
  
 

 
 





