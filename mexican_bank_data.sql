-- 1. Insert Areas (Postal Codes)
INSERT INTO area (postal_code, state, municipality) VALUES
(11520, 'Ciudad de México', 'Miguel Hidalgo'),
(44600, 'Jalisco', 'Guadalajara'),
(83240, 'Sonora', 'Hermosillo'),
(31000, 'Chihuahua', 'Chihuahua'),
(86000, 'Tabasco', 'Villahermosa');

-- 2. Insert Account Types
INSERT INTO account_type (type, annual_interest_rate, maintenance_charges) VALUES
('SAVINGS', 1.5, 0.00),
('CHECKING', 0.5, 25.00),
('INVESTMENT', 4.0, 100.00);

-- 3. Insert Loan Types
INSERT INTO loan_type (type, annual_interest_rate, advance_payment_charge) VALUES
('PERSONAL', 12.5, 2.0),
('CAR', 8.0, 1.5),
('MORTGAGE', 6.5, 3.0);

-- 4. Insert Branches
INSERT INTO branch (id, name, address, neighborhood, postal_code, swift_code) VALUES
(101, 'Sucursal Polanco', 'Av. Presidente Masaryk 321', 'Polanco', 11520, 'BNMXMXMMPOL'),
(102, 'Sucursal Centro', 'Av. Juárez 1500', 'Centro', 44600, 'BNMXMXMMGDL'),
(103, 'Sucursal Norte', 'Blvd. Kino 123', 'Centro', 83240, 'BNMXMXMMHMO'),
(104, 'Sucursal Chihuahua', 'Calle Libertad 456', 'Centro', 31000, 'BNMXMXMMCHH'),
(105, 'Sucursal Tabasco', 'Av. Francisco Madero 789', 'Centro', 86000, 'BNMXMXMMVSA');

-- 5. Insert Employees
INSERT INTO employee (id, curp, rfc, name, phone, email, date_of_birth, joining_date, gender, branch_id, address, neighborhood, postal_code, salary) VALUES
(1001, 'ROGM750623MDFMSR08', 'ROGM750623BB4', 'María Rodríguez', '5559876543', 'maria.rodriguez@banco.com', '1975-06-23', '2010-05-15', 'f', 101, 'Calle Lamartine 78', 'Polanco', 11520, 75000.00),
(1002, 'GARC800115HJCLRN09', 'GARC800115CC5', 'Carlos García', '3334567890', 'carlos.garcia@banco.com', '1980-01-15', '2015-11-20', 'm', 102, 'Av. Vallarta 500', 'Americana', 44600, 65000.00),
(1003, 'LOPJ881022MDFZTR07', 'LOPJ881022DD6', 'Jessica López', '6621112233', 'jessica.lopez@banco.com', '1988-10-22', '2018-03-10', 'f', 103, 'Calle Serdán 234', 'Centro', 83240, 60000.00),
(1004, 'HERN920301HCHRRN01', 'HERN920301EE7', 'Roberto Hernández', '6145556677', 'roberto.hernandez@banco.com', '1992-03-01', '2020-07-01', 'm', 104, 'Av. Universidad 765', 'Centro', 31000, 58000.00),
(1005, 'MART850505MTSMNL05', 'MART850505FF8', 'Laura Martínez', '9937778889', 'laura.martinez@banco.com', '1985-05-05', '2017-09-12', 'f', 105, 'Calle 27 de Febrero 321', 'Centro', 86000, 62000.00);

