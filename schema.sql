CREATE TABLE area(
	postal_code INTEGER PRIMARY KEY,
  state VARCHAR,
  municipality VARCHAR
);

CREATE TYPE genders AS ENUM('m', 'f', 'o');

CREATE TABLE client(
	curp VARCHAR PRIMARY KEY,
  rfc VARCHAR UNIQUE,
  name VARCHAR,
  gender genders,
  date_of_birth DATE,
  phone VARCHAR UNIQUE,
  email VARCHAR UNIQUE,
  address VARCHAR,
  neighborhood VARCHAR,
  postal_code INTEGER
);

ALTER TABLE client
ADD CONSTRAINT  fk_client_area
FOREIGN KEY (postal_code)
REFERENCES area(postal_code);

CREATE TABLE branch(
  id INTEGER PRIMARY KEY,
  name VARCHAR,
  address VARCHAR,
  neighborhood VARCHAR,
  postal_code INTEGER REFERENCES area(postal_code),
  swift_code VARCHAR UNIQUE
 
);

CREATE TABLE employee(
	id INTEGER PRIMARY KEY,
  curp VARCHAR UNIQUE,
  rfc VARCHAR UNIQUE,
  name VARCHAR,
  phone VARCHAR,
  email VARCHAR UNIQUE,
  date_of_birth DATE,
  joining_date DATE,
  gender GENDERS,
  branch_id INTEGER REFERENCES branch(id),
  address VARCHAR,
  neighborhood VARCHAR,
  postal_code INTEGER REFERENCES area(postal_code),
  salary DECIMAL
);


CREATE TYPE account_types AS ENUM('SAVINGS', 'CHECKING', 'INVESTMENT');

CREATE TABLE account_type(
  type ACCOUNT_TYPES PRIMARY KEY,
  annual_interest_rate DECIMAL,
  maintenance_charges DECIMAL

);

CREATE TYPE account_states AS ENUM('ACTIVE', 'CLOSED', 'FROZEN');

CREATE TABLE account(
	clabe VARCHAR PRIMARY KEY,
  account_type ACCOUNT_TYPES REFERENCES account_type(type),
  branch_id INTEGER REFERENCES branch(id),
  balance DECIMAL,
  opening_date DATE,
  account_state ACCOUNT_STATES
);

CREATE TABLE accounts_clients(
	curp VARCHAR REFERENCES client(curp),
  clabe VARCHAR REFERENCES account(clabe),
  PRIMARY KEY(curp, clabe)
);

CREATE TYPE transaction_types AS ENUM('DEPOSIT', 'WITHDRAWAL', 'TRANSFER', 'PAYMENT', 'LOAN', 'INTEREST', 'FD_OPENING', 'FD_MATURITY');
CREATE TYPE transaction_states AS ENUM('SUCCESSFUL', 'FAILED', 'PENDING');

CREATE TABLE transaction(
	id UUID PRIMARY KEY,
  amount DECIMAL,
  origin_clabe VARCHAR REFERENCES account(clabe),
  destination_clabe VARCHAR REFERENCES account(clabe),
  transaction_type TRANSACTION_TYPES,
  transaction_state TRANSACTION_STATES,
  date_time timestamp
);

CREATE TABLE account_interest(
  id INTEGER PRIMARY KEY,
  clabe VARCHAR REFERENCES account(clabe),
  previous_balance DECIMAL,
  annual_interest_rate DECIMAL,
  interest_amount DECIMAL,
  transaction_id UUID REFERENCES transaction(id) UNIQUE
  
);

CREATE TYPE loan_types AS ENUM('PERSONAL', 'CAR', 'MORTGAGE', 'STUDENT');

CREATE TABLE loan_type(
  type LOAN_TYPES PRIMARY KEY,
  annual_interest_rate DECIMAL,
  advance_payment_charge DECIMAL
  
);

CREATE TYPE loan_status AS ENUM('ACTIVE', 'LIQUIDATED', 'DEFAULTER');

CREATE TABLE loan(
	id INTEGER PRIMARY KEY,
  clabe VARCHAR REFERENCES account(clabe),
  borrowed_amount DECIMAL,
  type LOAN_TYPES REFERENCES loan_type(type),
  annual_interest_rate DECIMAL,
  term_years INTEGER,
  monthly_payment DECIMAL,
  outstanding_debt DECIMAL,
  start_date TIMESTAMP,
  status LOAN_STATUS,
  disbursement_transaction UUID REFERENCES transaction(id) UNIQUE
);

CREATE TABLE loan_payment(
  id INTEGER PRIMARY KEY,
  transaction_id UUID REFERENCES transaction(id) UNIQUE,
  loan_id INTEGER REFERENCES loan(id),
  monthly_payment DECIMAL,
  date_time TIMESTAMP
  
);

CREATE TYPE fixed_deposit_status AS ENUM('ACTIVE', 'PAID', 'CANCELED');

CREATE TABLE fixed_deposit(
	id INTEGER PRIMARY KEY,
  clabe VARCHAR REFERENCES account(clabe),
  amount DECIMAL,
  annual_interest_rate DECIMAL,
  term_years INTEGER,
  opening_date_time TIMESTAMP,
  maturity_date_time TIMESTAMP,
  status FIXED_DEPOSIT_STATUS,
  transaction_id UUID REFERENCES transaction(id) UNIQUE
);

CREATE TABLE fd_interest(
  id INTEGER PRIMARY KEY,
  fd_id INTEGER REFERENCES fixed_deposit(id) UNIQUE,
  fixed_deposit_amount DECIMAL,
  interest_amount DECIMAL,
  transaction_id UUID REFERENCES  transaction(id) UNIQUE
);


