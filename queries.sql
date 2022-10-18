/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name like '%mon';

--List the name of all animals born between 2016 and 2019.
SELECT * FROM animals WHERE extract(YEAR FROM date_of_birth) BETWEEN '2016' AND '2019';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT * FROM animals WHERE neutered=true AND escape_attempts>3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth from animals WHERE name='Agumon' OR name='Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered=true;

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name<>'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


-- ------------DAY 2 --------------
/*
Inside a transaction:
Update the animals table by setting the species column to unspecified. Verify that change was made.
Then roll back the change and verify that the species columns went back to the state before the transaction.
*/

BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;


/*
Inside a transaction:
Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
Commit the transaction.
Verify that change was made and persists after commit.
*/

BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
SELECT * FROM animals;
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;


/*
Inside a transaction:
Delete all records in the animals table, then roll back the transaction.
After the rollback verify if all records in the animals table still exists.
*/
BEGIN TRANSACTION;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/*
Inside a transaction:
Delete all animals born after Jan 1st, 2022.
Create a savepoint for the transaction.
Update all animals' weight to be their weight multiplied by -1.
Rollback to the savepoint
Update all animals' weights that are negative to be their weight multiplied by -1.
Commit transaction
*/

BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SELECT * FROM animals;
SAVEPOINT delete_20220101_dob;
UPDATE animals SET weight_kg=weight_kg*-1;
SELECT * FROM animals;
ROLLBACK TO delete_20220101_dob;
UPDATE animals SET weight_kg=weight_kg*-1 where weight_kg<0;
SELECT * FROM animals;
COMMIT;


-- How many animals are there?
SELECT COUNT(*) AS TOTAL_ANIMALS FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) AS ZERO_ESCAPE_ATTEMPTS FROM animals WHERE escape_attempts=0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) AS AVG_WEIGHT FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) AS MOST_ESCAPE_ATTEMPTS_GROUP_BY_NEUTERED FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS MIN_WEIGHT, MAX(weight_kg) AS MAX_WEIGHT FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS AVG_ESCAPE_ATTEMPTS FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species ;


/* Write queries (using JOIN) to answer the following questions:
   What animals belong to Melody Pond?*/
SELECT name FROM animals INNER JOIN owners ON animals.owner_id=owners.id WHERE owner.full_name='Melody Pond';

/* List of all animals that are pokemon (their type is Pokemon).*/
SELECT * FROM animals LEFT JOIN species ON animal.species_id=species.id WHERE species.name='Pokemon';

/* List all owners and their animals, remember to include those that don't own any animal.*/
SELECT * FROM owners LEFT JOIN animals ON owners.id=animals.owner_id;

/* How many animals are there per species?*/
SELECT COUNT(a.species_id) AS COUNT_SPECIES, s.name FROM animals a JOIN species s ON a.species_id=s.id GROUP BY s.name, a.species_id;

/* List all Digimon owned by Jennifer Orwell.*/
SELECT * FROM animals a JOIN owners o ON a.owner_id=o.id JOIN species s ON a.species_id=s.id WHERE o.full_name='Jennifer Orwell' AND s.name='Digimon';

/* List all animals owned by Dean Winchester that haven't tried to escape.*/
SELECT * FROM animals a JOIN owners o ON a.owner_id=o.id JOIN species s ON a.species_id=s.id WHERE o.full_name='Jennifer Orwell' AND s.name='Digimon';

/* Who owns the most animals?*/
SELECT COUNT(*) AS COUNT_OWN, o.full_name FROM animals a JOIN owners o ON o.id=a.owner_id GROUP BY o.full_name ORDER BY COUNT_OWN DESC LIMIT 1;

-- Who was the last animal seen by William Tatcher?
SELECT a.name FROM visits v
JOIN animals a ON a.id=v.animal_id
JOIN vets ve ON v.vets_id=ve.id
WHERE ve.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT(a.name)) FROM visits v
JOIN animals a ON a.id=v.animal_id
JOIN vets ve ON v.vets_id=ve.id
WHERE ve.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT a.name, v.name FROM species a
RIGHT JOIN specializations s ON s.species_id=a.id
RIGHT JOIN vets v ON s.vets_id=v.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.* FROM animals a
JOIN visits v ON v.animal_id=a.id
JOIN vets ve ON v.vets_id=ve.id
WHERE v.visit_date BETWEEN '2020-04-01' AND '2020-08-30'
AND ve.name='Stephanie Mendez';

-- What animal has the most visits to vets?
SELECT COUNT(a.name), a.name FROM animals a
JOIN visits v ON a.id=v.animal_id
JOIN vets ve ON v.vets_id=ve.id
GROUP BY a.name
ORDER BY COUNT(a.name) DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT v.visit_date, a.name, ve.name FROM visits v
JOIN animals a ON a.id=v.animal_id
JOIN vets ve ON v.vets_id=ve.id
WHERE ve.name = 'Maisy Smith'
ORDER BY v.visit_date
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.*, ve.*, v.visit_date FROM animals a
JOIN visits v ON v.animal_id=a.id
JOIN vets ve ON v.vets_id=ve.id
ORDER BY v.visit_date DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) FROM vets ve
LEFT JOIN visits v ON ve.id = v.animal_id
LEFT JOIN specializations s ON s.species_id = ve.id
LEFT JOIN species sp ON sp.id = s.species_id
WHERE sp.id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT COUNT(a.id), a.* FROM animals a
JOIN visits v ON a.id=v.animal_id
JOIN vets ve ON v.vets_id=ve.id
WHERE ve.name = 'Maisy Smith'
GROUP BY a.id
ORDER BY COUNT(a.id) DESC
LIMIT 1;
