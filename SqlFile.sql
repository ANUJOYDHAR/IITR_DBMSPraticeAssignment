create database travelonthego;


use travelonthego;

-- 1) You are required to create two tables PASSENGER and PRICE 

create table passenger (
Id int not null primary key auto_increment,
Passenger_name varchar(50),
Category varchar(50),
Gender varchar(1),
Boarding_City varchar(50),
Destination_City varchar(50),
Distance int,
Bus_Type varchar(50)
);

create table price(
Id int not null primary key auto_increment,
Bus_Type varchar(50),
Distance int,
Price int
);


-- 2) Insert 
insert into passenger values(1, 'Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper');
insert into passenger values(2, 'Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 700, 'Sitting');
insert into passenger values(3, 'Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper');
insert into passenger values(4, 'Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper');
insert into passenger values(5, 'Udit', 'Non-AC', 'M', 'Trivandrum', 'Panaji', 1000, 'Sleeper');
insert into passenger values(6, 'Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 500, 'Sitting');
insert into passenger values(7, 'Hemant', 'Non-AC', 'M', 'Panaji', 'Mumbai', 700, 'Sleeper');
insert into passenger values(8, 'Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting');
insert into passenger values(9, 'Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting');



insert into price(Bus_Type, Distance, Price) values('Sleeper', 350, 770);
insert into price(Bus_Type, Distance, Price) values('Sleeper', 500, 1100);
insert into price(Bus_Type, Distance, Price) values('Sleeper', 600, 1320);
insert into price(Bus_Type, Distance, Price) values('Sleeper', 700, 1540);
insert into price(Bus_Type, Distance, Price) values('Sleeper', 1000, 2200);
insert into price(Bus_Type, Distance, Price) values('Sleeper', 1200, 2640);
insert into price(Bus_Type, Distance, Price) values('Sleeper', 350, 2700);
insert into price(Bus_Type, Distance, Price) values('Sitting', 500, 620);
insert into price(Bus_Type, Distance, Price) values('Sitting', 600, 744);
insert into price(Bus_Type, Distance, Price) values('Sitting', 700, 868);
insert into price(Bus_Type, Distance, Price) values('Sitting', 1000, 1240);
insert into price(Bus_Type, Distance, Price) values('Sitting', 1200, 1488);
insert into price(Bus_Type, Distance, Price) values('Sitting', 1500, 1860);


-- 3)	How many females and how many male passengers travelled for a minimum distance of 600 KM s?
Select Gender , count(Gender) as GenderCount from passenger  where distance >=600 group by gender

-- 4)	Find the minimum ticket price for Sleeper Bus. 
Select min(price) from price where bus_type = 'Sleeper';

-- 5)	Select passenger names whose names start with character 'S' 
select passenger_name from passenger where passenger_name  like 'S%' 

-- 6)	Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output
Select pa.passenger_name, pa.boarding_city, pa.destination_city, pa.bus_type, pr.price as ticket_price 
from passenger pa inner join price pr on pa.bus_type = pr.bus_type and pa.distance = pr.distance


-- 7)	What are the passenger name/s and his/her ticket price who travelled in the Sitting bus  for a distance of 1000 KMs 

Select pa.passenger_name, pr.price as ticket_price 
from passenger as pa

inner join

(Select bus_type , distance,  price from price where Bus_Type = 'Sitting' and distance <= 1000)

as pr

 on pa.bus_type = pr.bus_type and pa.distance = pr.distance
 

-- 8)	What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
select Price, Bus_Type
from  price
where Distance = (select Distance from `Passenger` where Boarding_City="Panaji" and Destination_City="Bengaluru" ) ;



-- 9) List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.
select distinct distance from passenger order by Distance desc;

-- 10)	Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables 
Select passenger_name, (distance /(Select sum(distance) from passenger) * 100) as Percentage from passenger;


-- 11)	Display the distance, price in three categories in table Price
-- a)	Expensive if the cost is more than 1000
-- b)	Average Cost if the cost is less than 1000 and greater than 500
-- c)	Cheap otherwise



Select distance, price,
case  
	when price > 1000 then 'Expensive'
    when price <= 1000 and price > 500 then 'Average Cost'
    else 'Cheap'
end as price_category
from price;