-- 6. Insert Clients
INSERT INTO client (curp, rfc, name, gender, date_of_birth, phone, email, address, neighborhood, postal_code) VALUES
('PERJ920315HDFLRN01', 'PERJ920315AA1', 'Juan Pérez', 'm', '1992-03-15', '5551234567', 'juan.perez@email.com', 'Av. Reforma 505', 'Polanco', 11520),
('GOMS870722MJCLNS02', 'GOMS870722BB2', 'Sofía Gómez', 'f', '1987-07-22', '3337654321', 'sofia.gomez@email.com', 'Calle López Cotilla 1200', 'Centro', 44600),
('RODL900101HPLBRC03', 'RODL900101CC3', 'Luis Rodríguez', 'm', '1990-01-01', '6625551234', 'luis.rodriguez@email.com', 'Blvd. Rosales 456', 'Centro', 83240),
('HEGJ950808HCHRRS04', 'HEGJ950808DD4', 'Jimena Hernández', 'f', '1995-08-08', '6149998888', 'jimena.hernandez@email.com', 'Calle Aldama 789', 'Centro', 31000),
('MARG880303MTSMNL06', 'MARG880303EE5', 'Gabriela Martínez', 'f', '1988-03-03', '9932223334', 'gabriela.martinez@email.com', 'Av. Francisco I. Madero 456', 'Centro', 86000);

-- 7. Create Accounts
INSERT INTO account (clabe, account_type, branch_id, balance, opening_date, account_state) VALUES
-- Juan Pérez (2 accounts)
('01218000115209987654', 'CHECKING', 101, 0, '2023-01-15', 'ACTIVE'),
('01218000115201234567', 'SAVINGS', 101, 0, '2023-01-15', 'ACTIVE'),
-- Sofía Gómez
('01468000446009876543', 'INVESTMENT', 102, 0, '2023-02-20', 'ACTIVE'),
-- Luis Rodríguez
('01728000832401122334', 'CHECKING', 103, 0, '2023-03-10', 'ACTIVE'),
-- Jimena Hernández
('01148000310005566778', 'SAVINGS', 104, 0, '2023-04-05', 'ACTIVE'),
-- Gabriela Martínez
('01518000860009988776', 'CHECKING', 105, 0, '2023-05-12', 'ACTIVE');

-- 8. Link Clients to Accounts
INSERT INTO accounts_clients (curp, clabe) VALUES
('PERJ920315HDFLRN01', '01218000115209987654'),
('PERJ920315HDFLRN01', '01218000115201234567'),
('GOMS870722MJCLNS02', '01468000446009876543'),
('RODL900101HPLBRC03', '01728000832401122334'),
('HEGJ950808HCHRRS04', '01148000310005566778'),
('MARG880303MTSMNL06', '01518000860009988776');

-- 9. Transaction: Initial Deposits
-- Juan Pérez
INSERT INTO transaction (id, amount, origin_clabe, destination_clabe, transaction_type, transaction_state, date_time) VALUES
(gen_random_uuid(), 15000, NULL, '01218000115209987654', 'DEPOSIT', 'SUCCESSFUL', '2023-01-15 09:30:00');
UPDATE account SET balance = balance + 15000 WHERE clabe = '01218000115209987654';

-- Sofía Gómez
INSERT INTO transaction (id, amount, origin_clabe, destination_clabe, transaction_type, transaction_state, date_time) VALUES
(gen_random_uuid(), 25000, NULL, '01468000446009876543', 'DEPOSIT', 'SUCCESSFUL', '2023-02-20 11:15:00');
UPDATE account SET balance = balance + 25000 WHERE clabe = '01468000446009876543';

-- Luis Rodríguez
INSERT INTO transaction (id, amount, origin_clabe, destination_clabe, transaction_type, transaction_state, date_time) VALUES
(gen_random_uuid(), 18000, NULL, '01728000832401122334', 'DEPOSIT', 'SUCCESSFUL', '2023-03-10 14:20:00');
UPDATE account SET balance = balance + 18000 WHERE clabe = '01728000832401122334';

-- Jimena Hernández
INSERT INTO transaction (id, amount, origin_clabe, destination_clabe, transaction_type, transaction_state, date_time) VALUES
(gen_random_uuid(), 12000, NULL, '01148000310005566778', 'DEPOSIT', 'SUCCESSFUL', '2023-04-05 10:45:00');
UPDATE account SET balance = balance + 12000 WHERE clabe = '01148000310005566778';

-- Gabriela Martínez
INSERT INTO transaction (id, amount, origin_clabe, destination_clabe, transaction_type, transaction_state, date_time) VALUES
(gen_random_uuid(), 20000, NULL, '01518000860009988776', 'DEPOSIT', 'SUCCESSFUL', '2023-05-12 13:30:00');
UPDATE account SET balance = balance + 20000 WHERE clabe = '01518000860009988776';

