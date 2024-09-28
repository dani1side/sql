DROP TABLE IF EXISTS countries;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS ofert_courses;
DROP TABLE IF EXISTS registration_courses;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS teachers;


-- Crear la tabla countries
CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(255)
);



-- Crear la tabla courses
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(255),
    duration NUMERIC (5),
    type VARCHAR(20),
    modality VARCHAR(20)
);

ALTER TABLE courses
ADD CONSTRAINT unique_course_name UNIQUE (course_name);
ALTER TABLE courses
ALTER COLUMN course_name SET NOT NULL;


-- Crear la tabla ofert_courses
CREATE TABLE ofert_courses (
    ofert_course_id SERIAL PRIMARY KEY,
    ofert_course_name VARCHAR(30),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id),
    price numeric(10,2)
);

ALTER TABLE ofert_courses
ADD CONSTRAINT ofert_course_name UNIQUE (ofert_courses_name);

ALTER TABLE ofert_courses
ALTER COLUMN ofert_course_name SET NOT NULL;


-- Crear la tabla registration_courses
CREATE TABLE registration_courses (
    registration_id SERIAL PRIMARY KEY,
    FOREIGN KEY (ofert_courses_id) REFERENCES ofert_courses(ofert_courses_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    discount numeric(5, 2)
  );


-- Crear la tabla students
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(255),
    surname VARCHAR(255),
    email VARCHAR(255),
    phone1 VARCHAR(20),
    phone2 VARCHAR(20),
    nif VARCHAR(15),
    direction VARCHAR(255),
    location VARCHAR(255),
    city VARCHAR(255),
    postalcode VARCHAR(25),
    FOREIGN KEY (country_id) REFERENCES countries(country_id),
    marketing BOOLEAN,
    offert_work BOOLEAN
);


ALTER TABLE students
ADD CONSTRAINT unique_nif UNIQUE (nif);

ALTER TABLE students
ALTER COLUMN nif SET NOT NULL;


-- Crear la tabla teachers
CREATE TABLE teachers (
    teacher_id SERIAL PRIMARY KEY,
    teacher_name VARCHAR(255),
    surname VARCHAR(255),
    email VARCHAR(255),
    phone1 VARCHAR(20),
    phone2 VARCHAR(20),
    nif VARCHAR(15),
    direction VARCHAR(255),
    location VARCHAR(255),
    city VARCHAR(255),
    postalcode VARCHAR(25),
    FOREIGN KEY (country_id) REFERENCES countries(country_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

ALTER TABLE teachers
ADD CONSTRAINT unique_nif UNIQUE (nif);

ALTER TABLE teachers
ALTER COLUMN nif SET NOT NULL;

__________

DROP TABLE IF EXISTS registration_courses;
DROP TABLE IF EXISTS ofert_courses;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS teachers;
DROP TABLE IF EXISTS countries;

-- Crear la tabla countries
CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(255)
);

-- Crear la tabla students
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(255),
    surname VARCHAR(255),
    email VARCHAR(255),
    phone1 VARCHAR(20),
    phone2 VARCHAR(20),
    nif VARCHAR(15),
    direction VARCHAR(255),
    location VARCHAR(255),
    city VARCHAR(255),
    postalcode VARCHAR(25),
    country_id INT REFERENCES countries(country_id),
    marketing BOOLEAN,
    offert_work BOOLEAN
);

ALTER TABLE students
ADD CONSTRAINT unique_nif UNIQUE (nif);
ALTER TABLE students
ALTER COLUMN nif SET NOT NULL;

-- Crear la tabla teachers
CREATE TABLE teachers (
    teacher_id SERIAL PRIMARY KEY,
    teacher_name VARCHAR(255),
    surname VARCHAR(255),
    email VARCHAR(255),
    phone1 VARCHAR(20),
    phone2 VARCHAR(20),
    nif VARCHAR(15),
    direction VARCHAR(255),
    location VARCHAR(255),
    city VARCHAR(255),
    postalcode VARCHAR(25),
    country_id INT REFERENCES countries(country_id)
);

ALTER TABLE teachers
ADD CONSTRAINT unique_nif_teachers UNIQUE (nif);
ALTER TABLE teachers
ALTER COLUMN nif SET NOT NULL;

