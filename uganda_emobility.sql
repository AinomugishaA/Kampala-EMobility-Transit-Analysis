USE sys;
-- ====================================================================
-- PROJECT: Uganda E-Mobility Financial & Environmental Analysis
-- AUTHOR: [Your Name]
-- DESCRIPTION: Database initialization, schema design, and baseline 
--              data population for Kampala transit comparisons.
-- ====================================================================

-- Initialize database cluster
CREATE DATABASE IF NOT EXISTS uganda_emobility;
USE uganda_emobility;

-- Drop existing tables to ensure a clean deployment script
DROP TABLE IF EXISTS daily_trips_log;
DROP TABLE IF EXISTS regional_tariffs;
DROP TABLE IF EXISTS vehicle_specs;

-- Table 1: Standardized technical specs for popular vehicles in Uganda
CREATE TABLE vehicle_specs (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    model_name VARCHAR(100) NOT NULL,
    vehicle_type VARCHAR(50) NOT NULL, 
    fuel_type VARCHAR(20) NOT NULL,    
    purchase_price_ugx DECIMAL(15, 2) NOT NULL,
    efficiency_value DECIMAL(10, 4) NOT NULL, 
    battery_capacity_kwh DECIMAL(5, 2) DEFAULT 0.00
);

-- Table 2: Macroeconomic factors and grid emission constants in Uganda
CREATE TABLE regional_tariffs (
    tariff_id INT AUTO_INCREMENT PRIMARY KEY,
    petrol_price_per_liter DECIMAL(10, 2) NOT NULL,
    electricity_per_kwh DECIMAL(10, 2) NOT NULL,
    grid_emission_factor_g_co2_kwh DECIMAL(10, 2) NOT NULL 
);

-- Table 3: Transactional log tracking daily commuter mileage in Kampala
CREATE TABLE daily_trips_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    date_recorded DATE NOT NULL,
    distance_km INT NOT NULL,
    FOREIGN KEY (vehicle_id) REFERENCES vehicle_specs(vehicle_id) ON DELETE CASCADE
);

-- Populate baseline vehicle specifications (Ugandan Context)
INSERT INTO vehicle_specs (model_name, vehicle_type, fuel_type, purchase_price_ugx, efficiency_value, battery_capacity_kwh) 
VALUES
('Standard Bajaj Boxer 100cc', 'Boda Boda', 'Petrol', 5500000.00, 35.0000, 0.00),
('Spiro / Zembo Electric Bike', 'Boda Boda', 'Electric', 7000000.00, 30.0000, 4.00), 
('Toyota Fielder / Premio', 'Car', 'Petrol', 35000000.00, 12.0000, 0.00),
('Kiira Motors Kayoola E-Bus', 'Bus', 'Electric', 150000000.00, 1.2000, 200.00);

-- Populate regional tariff parameters (ERA & Kampala retail fuel baselines)
INSERT INTO regional_tariffs (petrol_price_per_liter, electricity_per_kwh, grid_emission_factor_g_co2_kwh) 
VALUES (6350.00, 756.20, 15.00); 

-- Populate initial trip records for Kampala Boda Boda models
INSERT INTO daily_trips_log (vehicle_id, date_recorded, distance_km) 
VALUES
(1, '2026-06-15', 85), (1, '2026-06-16', 78), (1, '2026-06-17', 90), (1, '2026-06-18', 82), (1, '2026-06-19', 88), 
(2, '2026-06-15', 85), (2, '2026-06-16', 78), (2, '2026-06-17', 90), (2, '2026-06-18', 82), (2, '2026-06-19', 88);

-- Verify database population
SELECT * FROM vehicle_specs;