-- 10. Transaction: Withdrawals
-- Juan Pérez
INSERT INTO transaction (id, amount, origin_clabe, destination_clabe, transaction_type, transaction_state, date_time) VALUES
(gen_random_uuid(), 5000, '01218000115209987654', NULL, 'WITHDRAWAL', 'SUCCESSFUL', '2023-01-20 16:45:00');
UPDATE account SET balance = balance - 5000 WHERE clabe = '01218000115209987654';

-- Sofía Gómez
INSERT INTO transaction (id, amount, origin_clabe, destination_clabe, transaction_type, transaction_state, date_time) VALUES
(gen_random_uuid(), 10000, '01468000446009876543', NULL, 'WITHDRAWAL', 'SUCCESSFUL', '2023-03-01 12:30:00');
UPDATE account SET balance = balance - 10000 WHERE clabe = '01468000446009876543';

-- 11. Transaction: Transfer
-- Juan to Sofía
INSERT INTO transaction (id, amount, origin_clabe, destination_clabe, transaction_type, transaction_state, date_time) VALUES
(gen_random_uuid(), 3000, '01218000115209987654', '01468000446009876543', 'TRANSFER', 'SUCCESSFUL', '2023-02-05 14:00:00');
UPDATE account SET balance = balance - 3000 WHERE clabe = '01218000115209987654';
UPDATE account SET balance = balance + 3000 WHERE clabe = '01468000446009876543';

-- 12. Transaction: Loan (Personal Loan for Juan)
WITH trans AS (
  INSERT INTO transaction (id, amount, origin_clabe, destination_clabe, transaction_type, transaction_state, date_time) 
  VALUES (gen_random_uuid(), 50000, NULL, '01218000115209987654', 'LOAN', 'SUCCESSFUL', '2023-03-10 10:00:00')
  RETURNING id
)
INSERT INTO loan (id, clabe, borrowed_amount, type, annual_interest_rate, term_years, monthly_payment, outstanding_debt, start_date, status, disbursement_transaction) 
VALUES (7001, '01218000115209987654', 50000, 'PERSONAL', 12.5, 3, 1670, 50000, '2023-03-10 10:00:00', 'ACTIVE', (SELECT id FROM trans));
UPDATE account SET balance = balance + 50000 WHERE clabe = '01218000115209987654';

-- 13. Transaction: Loan Payment (Juan)
WITH trans AS (
  INSERT INTO transaction (id, amount, origin_clabe, destination_clabe, transaction_type, transaction_state, date_time) 
  VALUES (gen_random_uuid(), 1670, '01218000115209987654', NULL, 'PAYMENT', 'SUCCESSFUL', '2023-04-05 11:30:00')
  RETURNING id
)
INSERT INTO loan_payment (id, transaction_id, loan_id, monthly_payment, date_time) 
VALUES (8001, (SELECT id FROM trans), 7001, 1670, '2023-04-05 11:30:00');
UPDATE loan SET outstanding_debt = outstanding_debt - 1670 WHERE id = 7001;
UPDATE account SET balance = balance - 1670 WHERE clabe = '01218000115209987654';

-- 14. Transaction: Fixed Deposit Opening (Sofía)
WITH trans AS (
  INSERT INTO transaction (id, amount, origin_clabe, destination_clabe, transaction_type, transaction_state, date_time) 
  VALUES (gen_random_uuid(), 10000, '01468000446009876543', NULL, 'FD_OPENING', 'SUCCESSFUL', '2023-04-15 09:45:00')
  RETURNING id
)
INSERT INTO fixed_deposit (id, clabe, amount, annual_interest_rate, term_years, opening_date_time, maturity_date_time, status, transaction_id) 
VALUES (9001, '01468000446009876543', 10000, 7.0, 1, '2023-04-15 09:45:00', '2024-04-15 09:45:00', 'ACTIVE', (SELECT id FROM trans));
UPDATE account SET balance = balance - 10000 WHERE clabe = '01468000446009876543';