-- Crear la tabla courses
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(255),
    duration NUMERIC(5),
    type VARCHAR(20),
    modality VARCHAR(20)
);

ALTER TABLE courses
ADD CONSTRAINT unique_course_name UNIQUE (course_name);
ALTER TABLE courses
ALTER COLUMN course_name SET NOT NULL;

-- Crear la tabla ofert_courses
CREATE TABLE ofert_courses (
    ofert_course_id SERIAL PRIMARY KEY,
    course_id INT REFERENCES courses(course_id),
    ofert_course_name VARCHAR(30),
    start_date DATE,
    end_date DATE,
    teacher_id INT REFERENCES teachers(teacher_id),
    price NUMERIC(10,2)
);

ALTER TABLE ofert_courses
ADD CONSTRAINT ofert_course_name_unique UNIQUE (ofert_course_name);
ALTER TABLE ofert_courses
ALTER COLUMN ofert_course_name SET NOT NULL;

-- Crear la tabla registration_courses
CREATE TABLE registration_courses (
    registration_id SERIAL PRIMARY KEY,
    ofert_course_id INT REFERENCES ofert_courses(ofert_course_id),
    student_id INT REFERENCES students(student_id),
    discount NUMERIC(5, 2)
);



-- Insertar datos en la tabla countries
INSERT INTO countries (country_name)
VALUES
('Spain'),
('United States'),
('Germany');

-- Insertar datos en la tabla students
INSERT INTO students (student_name, surname, email, phone1, phone2, nif, direction, location, city, postalcode, country_id, marketing, offert_work)
VALUES
('Juan', 'García', 'juan.garcia@example.com', '600123456', '910123456', '12345678A', 'Calle Mayor 1', 'Centro', 'Madrid', '28001', 1, TRUE, FALSE),
('Ana', 'Martínez', 'ana.martinez@example.com', '600987654', '910987654', '87654321B', 'Calle Sol 2', 'Barrio Sur', 'Barcelona', '08001', 1, FALSE, TRUE);

-- Insertar datos en la tabla teachers
INSERT INTO teachers (teacher_name, surname, email, phone1, phone2, nif, direction, location, city, postalcode, country_id)
VALUES
('Laura', 'Sánchez', 'laura.sanchez@example.com', '600111222', '910111222', '22223333C', 'Calle Luna 3', 'Centro', 'Sevilla', '41001', 1),
('John', 'Doe', 'john.doe@example.com', '600333444', '910333444', '33334444D', 'Main St 5', 'Downtown', 'New York', '10001', 2);

-- Insertar datos en la tabla courses
INSERT INTO courses (course_name, duration, type, modality)
VALUES
('Data Science', 120, 'Technical', 'Online'),
('Machine Learning', 80, 'Technical', 'Onsite'),
('Business Intelligence', 60, 'Business', 'Online');

-- Insertar datos en la tabla ofert_courses
INSERT INTO ofert_courses (course_id, ofert_course_name, start_date, end_date, teacher_id, price)
VALUES
(1, 'Data Science for Beginners', '2024-10-01', '2024-12-31', 1, 1500.00),
(2, 'Advanced Machine Learning', '2024-11-01', '2024-12-15', 2, 2000.00);

-- Insertar datos en la tabla registration_courses
INSERT INTO registration_courses (ofert_course_id, student_id, discount)
VALUES
(1, 1, 10.00),
(2, 2, 5.00);



-- Consulta alumno
SELECT
    s.student_name,
    s.surname,
    oc.ofert_course_name,
    c.course_name,
    oc.start_date,
    oc.end_date,
    oc.price,
    rc.discount
FROM
    students s
JOIN
    registration_courses rc ON s.student_id = rc.student_id
JOIN
    ofert_courses oc ON rc.ofert_course_id = oc.ofert_course_id
JOIN
    courses c ON oc.course_id = c.course_id
WHERE
    s.student_id = 1;


-- Consulta profesor
    SELECT
        t.teacher_name,
        t.surname,
        oc.ofert_course_name,
        c.course_name,
        oc.start_date,
        oc.end_date,
        oc.price
    FROM
        teachers t
    JOIN
        ofert_courses oc ON t.teacher_id = oc.teacher_id
    JOIN
        courses c ON oc.course_id = c.course_id
    WHERE
        t.teacher_id = 1;
