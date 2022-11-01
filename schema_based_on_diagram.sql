CREATE TABLE patients(
   id INT GENERATED ALWAYS AS IDENTITY,
   name VARCHAR(50),
   date_of_birth DATE,
   PRIMARY KEY(id));

CREATE TABLE invoices(
   id INT GENERATED ALWAYS AS IDENTITY,
   total_amount DECIMAL,
   generated_at TIMESTAMP,
   payed_at TIMESTAMP,
   medical_history_id INT,
   PRIMARY KEY(id));

CREATE TABLE medical_histories(
   id SERIAL PRIMARY KEY,
   admitted_at TIMESTAMP,
   patient_id INT REFERENCES patients(id),
   status VARCHAR(50));

CREATE TABLE treatments (
   id SERIAL PRIMARY KEY,
   type VARCHAR(50),
   name VARCHAR(50),
)

CREATE TABLE invoice_items (
   id SERIAL PRIMARY KEY,
   unit_price DECIMAL,
   quantity INT,
   total_price DECIMAL,
   invoice_id INT REFERENCES invoices(id),
   treatment_id INT REFERENCES treatments(id),
);

CREATE TABLE medical_histories_and_treatments (
   medical_history_id INT REFERENCES medical_histories(id),
   treatment_id INT REFERENCES treatments(id),
);

CREATE INDEX medical_histories_idx ON medical_histories(patient_id);
CREATE INDEX invoice_id_idx ON invoice_items(invoice_id);
CREATE INDEX treatment_id_idx ON invoice_items(treatment_id);
