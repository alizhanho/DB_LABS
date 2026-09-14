-- INTERNATIONAL AIRPORT DATABASE
-- Laboratory Work 1

-- 1. AIRPORT TABLE
CREATE TABLE airport (
    airport_id SERIAL PRIMARY KEY,
    airport_name VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    city VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- 2. AIRLINE TABLE
CREATE TABLE airline (
    airline_id SERIAL PRIMARY KEY,
    airline_code VARCHAR(10) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- 3. FLIGHT TABLE
CREATE TABLE flight (
    flight_id SERIAL PRIMARY KEY,
    airline_id INT NOT NULL,
    departure_airport_id INT NOT NULL,
    arrival_airport_id INT NOT NULL,
    departing_gate VARCHAR(10),
    arriving_gate VARCHAR(10),
    scheduled_departure_time TIMESTAMP NOT NULL,
    scheduled_arrival_time TIMESTAMP NOT NULL,
    actual_departure_time TIMESTAMP,
    actual_arrival_time TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_flight_airline
        FOREIGN KEY (airline_id)
        REFERENCES airline(airline_id),

    CONSTRAINT fk_departure_airport
        FOREIGN KEY (departure_airport_id)
        REFERENCES airport(airport_id),

    CONSTRAINT fk_arrival_airport
        FOREIGN KEY (arrival_airport_id)
        REFERENCES airport(airport_id)
);


-- 4. PASSENGER TABLE
CREATE TABLE passenger (
    passenger_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    gender VARCHAR(20) NOT NULL,
    date_of_birth DATE NOT NULL,
    country_of_citizenship VARCHAR(100) NOT NULL,
    country_of_residence VARCHAR(100) NOT NULL,
    passport_number VARCHAR(50) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- 5. BOOKING TABLE
CREATE TABLE booking (
    booking_id SERIAL PRIMARY KEY,
    flight_id INT NOT NULL,
    passenger_id INT NOT NULL,
    status VARCHAR(30) NOT NULL,
    booking_platform VARCHAR(50) NOT NULL,
    ticket_price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_booking_flight
        FOREIGN KEY (flight_id)
        REFERENCES flight(flight_id),

    CONSTRAINT fk_booking_passenger
        FOREIGN KEY (passenger_id)
        REFERENCES passenger(passenger_id)
);


-- 6. BOARDING PASS TABLE
CREATE TABLE boarding_pass (
    boarding_pass_id SERIAL PRIMARY KEY,
    booking_id INT UNIQUE NOT NULL,
    seat VARCHAR(10) NOT NULL,
    boarding_time TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_boarding_booking
        FOREIGN KEY (booking_id)
        REFERENCES booking(booking_id)
);


-- 7. BAGGAGE TABLE
CREATE TABLE baggage (
    baggage_id SERIAL PRIMARY KEY,
    booking_id INT NOT NULL,
    weight_kg DECIMAL(5,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_baggage_booking
        FOREIGN KEY (booking_id)
        REFERENCES booking(booking_id)
);


-- 8. BAGGAGE CHECK TABLE
CREATE TABLE baggage_check (
    baggage_check_id SERIAL PRIMARY KEY,
    booking_id INT NOT NULL,
    passenger_id INT NOT NULL,
    check_result VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_baggage_check_booking
        FOREIGN KEY (booking_id)
        REFERENCES booking(booking_id),

    CONSTRAINT fk_baggage_check_passenger
        FOREIGN KEY (passenger_id)
        REFERENCES passenger(passenger_id)
);


-- 9. SECURITY CHECK TABLE
CREATE TABLE security_check (
    security_check_id SERIAL PRIMARY KEY,
    passenger_id INT NOT NULL,
    check_result VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_security_passenger
        FOREIGN KEY (passenger_id)
        REFERENCES passenger(passenger_id)
);


-- 10. BOOKING CHANGE TABLE
CREATE TABLE booking_change (
    booking_change_id SERIAL PRIMARY KEY,
    booking_id INT NOT NULL,
    change_description TEXT NOT NULL,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_booking_change
        FOREIGN KEY (booking_id)
        REFERENCES booking(booking_id)
);