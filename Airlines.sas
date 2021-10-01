filemame airline '/home/u49317956/Udemy_SAS/airlines.txt';
/*
proc import datafile = airline
	dbms = dlm
	out = airlines replace;
	getnames = no;
	delimiter= '';
run;
*/
data airlines;
	infile airline;
	input
	Airline $ 1-20
	Length 22-28
	Speed 30-36
	Dailyflighttime 38-44
	Populationserved 46-52
	TotalopCost 54-60
	Revenue 62-68
	Loadcap 70-76
	Availablecap 78-84
	Totalassets 86-92
	Investmentsfunds 94-100
	Adjustedassets 102-108;
	format Revenue Totalassets Investmentsfunds Adjustedassets dollar6.2;
	if totalopcost lt 50 then Rating = 5;
	else if totalopcost ge 50 and totalopcost lt 100 then Rating = 4;
	else if totalopcost ge 100 and totalopcost lt 150 then Rating = 3;
	else if totalopcost ge 150 and totalopcost lt 200 then Rating = 2;
	else if totalopcost gt 200 then Rating = 1;
run;

proc chart data = airlines;
vbar rating/discrete;
run; 

proc chart data = airlines;
hbar rating/sumvar = totalopcost type= mean ;
run;

data subset;
	set airlines;
	where substr(airline,1,1) = 'P';
run;

data subset3;
	set airlines;
	where airline like 'P%';
run;

proc sql;
create table subset2 as 
select * from airlines
where airline like 'P%';
quit;

proc sql;
select max(speed) into:FastPlane from airlines ; 
%put --------> &FastPlane;
quit;