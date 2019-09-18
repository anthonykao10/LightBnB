INSERT INTO users (name, email, password) VALUES 
('Eva Stanley', 'sebastianguerra@ymail.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u'),
('Louisa Meyer', 'jacksonrose@hotmail.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u'),
('Dominic Parks', 'victoriablackwell@outlook.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u'),
('Sue Luna', 'jasonvincent@gmx.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u'),
('Rosalie Garza', 'jacksondavid@gmx.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u'),
('Etta West', 'charlielevy@yahoo.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u'),
('Margaret Wong', 'makaylaweiss@icloud.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u'),
('Leroy Hart', 'jaycereynolds@inbox.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u');

INSERT INTO properties (owner_id, title, description, thumbnail_photo_url, cover_photo_url, cost_per_night, parking_spaces, number_of_bathrooms, number_of_bedrooms, country, street, city, province, post_code, active) VALUES 
(1, 'Speed lamp', 'description', 'https://www.pexels.com/photo/blue-jellyfish-illustration-2166927/', 'https://www.pexels.com/photo/snow-covered-mountain-2086620', 93061, 6, 4, 8, 'Canada', '536 Namsub Highway', 'Sotboske', 'Quebec', '28142', true),
(1, 'Blank corner', 'description', 'https://www.pexels.com/photo/blue-jellyfish-illustration-2166927/', 'https://www.pexels.com/photo/snow-covered-mountain-2086620', 85234, 6, 6, 7, 'Canada', '651 Nami Road', 'Bohbatev', 'Alberta', '83680', true),
(2, 'Habit mix', 'description', 'https://www.pexels.com/photo/blue-jellyfish-illustration-2166927/', 'https://www.pexels.com/photo/snow-covered-mountain-2086620', 46058, 0, 5, 6, 'Canada', '4207 Barrydowne Road', 'Sudbury', 'Ontario', '63186', true),
(4, 'Headed know', 'description', 'https://www.pexels.com/photo/blue-jellyfish-illustration-2166927/', 'https://www.pexels.com/photo/snow-covered-mountain-2086620', 82640, 0, 5, 5, 'Canada', '1725 rue Levy', 'Montreal', 'Quebec', '84723', true),
(6, 'Port out', 'description', 'https://www.pexels.com/photo/blue-jellyfish-illustration-2166927/', 'https://www.pexels.com/photo/snow-covered-mountain-2086620', 2358, 2, 8, 0, 'Canada', '3752 Brand Road', 'Humboldt', 'Saskatchewan', '19372', true),
(6, 'Fun glad', 'description', 'https://www.pexels.com/photo/blue-jellyfish-illustration-2166927/', 'https://www.pexels.com/photo/snow-covered-mountain-2086620', 34291, 6, 6, 4, 'Canada', '3218  Bank St', 'Ottawa', 'Ontario', '37482', true),
(7, 'Shine twenty', 'description', 'https://www.pexels.com/photo/blue-jellyfish-illustration-2166927/', 'https://www.pexels.com/photo/snow-covered-mountain-2086620', 13644, 1, 7, 8, 'Canada', '147 Goyeau Ave', 'Windsor', 'Ontario', '28142', true),
(8, 'Game fill', 'description', 'https://www.pexels.com/photo/blue-jellyfish-illustration-2166927/', 'https://www.pexels.com/photo/snow-covered-mountain-2086620', 23428, 5, 6, 4, 'Canada', '4867 Port Washington Road', 'Manyberries', 'Alberta', '78475', true);

INSERT INTO reservations (start_date, end_date, property_id, guest_id) VALUES
('2018-09-11', '2018-09-26', 3, 1),
('2019-01-04', '2019-02-01', 1, 3),
('2021-10-14', '2021-10-14', 2, 2),
('2014-10-21', '2014-10-21', 2, 4),
('2016-07-17', '2016-08-01', 6, 1),
('2018-05-01', '2018-05-27', 5, 6),
('2022-10-04', '2022-10-23', 1, 8),
('2015-09-13', '2015-09-30', 2, 8),
('2023-05-27', '2023-05-28', 8, 7),
('2023-04-23', '2023-05-02', 4, 4);

INSERT INTO property_reviews (guest_id, property_id, reservation_id, rating, message) VALUES 
(2, 5, 4, 3, 'message'),
(1, 4, 1, 4, 'message'),
(7, 1, 2, 4, 'message'),
(3, 8, 5, 4, 'message'),
(4, 2, 7, 5, 'message'),
(4, 3, 4, 4, 'message'),
(5, 6, 3, 5, 'message');