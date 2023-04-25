CREATE TABLE stars(
    star_name VARCHAR(50) PRIMARY KEY,
    temp_in_kelvin INT
);

INSERT INTO stars
    (star_name, temp_in_kelvin)
VALUES
    ('The Sun', 5800),
    ('Proxima Centauri', 3042),
    ('Gliese 876', 3192);

CREATE TABLE planets(
    planet_name VARCHAR(50) PRIMARY KEY,
    orbital_period_yrs FLOAT NOT NULL
        CHECK (orbital_period_yrs > 0),
    star_name VARCHAR(50) NOT NULL REFERENCES star
);

INSERT INTO planets
    (planet_name, orbital_period_yrs, star_name)
VALUES
    ( 'Earth', 1.00, 'The Sun'),
    ('Mars', 1.822, 'The Sun'),
    ('Venus', 0.62, 'The Sun'),
    ('Proxima Centauri b', 0.03, 'Proxima Centauri'),
    ('Gliese 876 b', 0.236, 'Gliese 876');

CREATE TABLE moons(
    moon_name VARCHAR(50) PRIMARY KEY,
    planet_name VARCHAR(50) NOT NULL REFERENCES planet
);

INSERT INTO moons
    (moon_name, planet_name)
VALUES
    ('The Moon', 'Earth'),
    ('Phobos', 'Mars'),
    ('Deimos', 'Mars');

-- for each planet:
    -- its name, the star it revolves around,
    -- and the numbers of moons (if any) it has
SELECT planet_name, star_name, count(moon_name) AS num_moons
FROM planets
    JOIN stars
        USING (star_name)
    LEFT JOIN moons
        USING (planet_name)
GROUP BY planet_name
ORDER BY planet_name;
