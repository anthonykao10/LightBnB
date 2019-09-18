/*
Get a list of the most visited cities.
- Select the name of the city and the number of reservations for that city.
- Order the results from highest number of reservations to lowest number of reservations. 
*/

SELECT city, COUNT(reservations.id) AS total_reservations
FROM property_reviews
JOIN properties ON properties.id = property_id
JOIN reservations ON reservations.id = reservation_id
GROUP BY city
ORDER BY total_reservations DESC;