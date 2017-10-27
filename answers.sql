/* 
1) Select a distinct list of ordered airports (departure) codes. Be sure to name the column correctly. Be sure to order the results correctly. 
*/
SELECT DISTINCT departAirport AS Airports FROM flight ORDER BY Airports ASC;

/* 
2) Provide a list of delayed flights departing from San Francisco (SFO).
*/
SELECT airline.name, flightNumber, scheduledDepartDateTime, arriveAirport, status FROM flight INNER JOIN airline ON flight.airlineID = airline.ID WHERE status = 'delayed' AND departAirport = 'SFO';

/* 
3) Provide a distinct list of cities that American airlines departs from.
*/
SELECT DISTINCT departAirport AS Cities FROM airline INNER JOIN flight ON airline.ID = flight.airlineID WHERE airline.name = 'American';

/* 
4) Provide a distinct list of airlines that conduct flights departing from ATL.
*/
SELECT DISTINCT airline.name AS Airline FROM airline INNER JOIN flight ON airline.ID = flight.airlineID WHERE flight.departAirport = 'ATL';

/* 
5) Provide a list of airlines, flight numbers, departing airports, and arrival airports where flights departed on time.
*/
SELECT airline.name, flightNumber, departAirport, arriveAirport FROM airline INNER JOIN flight ON airline.ID = flight.airlineID WHERE actualDepartDateTime IS NOT NULL AND actualDepartDateTime - scheduledDepartDateTime = 0;

/* 
6) Provide a list of airlines, flight numbers, gates, status, and arrival times arriving into Charlotte (CLT) on 10-30-2017. Order your results by the arrival time.
*/
SELECT airline.name AS Airline, flightNumber AS Flight, gate AS Gate, TIME(scheduledArriveDateTime) AS Arrival, status AS Status FROM airline INNER JOIN flight ON airline.ID = flight.airlineID WHERE arriveAirport = 'CLT' AND DATE(scheduledArriveDateTime) = '2017-10-30' ORDER BY Arrival;

/* 
7) List the number of reservations by flight number. Order by reservations in descending order.
*/
SELECT flightNumber AS flight, COUNT(reservation.ID) AS reservations FROM flight INNER JOIN reservation ON flight.ID = reservation.flightID GROUP BY flightNumber ORDER BY reservations DESC;

/* 
8) List the average ticket cost for coach by airline and route. Order by AverageCost in descending order.
*/
SELECT airline.name AS airline, departAirport, arriveAirport, AVG(cost) AS AverageCost FROM airline INNER JOIN flight ON airline.ID = flight.airlineID INNER JOIN reservation ON flight.ID = reservation.flightID WHERE class = 'coach' GROUP BY airline, departAirport, arriveAirport ORDER BY AverageCost DESC;

/* 
9) Which route is the longest?
*/
SELECT departAirport, arriveAirport, miles FROM flight ORDER BY miles DESC LIMIT 1;

/* 
10) List the top 5 passengers that have flown the most miles. Order by miles.
*/
SELECT firstName, lastName, SUM(miles) AS miles FROM passenger INNER JOIN reservation ON passenger.ID = reservation.passengerID INNER JOIN flight ON flight.ID = reservation.flightID GROUP BY firstName, lastName ORDER BY SUM(miles) DESC LIMIT 5;

/* 
11) Provide a list of upcoming scheduled American airline flights ordered by route and arrival date and time.
*/
SELECT name AS Name, CONCAT(departAirport, ' --> ', arriveAirport) AS Route, DATE(scheduledArriveDateTime) AS 'Arrive Date', TIME(scheduledArriveDateTime) AS 'Arrive Time' FROM airline INNER JOIN flight ON airline.ID = flight.airlineID WHERE name = 'American' ORDER BY Route, scheduledArriveDateTime;

/* 
12) Provide a report that counts the number of reservations and totals the reservation costs (as Revenue) by Airline, flight, and route. Order the report by total revenue in descending order.
*/
SELECT name AS Airline, flightNumber AS Flight, CONCAT(departAirport, ' --> ', arriveAirport) AS Route, COUNT(reservation.flightID) AS 'Reservation Count', SUM(cost) AS Revenue FROM airline INNER JOIN flight ON airline.ID = flight.airlineID INNER JOIN reservation ON flight.ID = reservation.flightID GROUP BY Airline, Flight, Route ORDER BY Revenue DESC;

/* 
13) List the average cost per reservation by route. Round results down to the dollar.
*/
SELECT CONCAT(departAirport, ' --> ', arriveAirport) AS Route, FLOOR(AVG(cost)) AS 'Avg Revenue' FROM flight INNER JOIN reservation ON flight.ID = reservation.flightID GROUP BY Route ORDER BY FLOOR(AVG(cost)) DESC;

/* 
14) List the average miles per flight by airline.
*/
SELECT name AS Airline, AVG(miles) AS 'Avg Miles Per Flight' FROM airline INNER JOIN flight ON airline.ID = flight.airlineID GROUP BY Airline ORDER BY Airline ASC;

/* 
15) Which airlines had flights that arrived early?
*/
SELECT DISTINCT name AS Airline FROM airline INNER JOIN flight ON airline.ID = flight.airlineID WHERE actualArriveDateTime < scheduledArriveDateTime AND status = 'arrived';