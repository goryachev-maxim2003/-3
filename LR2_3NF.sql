-- Создание таблицы (Клиенты)
CREATE TABLE Customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Создание таблицы Cars (Автомобили)
CREATE TABLE Cars (
    id SERIAL PRIMARY KEY,
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    year INT ,
    price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('в наличии', 'продан', 'в резерве'))
);

-- Создание таблицы Salespersons (Продавцы)
CREATE TABLE Salespersons (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    hire_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Создание таблицы Sales (Продажи)
CREATE TABLE Sales (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES Customers(id),
    car_id INT REFERENCES Cars(id) ON DELETE CASCADE,
    salesperson_id INT REFERENCES Salespersons(id) ON DELETE SET NULL,
    sale_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    sale_price DECIMAL(10, 2) NOT NULL
);

-- Создание таблицы Payments (Платежи)
CREATE TABLE Payments (
    id SERIAL PRIMARY KEY,
    sale_id INT REFERENCES Sales(id),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(20) CHECK (payment_method IN ('наличные', 'кредитная карта', 'банковский перевод'))
);

-- Создание таблицы Maintenance (Обслуживание)
CREATE TABLE Maintenance (
    maintenance_id SERIAL PRIMARY KEY,
    car_id INT REFERENCES Cars(id),
    maintenance_date TIMESTAMP NOT NULL,
    description TEXT NOT NULL,
    cost DECIMAL(10, 2) NOT NULL
);