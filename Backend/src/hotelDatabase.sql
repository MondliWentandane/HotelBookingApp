CREATE TYPE user_role AS ENUM ('admin', 'customer');

CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    password_hash VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    role user_role NOT NULL DEFAULT 'customer',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE Hotels (
    hotel_id SERIAL PRIMARY KEY,
    hotel_name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    price_range VARCHAR(100) NOT NULL,
    star_rating SMALLINT,
    amenities TEXT[] DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TYPE room_status AS ENUM ('available', 'unavailable', 'maintenance');

CREATE TABLE Rooms (
    room_id SERIAL PRIMARY KEY,
    hotel_id INT REFERENCES Hotels(hotel_id) ON DELETE CASCADE,
    room_type VARCHAR(100) NOT NULL,
    price_per_night NUMERIC(10,2) NOT NULL,
    availability_status room_status NOT NULL DEFAULT 'available',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TYPE booking_status AS ENUM ('pending', 'confirmed', 'cancelled', 'completed');
CREATE TYPE payment_status AS ENUM ('pending', 'paid', 'failed');

CREATE TABLE Bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(user_id) ON DELETE CASCADE,
    hotel_id INT REFERENCES Hotels(hotel_id) ON DELETE CASCADE,
    room_id INT REFERENCES Rooms(room_id) ON DELETE CASCADE,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    status booking_status NOT NULL DEFAULT 'pending',
    total_price NUMERIC(10,2) NOT NULL,
    payment_status payment_status NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE Reviews (
    review_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(user_id) ON DELETE CASCADE,
    hotel_id INT REFERENCES Hotels(hotel_id) ON DELETE CASCADE,
    rating SMALLINT CHECK (rating >= 1 AND rating <= 5),
    comment VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

