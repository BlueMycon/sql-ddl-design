CREATE TABLE star(
    star_name VARCHAR(50) PRIMARY KEY,
    temp_in_kelvin INT
);

INSERT INTO star
    (star_name, temp_in_kelvin)
VALUES
    ('The Sun', 5800),
    ('Proxima Centauri', 3042),
    ('Gliese 876', 3192);

CREATE TABLE planet(
    planet_name VARCHAR(50) PRIMARY KEY,
    orbital_period_yrs NUMERIC(5,3) NOT NULL
        CHECK (orbital_period_yrs > 0),
    star_orbited VARCHAR(50) NOT NULL REFERENCES star
);

INSERT INTO planet
    (planet_name, orbital_period_yrs, star_orbited)
VALUES
    ( 'Earth', 1.00, 'The Sun'),
    ('Mars', 1.822, 'The Sun'),
    ('Venus', 0.62, 'The Sun'),
    ('Proxima Centauri b', 0.03, 'Proxima Centauri'),
    ('Gliese 876 b', 0.236, 'Gliese 876');

CREATE TABLE moon(
    moon_name VARCHAR(50) PRIMARY KEY,
    planet_orbited VARCHAR(50) NOT NULL REFERENCES planet
);

INSERT INTO moon
    (moon_name, planet_orbited)
VALUES
    ('The Moon', 'Earth'),
    ('Phobos', 'Mars'),
    ('Deimos', 'Mars');

-- for each planet:
    -- its name, the star it revolves around,
    -- and the numbers of moons (if any) it has
SELECT planet_name, star_orbited, count(moon_name) AS num_moons
FROM planet AS p
    JOIN star AS s
        ON p.star_orbited = s.star_name
    LEFT JOIN moon AS m
        ON m.planet_orbited = p.planet_name
GROUP BY planet_name
ORDER BY planet_name;
