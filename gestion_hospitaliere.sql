
CREATE DATABASE GestionHospitaliere;
USE GestionHospitaliere;

-- Table des services hospitaliers
CREATE TABLE Services (
    id_service INT PRIMARY KEY,
    nom_service VARCHAR(100) NOT NULL
);

-- Table des médecins
CREATE TABLE Medecins (
    id_medecin INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    specialite VARCHAR(100),
    id_service INT REFERENCES Services(id_service) ON DELETE SET NULL
);

-- Table des patients
CREATE TABLE Patients (
    id_patient INT PRIMARY KEY,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    date_naissance DATE,
    sexe CHAR(1) CHECK (sexe IN ('M', 'F')),
    adresse VARCHAR(200),
    telephone VARCHAR(20)
);

-- Table des rendez-vous
CREATE TABLE RendezVous (
    id_rdv INT PRIMARY KEY,
    id_patient INT REFERENCES Patients(id_patient) ON DELETE CASCADE,
    id_medecin INT REFERENCES Medecins(id_medecin) ON DELETE SET NULL,
    date_rdv DATETIME NOT NULL,
    statut VARCHAR(50) CHECK (statut IN ('prévu', 'effectué', 'annulé')) NOT NULL
);

-- Table des consultations
CREATE TABLE Consultations (
    id_consultation INT PRIMARY KEY,
    id_rdv INT REFERENCES RendezVous(id_rdv) ON DELETE CASCADE,
    diagnostic TEXT,
    date_consultation DATETIME
);

-- Table des prescriptions
CREATE TABLE Prescriptions (
    id_prescription INT PRIMARY KEY,
    id_consultation INT REFERENCES Consultations(id_consultation) ON DELETE CASCADE,
    medicament VARCHAR(100),
    posologie VARCHAR(100),
    duree_jours INT
);

-- Insertion des services
INSERT INTO Services VALUES
(1, 'Cardiologie'),
(2, 'Pédiatrie'),
(3, 'Chirurgie'),
(4, 'Dermatologie');

-- Insertion des médecins
INSERT INTO Medecins VALUES
(1, 'Dr. Ait Omar', 'Cardiologue', 1),
(2, 'Dr. Lahlou', 'Pédiatre', 2),
(3, 'Dr. Bennani', 'Chirurgien', 3),
(4, 'Dr. Zahraoui', 'Dermatologue', 4);

-- Insertion des patients
INSERT INTO Patients VALUES
(1, 'Hassan', 'Ali', '1990-04-15', 'M', '10 Rue Atlas', '0612345678'),
(2, 'Fatima', 'El Amrani', '1985-10-22', 'F', '12 Rue Souss', '0676543210'),
(3, 'Youssef', 'El Idrissi', '2005-07-05', 'M', '23 Rue Agadir', '0687654321'),
(4, 'Salma', 'Bennani', '2010-11-30', 'F', '15 Rue Taza', '0623456789');

-- Insertion des rendez-vous
INSERT INTO RendezVous VALUES
(1, 1, 1, '2025-05-10 10:00:00', 'effectué'),
(2, 2, 2, '2025-05-11 11:00:00', 'prévu'),
(3, 3, 2, '2025-05-12 09:30:00', 'effectué'),
(4, 4, 4, '2025-05-13 14:00:00', 'annulé');

-- Insertion des consultations
INSERT INTO Consultations VALUES
(1, 1, 'Hypertension légère', '2025-05-10 10:30:00'),
(2, 3, 'Fièvre saisonnière', '2025-05-12 09:50:00');

-- Insertion des prescriptions
INSERT INTO Prescriptions VALUES
(1, 1, 'Amlodipine', '5mg une fois/jour', 30),
(2, 2, 'Paracétamol', '500mg trois fois/jour', 5);
