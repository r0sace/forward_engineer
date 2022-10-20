-- CS340 GROUP 
-- Chris DiGiacomo, Cristina Rosace

SET FOREIGN_KEY_CHECKS = 0;
SET AUTOCOMMIT = 0;


--
-- TABLE DROPS
--
DROP TABLE IF EXISTS PATIENTS;
DROP TABLE IF EXISTS DOCTORS;
DROP TABLE IF EXISTS APPOINTMENTS;
DROP TABLE IF EXISTS PRESCRIPTIONS;
DROP TABLE IF EXISTS MEDICATIONS;
DROP TABLE IF EXISTS Appts_has_Scripts;


--
-- TABLE STRUCTURE INITIALIZATIONS
--
CREATE OR REPLACE TABLE Patients (
    patient_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    address VARCHAR(145) NOT NULL,
    email VARCHAR(245) NOT NULL,
    phone_number INT(10) NOT NULL,
    insurance VARCHAR(145) NOT NULL,
    PRIMARY KEY (patient_id)
);


CREATE OR REPLACE TABLE Doctors (
    doctor_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    specialty VARCHAR(145) NOT NULL,
    PRIMARY KEY (doctor_id)
);


CREATE OR REPLACE TABLE Appointments (
    appt_id INT NOT NULL AUTO_INCREMENT,
    reason_for_appt VARCHAR(245) NOT NULL,
    date DATETIME NOT NULL,
    patient_id INT NOT NULL, 
    doctor_id INT NOT NULL,
    PRIMARY KEY (appt_id),
    CONSTRAINT fk_patient_id
        FOREIGN KEY (patient_id)
        REFERENCES Patients (patient_id)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    CONSTRAINT fk_doctor_id
        FOREIGN KEY (doctor_id)
        REFERENCES Doctors (doctor_id)
        ON DELETE CASCADE
        ON UPDATE NO ACTION
);


CREATE OR REPLACE TABLE Prescriptions (
    script_id INT NOT NULL AUTO_INCREMENT,
    medication_id INT NOT NULL,
    dosage VARCHAR(245) NOT NULL,
    refills INT NOT NULL,
    PRIMARY KEY (script_id),
    CONSTRAINT fk_medication_id
        FOREIGN KEY (medication_id)
        REFERENCES Medications (medication_id)
        ON DELETE CASCADE
        ON UPDATE NO UPDATE
);


CREATE OR REPLACE TABLE Medications (
    medication_id INT NOT NULL AUTO_INCREMENT,
    medication_name VARCHAR(45) NOT NULL,
    medication_type VARCHAR(45) NOT NULL,
    PRIMARY KEY (medication_id)
);


CREATE OR REPLACE TABLE Appts_has_Scripts (
    appt_script_id INT NOT NULL AUTO_INCREMENT,
    appt_id INT NOT NULL,
    script_id INT NOT NULL,
    PRIMARY KEY (appts_script_id),
    CONSTRAINT fk_appt_id
        FOREIGN KEY (appt_id)
        REFERENCES Appointments (appt_id)
        ON DELETE CASCADE
        ON UPDATE NO UPDATE,
    CONSTRAINT fk_script_id
        FOREIGN KEY (script_id)
        REFERENCES Prescriptions (script_id)
        ON DELETE CASCADE
        ON UPDATE NO UPDATE
);

