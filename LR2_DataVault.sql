-- Создание таблиц-хабов
CREATE TABLE hub_Платежи (
    id BIGINT PRIMARY KEY
);

CREATE TABLE hub_Продажа (
    id BIGINT PRIMARY KEY,
    номер_продажи BIGINT NOT NULL
);

CREATE TABLE hub_Продавцы (
    id BIGINT PRIMARY KEY
);

CREATE TABLE hub_Клиенты (
    id BIGINT PRIMARY KEY
);

CREATE TABLE hub_Машины (
    id BIGINT PRIMARY KEY,
    VIN VARCHAR NOT NULL
);

CREATE TABLE hub_Обслуживание (
    id BIGINT PRIMARY KEY,
    номер_обслуживания BIGINT NOT NULL
);

-- Создание таблиц-сателлитов
CREATE TABLE sat_Платежи (
    id BIGINT PRIMARY KEY,
    дата_платежа DATE NOT NULL,
    сумма_платежа DECIMAL NOT NULL,
	способ_оплаты VARCHAR(20) CHECK (способ_оплаты IN ('наличные', 'кредитная карта', 'банковский перевод')),
    hub_Платежи_id BIGINT NOT NULL REFERENCES hub_Платежи(id)
);

CREATE TABLE sat_Продажи (
    id BIGINT PRIMARY KEY,
    дата_продажи DATE NOT NULL,
    цена_продажи DECIMAL NOT NULL,
    hub_Продажа_id BIGINT NOT NULL REFERENCES hub_Продажа(id)
);

CREATE TABLE sat_Продавцы (
    id BIGINT PRIMARY KEY,
    Имя VARCHAR NOT NULL,
    Фамилия VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    Телефон VARCHAR NOT NULL,
    hub_Продавцы_id BIGINT NOT NULL REFERENCES hub_Продавцы(id)
);

CREATE TABLE sat_Клиенты (
    id BIGINT PRIMARY KEY,
    Имя VARCHAR NOT NULL,
    Фамилия VARCHAR NOT NULL,
    Телефон VARCHAR NOT NULL,
    Адрес VARCHAR,
    Дата_создания_записи DATE NOT NULL,
    hub_Клиенты_id BIGINT NOT NULL REFERENCES hub_Клиенты(id)
);

CREATE TABLE sat_Машины (
    id BIGINT PRIMARY KEY,
    Марка VARCHAR NOT NULL,
    Модель VARCHAR NOT NULL,
    год_выпуска INT NOT NULL,
    цена DECIMAL NOT NULL,
	статус VARCHAR(20) CHECK (статус IN ('новая', 'подержанная')),
    hub_Машины_id BIGINT NOT NULL REFERENCES hub_Машины(id)
);

CREATE TABLE sat_Обслуживание (
    id BIGINT PRIMARY KEY,
    дата_обслуживания DATE NOT NULL,
    выполненные_работы TEXT NOT NULL,
    стоимость DECIMAL NOT NULL,
    машина_id BIGINT NOT NULL,
    hub_Обслуживание_id BIGINT NOT NULL REFERENCES hub_Обслуживание(id)
);

-- Создание таблиц-связей
CREATE TABLE link_Платежи_в_Продажах (
    id BIGINT PRIMARY KEY,
    hub_Платежи_id BIGINT NOT NULL REFERENCES hub_Платежи(id),
    hub_Продажа_id BIGINT NOT NULL REFERENCES hub_Продажа(id)
);

CREATE TABLE link_Продажа_Клиент_Продавец_Машина (
    id BIGINT PRIMARY KEY,
    hub_Продавцы_id BIGINT NOT NULL REFERENCES hub_Продавцы(id),
    hub_Клиенты_id BIGINT NOT NULL REFERENCES hub_Клиенты(id),
    hub_Машины_id BIGINT NOT NULL REFERENCES hub_Машины(id),
    hub_Продажа_id BIGINT NOT NULL REFERENCES hub_Продажа(id)
);

CREATE TABLE link_обслуживание_Машина (
    id BIGINT PRIMARY KEY,
    hub_Машины_id BIGINT NOT NULL REFERENCES hub_Машины(id),
    hub_Обслуживание_id BIGINT NOT NULL REFERENCES hub_Обслуживание(id)
);
