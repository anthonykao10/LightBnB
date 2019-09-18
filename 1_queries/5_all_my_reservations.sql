/*
Show all reservations for a user.

- Select all columns from the reservations table, all columns from the properties table, and the average rating of the property.
- Order the results from most recent start_date to least recent start_date.
- These will end up being filtered by either "Upcoming Reservations" or "Past Reservations", so only get reservations where the end_date is in the past.
- Use now()::date to get today's date.
- This will only be for a single user, so use 1 for the user_id.
- Limit the results to 10.
*/


/* Get average rating for each property: */
-- SELECT property_id, AVG(rating)
-- FROM property_reviews
-- GROUP BY property_id

/* Join "average rating by property" (on property) with reservations table */
SELECT res.*, properties.*, average_rating
-- SELECT properties.id, properties.title, properties.cost_per_night, res.start_date, average_rating
FROM reservations AS res
JOIN (
  SELECT property_id, AVG(rating) AS average_rating
  FROM property_reviews
  GROUP BY property_id
) AS reviews ON reviews.property_id = res.property_id
JOIN properties ON properties.id = res.property_id
WHERE res.end_date < now()::date
AND res.guest_id = 1
ORDER BY res.start_date
LIMIT 10


/* Example solution */
-- SELECT properties.*, reservations.*, avg(rating) as average_rating
-- SELECT properties.id, properties.title, properties.cost_per_night, reservations.start_date, avg(rating) as average_rating
-- FROM reservations
-- JOIN properties ON reservations.property_id = properties.id
-- JOIN property_reviews ON properties.id = property_reviews.property_id 
-- WHERE reservations.guest_id = 1
-- AND reservations.end_date < now()::date
-- GROUP BY properties.id, reservations.id
-- ORDER BY reservations.start_date
-- LIMIT 10;