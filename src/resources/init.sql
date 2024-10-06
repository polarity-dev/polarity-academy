CREATE TABLE Crypto (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(15, 2) NOT NULL,
    quantity NUMERIC(20, 2) NOT NULL
);

CREATE TABLE UserTable (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    balance NUMERIC(20, 2) NOT NULL
);

CREATE TABLE Wallet (
    id SERIAL PRIMARY KEY,
    userid INT NOT NULL,
    cryptoid INT NOT NULL,
    quantity NUMERIC(20, 2) NOT NULL,
    FOREIGN KEY (cryptoid) REFERENCES Crypto(id),
    FOREIGN KEY (userid) REFERENCES UserTable(id)
);

CREATE TABLE TransactionQueue (
    id SERIAL PRIMARY KEY,
    userid INT NOT NULL,
    cryptoid INT NOT NULL,
    price NUMERIC(15, 2) NOT NULL,
    quantity NUMERIC(20, 2) NOT NULL,
    type VARCHAR(50) NOT NULL, 
    status VARCHAR(50) NOT NULL, 
    transactionDate timestamp NOT NULL,
    FOREIGN KEY (cryptoid) REFERENCES Crypto(id),
    FOREIGN KEY (userid) REFERENCES UserTable(id)
);

CREATE TABLE TransactionHistory (
    id SERIAL PRIMARY KEY,
    userid INT NOT NULL,
    cryptoid INT NOT NULL,
    price NUMERIC(15, 2) NOT NULL,  
    quantity NUMERIC(20, 2) NOT NULL,
    type VARCHAR(50) NOT NULL, 
    status VARCHAR(50) NOT NULL, 
    transactionDate timestamp NOT NULL,
    FOREIGN KEY (cryptoid) REFERENCES Crypto(id),
    FOREIGN KEY (userid) REFERENCES UserTable(id)
);

