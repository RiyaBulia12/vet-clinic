/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY(id)
);

-- Add a column species of type string to your animals table. Modify your schema.sql file.

ALTER TABLE animals
ADD species VARCHAR(50);


/*Create a table named owners with the following columns:
id: integer (set it as autoincremented PRIMARY KEY)
full_name: string
age: integer
*/
CREATE TABLE owners(id INT GENERATED ALWAYS AS IDENTITY, full_name VARCHAR(50), age INT, PRIMARY KEY(id));

/*
Create a table named species with the following columns:
id: integer (set it as autoincremented PRIMARY KEY)
name: string
*/
CREATE TABLE species(id INT GENERATED ALWAYS AS IDENTITY, name VARCHAR(50), PRIMARY KEY(id));

/*
Modify animals table:
Make sure that id is set as autoincremented PRIMARY KEY
Remove column species
Add column species_id which is a foreign key referencing species table
Add column owner_id which is a foreign key referencing the owners table
*/
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species (id);
ALTER TABLE animals ADD COLUMN owner_id INT REFERENCES owners (id);
