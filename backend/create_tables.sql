-- Create Users table
CREATE TABLE Users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Bets table
CREATE TABLE Bets (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES Users(id),
    betfair_id VARCHAR(255) NOT NULL,
    event_id INTEGER REFERENCES Events(id),
    selection_id INTEGER REFERENCES Selections(id),
    stake DECIMAL(10, 2) NOT NULL,
    odds DECIMAL(8, 2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Events table
CREATE TABLE Events (
    id SERIAL PRIMARY KEY,
    betfair_id VARCHAR(255) NOT NULL,
    sport_id INTEGER REFERENCES Sports(id),
    competition_id INTEGER REFERENCES Competitions(id),
    name VARCHAR(255) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    country_id INTEGER REFERENCES Countries(id),
    venue_id INTEGER REFERENCES Venues(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Selections table
CREATE TABLE Selections (
    id SERIAL PRIMARY KEY,
    event_id INTEGER REFERENCES Events(id),
    name VARCHAR(255) NOT NULL,
    odds DECIMAL(8, 2) NOT NULL,
    type VARCHAR(20) NOT NULL,
    team_id INTEGER REFERENCES Teams(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create API_Connections table
CREATE TABLE API_Connections (
    id SERIAL PRIMARY KEY,
    status VARCHAR(20) NOT NULL,
    last_attempt TIMESTAMP,
    last_success TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Criteria table
CREATE TABLE Criteria (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Criteria_Weights table
CREATE TABLE Criteria_Weights (
    id SERIAL PRIMARY KEY,
    criterion_id INTEGER REFERENCES Criteria(id),
    weight DECIMAL(5, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Animals table
CREATE TABLE Animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Animal_Criteria_Scores table
CREATE TABLE Animal_Criteria_Scores (
    id SERIAL PRIMARY KEY,
    animal_id INTEGER REFERENCES Animals(id),
    criterion_id INTEGER REFERENCES Criteria(id),
    score DECIMAL(5, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Sports table
CREATE TABLE Sports (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Competitions table
CREATE TABLE Competitions (
    id SERIAL PRIMARY KEY,
    sport_id INTEGER REFERENCES Sports(id),
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Teams table
CREATE TABLE Teams (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Team_Competitions table
CREATE TABLE Team_Competitions (
    team_id INTEGER REFERENCES Teams(id),
    competition_id INTEGER REFERENCES Competitions(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (team_id, competition_id)
);

-- Create Countries table
CREATE TABLE Countries (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Venues table
CREATE TABLE Venues (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country_id INTEGER REFERENCES Countries(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Event_Details table
CREATE TABLE Event_Details (
    id SERIAL PRIMARY KEY,
    event_id INTEGER REFERENCES Events(id),
    detail_type VARCHAR(50) NOT NULL,
    value TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);