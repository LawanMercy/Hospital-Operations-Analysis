------CREATING ALL THE 7 TABLES ----------------



CREATE TABLE factpatientvisits (
    visitid INT,
    visitdate TEXT,
    doctorkey INT,
    departmentkey INT,
    diagnosiskey INT,
    insurancekey INT,
    hospitalkey INT,
    patienttypekey INT,
    treatmentcost TEXT,
    medicationcost TEXT,
    lengthofstay INT,
    waittimeminutes INT,
    satisfactionscore INT,
    readmitted30days TEXT,
    emergencyvisit TEXT,
    labtestscount INT,
    procedurecount INT
);

CREATE TABLE dimdoctor (
    doctorkey INT,
    doctorname TEXT,
    gender TEXT,
    specialty TEXT,
    yearsexperience TEXT
);

CREATE TABLE dimdepartment (
    departmentkey INT,
    departmentname TEXT
);

CREATE TABLE dimdiagnosis (
    diagnosiskey INT,
    diagnosis TEXT
);

CREATE TABLE dimhospital (
    hospitalkey INT,
    hospitalname TEXT,
    city TEXT,
    hospitaltype TEXT,
    bedcapacity INT
);

CREATE TABLE diminsurance (
    insurancekey INT,
    insuranceprovider TEXT
);

CREATE TABLE dimpatienttype (
    patienttypekey INT,
    patienttype TEXT
);



------VIEWING SOME OF THE TABLES---

SELECT * FROM factpatientvisits;

SELECT COUNT (*) FROM factpatientvisits;