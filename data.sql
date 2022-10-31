/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon' ,'2020-02-03', 0, true, 10.23);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Gabumon', '2018-11-15', 2, true, 8);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Pikachu', '2021-01-07', 1, false, 15.04);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Devimon', '2017-05-12', 5, true, 11);

/* Animal: His name is Charmander. He was born on Feb 8th, 2020, and currently weighs -11kg. He is not neutered f and he has never tried to 0 escape.
Animal: Her name is Plantmon. She was born on Nov 15th, 2021, and currently weighs -5.7kg. She is neutered t and she has tried to escape 2 times.
Animal: His name is Squirtle. He was born on Apr 2nd, 1993, and currently weighs -12.13kg. He was not neutered f and he has tried to escape 3 times.
Animal: His name is Angemon. He was born on Jun 12th, 2005, and currently weighs -45kg. He is neutered t and he has tried to escape 1 once.
Animal: His name is Boarmon. He was born on Jun 7th, 2005, and currently weighs 20.4kg. He is neutered t and he has tried to escape 7 times.
Animal: Her name is Blossom. She was born on Oct 13th, 1998, and currently weighs 17kg. She is neutered t and she has tried to escape 3 times.
Animal: His name is Ditto. He was born on May 14th, 2022, and currently weighs 22kg. He is neutered t and he has tried to escape 4 times. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('Charmander' ,'2020-02-08', 0, false, -11),
('Plantmon' ,'2021-11-15', 2, true, -5.7),
('Squirtle' ,'1993-04-02', 3, false, -12.13),
('Angemon' ,'2005-06-12', 1, true, -45),
('Boarmon' ,'2005-06-07', 7, true, 20.4),
('Blossom' ,'1998-10-13', 3, true, 17),
('Ditto' ,'2022-05-14', 4, true, 22);


/*Insert the following data into the owners table:
Sam Smith 34 years old.
Jennifer Orwell 19 years old.
Bob OW 45 years old.
Melody Pond 77 years old.
Dean Winchester 14 years old.
Jodie Whittaker 38 years old.
*/
INSERT INTO owners (full_name, age) VALUES
   ('Sam Smith', 34),
   ('Jennifer Orwell', 19),
   ('Bob', 45),
   ('Melody Pond', 77),
   ('Dean Winchester', 14),
   ('Jodie Whittaker', 38);

/*
Insert the following data into the species table:
Pokemon
Digimon
*/
INSERT INTO species (name) VALUES
   ('Pokemon'),
   ('Digimon');

/*
Modify your inserted animals so it includes the species_id value:
If the name ends in "mon" it will be Digimon
All other animals are Pokemon
*/
UPDATE animals
SET species_id=2
WHERE name LIKE '%mon';

UPDATE animals
SET species_id=1
WHERE species_id IS NULL;

/*
Modify your inserted animals to include owner information (owner_id):
Sam Smith owns Agumon.
Jennifer Orwell owns Gabumon and Pikachu.
Bob owns Devimon and Plantmon.
Melody Pond owns Charmander, Squirtle, and Blossom.
Dean Winchester owns Angemon and Boarmon.
*/
UPDATE animals
SET owner_id=1
WHERE name='Agumon';

UPDATE animals
SET owner_id=2
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id=3
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id=4
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id=5
WHERE name IN ('Angemon', 'Boarmon');

/*
Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.
*/
INSERT INTO vets(name, age, date_of_graduation) VALUES
('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');


/*
Vet William Tatcher is specialized in Pokemon.
Vet Stephanie Mendez is specialized in Digimon and Pokemon.
Vet Jack Harkness is specialized in Digimon.
*/
INSERT INTO specializations(vets_id, species_id) VALUES (
((SELECT id from vets where name = 'William Tatcher'),(SELECT id from species where name = 'Pokemon')),
((SELECT id from vets where name = 'Stephanie Mendez'),(SELECT id from species where name = 'Digimon')),
((SELECT id from vets where name = 'Stephanie Mendez'),(SELECT id from species where name = 'Pokemon')),
((SELECT id from vets where name = 'Jack Harkness'),(SELECT id from species where name = 'Digimon')));