-- 15. Transaction: Monthly Interest (Jimena)
WITH trans AS (
  INSERT INTO transaction (id, amount, origin_clabe, destination_clabe, transaction_type, transaction_state, date_time) 
  VALUES (gen_random_uuid(), 15, NULL, '01148000310005566778', 'INTEREST', 'SUCCESSFUL', '2023-05-31 23:59:59')
  RETURNING id
)
INSERT INTO account_interest (id, clabe, previous_balance, annual_interest_rate, interest_amount, transaction_id) 
VALUES (5001, '01148000310005566778', 12000, 1.5, 15, (SELECT id FROM trans));
UPDATE account SET balance = balance + 15 WHERE clabe = '01148000310005566778';

-- 16. Transaction: Fixed Deposit Maturity (Sofía)
WITH trans AS (
  INSERT INTO transaction (id, amount, origin_clabe, destination_clabe, transaction_type, transaction_state, date_time) 
  VALUES (gen_random_uuid(), 10700, NULL, '01468000446009876543', 'FD_MATURITY', 'SUCCESSFUL', '2024-04-15 10:00:00')
  RETURNING id
)
INSERT INTO fd_interest (id, fd_id, fixed_deposit_amount, interest_amount, transaction_id) 
VALUES (6001, 9001, 10000, 700, (SELECT id FROM trans));
UPDATE fixed_deposit SET status = 'PAID' WHERE id = 9001;
UPDATE account SET balance = balance + 10700 WHERE clabe = '01468000446009876543';

-- 17. Transaction: Car Loan (Luis)
WITH trans AS (
  INSERT INTO transaction (id, amount, origin_clabe, destination_clabe, transaction_type, transaction_state, date_time) 
  VALUES (gen_random_uuid(), 200000, NULL, '01728000832401122334', 'LOAN', 'SUCCESSFUL', '2023-06-01 14:30:00')
  RETURNING id
)
INSERT INTO loan (id, clabe, borrowed_amount, type, annual_interest_rate, term_years, monthly_payment, outstanding_debt, start_date, status, disbursement_transaction) 
VALUES (7002, '01728000832401122334', 200000, 'CAR', 8.0, 5, 4055, 200000, '2023-06-01 14:30:00', 'ACTIVE', (SELECT id FROM trans));
UPDATE account SET balance = balance + 200000 WHERE clabe = '01728000832401122334';

-- 18. Transaction: Mortgage Payment (Gabriela)
WITH trans AS (
  INSERT INTO transaction (id, amount, origin_clabe, destination_clabe, transaction_type, transaction_state, date_time) 
  VALUES (gen_random_uuid(), 8500, '01518000860009988776', NULL, 'PAYMENT', 'SUCCESSFUL', '2023-06-05 12:15:00')
  RETURNING id
)
-- Note: Pretend loan was created earlier
UPDATE account SET balance = balance - 8500 WHERE clabe = '01518000860009988776';

-- 19. Transaction: Transfer between Gabriela and Jimena
INSERT INTO transaction (id, amount, origin_clabe, destination_clabe, transaction_type, transaction_state, date_time) VALUES
(gen_random_uuid(), 2500, '01518000860009988776', '01148000310005566778', 'TRANSFER', 'SUCCESSFUL', '2023-07-10 15:20:00');
UPDATE account SET balance = balance - 2500 WHERE clabe = '01518000860009988776';
UPDATE account SET balance = balance + 2500 WHERE clabe = '01148000310005566778';

-- 20. Transaction: Savings Withdrawal (Juan)
INSERT INTO transaction (id, amount, origin_clabe, destination_clabe, transaction_type, transaction_state, date_time) VALUES
(gen_random_uuid(), 2000, '01218000115201234567', NULL, 'WITHDRAWAL', 'SUCCESSFUL', '2023-08-15 11:45:00');
UPDATE account SET balance = balance - 2000 WHERE clabe = '01218000115201234567';

-- Final Balances Check
SELECT c.name, a.clabe, a.balance, a.account_type 
FROM account a
JOIN accounts_clients ac ON a.clabe = ac.clabe
JOIN client c ON ac.curp = c.curp;