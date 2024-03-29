const properties = require('./json/properties.json');
const users = require('./json/users.json');
const { Pool } = require('pg');

// Connect to db
const pool = new Pool({
  user: 'vagrant',
  password: '123',
  host: 'localhost',
  database: 'lightbnb'
});

/// Users

/**
 * Get a single user from the database given their email.
 * @param {String} email The email of the user.
 * @return {Promise<{}>} A promise to the user.
 */
const getUserWithEmail = function(email) {
  const queryString = `
  SELECT * FROM users
  WHERE email = $1;
  `;
  const queryParams = [email];

  return pool.query(queryString, queryParams)
    .then(res => {
      // user not found
      if (!res.rows[0]) return null;
      return res.rows[0];
    })
    .catch(err => console.error('\nerror fetching user:\n', err));
}
exports.getUserWithEmail = getUserWithEmail;

/**
 * Get a single user from the database given their id.
 * @param {string} id The id of the user.
 * @return {Promise<{}>} A promise to the user.
 */
const getUserWithId = function(id) {
  const queryString = `
    SELECT * FROM users
    WHERE id = $1
  `;
  const queryParams = [id];
  return pool.query(queryString, queryParams)
    .then(res => {
      // user not found
      if (!res.rows[0]) return null;
      return res.rows[0]
    })
    .catch(err => console.error('\nerror fetching user:\n', err));
}
exports.getUserWithId = getUserWithId;


/**
 * Add a new user to the database.
 * @param {{name: string, password: string, email: string}} user
 * @return {Promise<{}>} A promise to the user.
 */
const addUser =  function(user) {
  const queryString = `
    INSERT INTO users (name, email, password)
    VALUES ($1, $2, $3)
    RETURNING *;
  `;
  const queryParams = [user.name, user.email, user.password];

  return pool.query(queryString, queryParams)
    .then(res => res.rows[0])
    .catch(err => console.error('\nerror inserting:\n', err));
}
exports.addUser = addUser;

/// Reservations

/**
 * Get all reservations for a single user.
 * @param {string} guest_id The id of the user.
 * @return {Promise<[{}]>} A promise to the reservations.
 */
const getAllReservations = function(guest_id, limit = 10) {
  const queryString = `
    SELECT properties.*, reservations.*, avg(rating) as average_rating
    FROM reservations
      JOIN properties ON reservations.property_id = properties.id
      JOIN property_reviews ON properties.id = property_reviews.property_id 
    WHERE reservations.guest_id = $1
    AND reservations.end_date < now()::date
    GROUP BY properties.id, reservations.id
    ORDER BY reservations.start_date
    LIMIT $2;
  `;
  const queryParams = [guest_id, limit];
  return pool.query(queryString, queryParams)
    .then(res => res.rows)
    .catch(err => console.log('\nerror getting reservations:\n', err)); 
}
exports.getAllReservations = getAllReservations;

/// Properties

/**
 * Get all properties.
 * @param {{}} options An object containing query options.
 * @param {*} limit The number of results to return.
 * @return {Promise<[{}]>}  A promise to the properties.
 */
const getAllProperties = function(options, limit = 10) {
  const queryParams = [];

  let queryString = `
  SELECT properties.*, avg(property_reviews.rating) as average_rating
  FROM properties
  FULL OUTER JOIN property_reviews ON properties.id = property_id
  `;

  if (options.city) {
    queryParams.push(`%${options.city}%`);
    queryString += `WHERE city LIKE $${queryParams.length} `;
  }

  if (options.owner_id) {
    queryParams.push(options.owner_id);
    let operator = '';
    if (options.city) {
      operator = 'AND';
    } else {
      operator = 'WHERE';
    }
    queryString += `${operator} owner_id = $${queryParams.length} `;
  }

  if (options.minimum_price_per_night) {
    queryParams.push(options.minimum_price_per_night);
    let operator = '';
    if (options.city || options.owner_id) {
      operator = 'AND';
    } else {
      operator = 'WHERE';
    }
    queryString += `${operator} cost_per_night > $${queryParams.length} `;
  }

  if (options.maximum_price_per_night) {
    queryParams.push(options.maximum_price_per_night);
    let operator = '';
    if (options.city || options.owner_id || options.minimum_price_per_night) {
      operator = 'AND';
    } else {
      operator = 'WHERE';
    }
    queryString += `${operator} cost_per_night < $${queryParams.length} `;
  }

  if (options.minimum_rating) {
    queryParams.push(options.minimum_rating);
    queryString += `
    GROUP BY properties.id
    HAVING avg(property_reviews.rating) >= $${queryParams.length}
    `;
    queryParams.push(limit);
    queryString += `
    ORDER BY cost_per_night
    LIMIT $${queryParams.length};
    `;
  } else {
    queryParams.push(limit);
    queryString += `
    GROUP BY properties.id
    ORDER BY cost_per_night
    LIMIT $${queryParams.length};
    `;
  }

  // console.log('\n=================\n');
  // console.log(queryString);
  // console.log(queryParams);
  // console.log('\n=================\n');

  return pool.query(queryString, queryParams)
  .then(res => res.rows);
};
exports.getAllProperties = getAllProperties;


/**
 * Add a property to the database
 * @param {{}} property An object containing all of the property details.
 * @return {Promise<{}>} A promise to the property.
 */
const addProperty = function(property) {
  const queryString = `
    INSERT INTO properties (
      title, 
      description, 
      owner_id, 
      cover_photo_url, 
      thumbnail_photo_url, 
      cost_per_night, 
      parking_spaces, 
      number_of_bathrooms, 
      number_of_bedrooms, 
      province, 
      city, 
      country, 
      street, 
      post_code
    )
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14)
    RETURNING *;
  `;
  const queryParams = [
    property.title,
    property.description, 
    property.owner_id, 
    property.cover_photo_url, 
    property.thumbnail_photo_url, 
    property.cost_per_night, 
    property.parking_spaces, 
    property.number_of_bathrooms, 
    property.number_of_bedrooms, 
    property.province, 
    property.city, 
    property.country, 
    property.street, 
    property.post_code
  ];

  return pool.query(queryString, queryParams)
    .then(res => {
      console.log(res.rows[0]);
      return res.rows[0];
    })
    .catch(err => console.log('\nerror creating property:\n', err));
}
exports.addProperty = addProperty;