/*
Agumon visited William Tatcher on May 24th, 2020.
Agumon visited Stephanie Mendez on Jul 22th, 2020.
Gabumon visited Jack Harkness on Feb 2nd, 2021.
Pikachu visited Maisy Smith on Jan 5th, 2020.
Pikachu visited Maisy Smith on Mar 8th, 2020.
Pikachu visited Maisy Smith on May 14th, 2020.
Devimon visited Stephanie Mendez on May 4th, 2021.
Charmander visited Jack Harkness on Feb 24th, 2021.
Plantmon visited Maisy Smith on Dec 21st, 2019.
Plantmon visited William Tatcher on Aug 10th, 2020.
Plantmon visited Maisy Smith on Apr 7th, 2021.
Squirtle visited Stephanie Mendez on Sep 29th, 2019.
Angemon visited Jack Harkness on Oct 3rd, 2020.
Angemon visited Jack Harkness on Nov 4th, 2020.
Boarmon visited Maisy Smith on Jan 24th, 2019.
Boarmon visited Maisy Smith on May 15th, 2019.
Boarmon visited Maisy Smith on Feb 27th, 2020.
Boarmon visited Maisy Smith on Aug 3rd, 2020.
Blossom visited Stephanie Mendez on May 24th, 2020.
Blossom visited William Tatcher on Jan 11th, 2021.
*/

INSERT INTO visits(animal_id, vets_id, visit_date)
VALUES
   ((SELECT id from animals where name = 'Agumon'),(SELECT id from vets where name = 'Stephanie Mendez'),'2020-07-22'),
   ((SELECT id from animals where name = 'Gabumon'),(SELECT id from vets where name = 'Jack Harkness'),'2021-02-02'),
   ((SELECT id from animals where name = 'Pikachu'),(SELECT id from vets where name = 'Maisy Smith'),'2020-01-05'),
   ((SELECT id from animals where name = 'Pikachu'),(SELECT id from vets where name = 'Maisy Smith'),'2020-03-08'),
   ((SELECT id from animals where name = 'Pikachu'),(SELECT id from vets where name = 'Maisy Smith'),'2020-05-14'),
   ((SELECT id from animals where name = 'Devimon'),(SELECT id from vets where name = 'Stephanie Mendez'),'2021-05-04'),
   ((SELECT id from animals where name = 'Charmander'),(SELECT id from vets where name = 'Jack Harkness'),'2021-02-24'),
   ((SELECT id from animals where name = 'Plantmon'),(SELECT id from vets where name = 'Maisy Smith'),'2019-12-21'),
   ((SELECT id from animals where name = 'Plantmon'),(SELECT id from vets where name = 'William Tatcher'),'2020-08-10'),
   ((SELECT id from animals where name = 'Plantmon'),(SELECT id from vets where name = 'Maisy Smith'),'2021-04-07'),
   ((SELECT id from animals where naame = 'Squirtle'),(SELECT id from vets where name = 'Stephanie Mendez'),'2019-09-29'),
   ((SELECT id from animals where name = 'Angemon'),(SELECT id from vets where name = 'Jack Harkness'),'2020-10-03'),
   ((SELECT id from animals where name = 'Angemon'),(SELECT id from vets where name = 'Jack Harkness'),'2020-11-04'),
   ((SELECT id from animals where name = 'Boarmon'),(SELECT id from vets where name = 'Maisy Smith'),'2019-01-24'),
   ((SELECT id from animals where name = 'Boarmon'),(SELECT id from vets where name = 'Maisy Smith'),'2019-05-15'),
   ((SELECT id from animals where name = 'Boarmon'),(SELECT id from vets where name = 'Maisy Smith'),'2020-02-27'),
   ((SELECT id from animals where name = 'Boarmon'),(SELECT id from vets where name = 'Maisy Smith'),'2020-08-03'),
   ((SELECT id from animals where name = 'Blossom'),(SELECT id from vets where name = 'Stephanie Mendez'),'2020-05-24'),
   ((SELECT id from animals where name = 'Blossom'),(SELECT id from vets where name = 'William Tatcher'),'2021-01-11');

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';

