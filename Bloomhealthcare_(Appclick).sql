/* =========================================
   BLOOMHEALTHCARE HEALTHCARE DATA ANALYSIS PROJECT
   ========================================= */

/* ---------- SECTION 1: DATA EXPLORATION ---------- */

-- View all patient records
SELECT * FROM `patients(1)`;

-- View all billing records
SELECT * FROM billing;

-- View all admission records
SELECT * FROM admissions;


/* ---------- SECTION 2: DATA SIZE CHECK ---------- */

-- Total number of patients
SELECT COUNT(*) FROM `patients(1)`;

-- Total number of admissions
SELECT COUNT(*) FROM admissions;


/* ---------- SECTION 3: PATIENT DEMOGRAPHICS ---------- */

-- Patient count by gender
SELECT gender, COUNT(*)
FROM `patients(1)`
GROUP BY gender;

-- Patients older than 50 years
SELECT *
FROM `patients(1)`
WHERE age > 50;

-- Patient count by state
SELECT state, COUNT(*)
FROM `patients(1)`
GROUP BY state;


/* ---------- SECTION 4: ADMISSION DETAILS ---------- */

-- Admissions diagnosed with malaria
SELECT *
FROM admissions
WHERE diagnosis = 'Malaria';

-- Total admissions by diagnosis
SELECT diagnosis, COUNT(*) AS total_admissions
FROM admissions
GROUP BY diagnosis;

-- Most common diagnoses
SELECT diagnosis, COUNT(*) AS total_cases
FROM admissions
GROUP BY diagnosis
ORDER BY total_cases DESC;


/* ---------- SECTION 5: PATIENT + ADMISSION JOIN ---------- */

-- Patient names with diagnoses
SELECT
    p.first_name,
    p.last_name,
    a.diagnosis
FROM `patients(1)` p
JOIN admissions a
ON p.patient_id = a.patient_id;


/* ---------- SECTION 6: BILLING ANALYSIS ---------- */

-- Average billing amount
SELECT AVG(amount) FROM billing;

-- Maximum billing amount
SELECT MAX(amount) FROM billing;

-- Top 5 highest bills
SELECT *
FROM billing
ORDER BY amount DESC
LIMIT 5;


/* ---------- SECTION 7: FULL DATA JOIN ---------- */

-- Patient, diagnosis, and billing amount
SELECT
    p.first_name,
    p.last_name,
    a.diagnosis,
    b.amount
FROM `patients(1)` p
JOIN admissions a ON p.patient_id = a.patient_id
JOIN billing b ON a.admission_id = b.admission_id;

-- Top 10 most expensive cases
SELECT
    p.first_name,
    p.last_name,
    a.diagnosis,
    b.amount
FROM `patients(1)` p
JOIN admissions a ON p.patient_id = a.patient_id
JOIN billing b ON a.admission_id = b.admission_id
ORDER BY b.amount DESC
LIMIT 10;


/* ---------- SECTION 8: LOCATION & AGE INSIGHTS ---------- */

-- Admissions by state
SELECT
    p.state,
    COUNT(*) AS total_admissions
FROM `patients(1)` p
JOIN admissions a
ON p.patient_id = a.patient_id
GROUP BY p.state
ORDER BY total_admissions DESC;

-- Average patient age per diagnosis
SELECT
    a.diagnosis,
    AVG(p.age) AS average_age
FROM `patients(1)` p
JOIN admissions a
ON p.patient_id = a.patient_id
GROUP BY a.diagnosis;


/* ---------- SECTION 9: COST ANALYSIS ---------- */

-- Total treatment cost by diagnosis
SELECT
    a.diagnosis,
    SUM(b.amount) AS total_cost
FROM admissions a
JOIN billing b
ON a.admission_id = b.admission_id
GROUP BY a.diagnosis
ORDER BY total_cost DESC;

-- Billing amount by insurance type
SELECT
    insurance_type,
    SUM(amount) AS total_amount
FROM billing
GROUP BY insurance_type;


/* ---------- SECTION 10: TIME ANALYSIS ---------- */

-- Monthly admission trends
SELECT
    MONTH(admission_date) AS month,
    COUNT(*) AS total_admissions
FROM admissions
GROUP BY MONTH(admission_date)
ORDER BY month;


/* ---------- SECTION 11: HOSPITAL STAY ANALYSIS ---------- */

-- Days spent in hospital per admission
SELECT
    admission_id,
    DATEDIFF(discharge_date, admission_date) AS days_in_hospital
FROM admissions;

-- Average length of stay per diagnosis
SELECT
    diagnosis,
    AVG(DATEDIFF(discharge_date, admission_date)) AS avg_days
FROM admissions
GROUP BY diagnosis;


/* ---------- SECTION 12: READMISSION ANALYSIS ---------- */

-- Patients with more than one admission
SELECT
    patient_id,
    COUNT(*) AS total_admissions
FROM admissions
GROUP BY patient_id
HAVING COUNT(*) > 1;


