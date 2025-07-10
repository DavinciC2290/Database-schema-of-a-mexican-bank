# Database-schema-of-a-mexican-bank


This is a database schema of a mexican bank, performed in postgresql, it stores basic transaction operations like: transfers, cash deposits, loans, withdrawals, interest payment of accounts (e.g. savings account), loan's payments, fixed-term deposits and  its fixed deposit interests paid along with the principal deposit.  Of course, also it contains the related information for one bank like: employees, clients, branchs, accounts, etc.

It's a schema of bank with digital transactions without physical cards, it's a semi-complete banking database schema with its foreign and primary keys well-established to ensuring consistency, integrity and coherence in the data. However it's my initial project for a system so complex like a bank, could lack something else. In the files are mock real-world data to prove.


***DESCRIPTION OF ENTITIES, FIELDS AND RELATIONSHIPS.***


***1. Area.*** All the postal codes in Mexico that indicate which state/municipality they are in.

- postal_code: a five-digit numerical code used to identify specific locations in Mexico. With the number identifies the state and municipality.

- state: A state of the country.

- municipality: The mayor´s office or one part of the state.
  


***2. Client.***

- curp: Unique Population Registry Code (CURP) is a unique identifier for a person in Mexico.

- rfc: Federal Taxpayer Registry (RFC) used for tax matters in Mexico.

- name: The full name of the customer.

- gender: (enum: 'M', 'F', 'O'), if M is masculine, if F is female, O if you prefer another.

- date_of_birth: The day the client was born.

- phone: The cell phone or landline number 

- email: email address to contact the client.

- address: The street and number where they live.

- neighborhood: The name of the small area within the city

- postal_code: The number related to the state and municipality.

***Client - Area*** relationship (postal_code):  A client lives in one Area, and in the area live so much clients. Many-to-one relationship.



***3. Branch.***

- id: A number that identifies the branch.

- name: Branch name.

- address: Street and branch number.

- neighborhood: branch neighborhood.

- postal_code: Branch postal code.

- swift_code: Also known as a Bank Identifier Code (BIC), is a unique 8-11 character code used to identify banks and financial institutions globally, primarily for international money transfers. 

***Branch - Area*** relationship (postal_code): A branch is located in one area, and in the area there are many branches located. Many-to-one relationship.




***4. Employee.***

- id: Employee id.

- curp: Employee curp.

- rfc: Employee RFC.

- name: Employee name.

- phone: Employee phone.

- email: Employee's email address.

- date_of_birth: date of birth the employee was born.

- joining_date: Date when the employee started working at the bank.

- gender:  employee gender.

- branch_id: Which branch it belongs to.

- address: Employee address.

- neighborhood: Employe neighborhood.

- postal_code: Employee's postal code.

- salary: Employee's salary

***Emoloyee - Branch*** relationship (branch_id):  An employee works in one branch, and in one branch work many employees. Many-to-one relationship.

***Employee - Area*** relationship (postal_code): An employee lives in one area, and in one area live many employees.  Many-to-one relationship.




***5. Account type.***

- type: types of accounts: SAVINGS, CHECK, INVESTMENT.

- annual_interest_rate: Percentage that you are paid per year or month.

- maintenance_charges: How much they charge you each month to maintain the account.



***6. Account.***

- clabe: A 18-digit number, clabe number is the "key" that identifies your account when you send or recieve money.

- account_type: Customer's type of account.

- branch_id: In Which branch the account was opened.

- balance: How much money there is in the account.

- opening_date: When the account was opened.

- account_state: Account's state: 'ACTIVE', 'CLOSED', 'FROZEN'.

***Account - Account type*** relationship (account_type): An account is of an account type, and one account type are in many accounts. Many-to-one relationship.  

***Account - Branch*** relationship (branch_id): An account is opened in one branch, and in one branch is open too much accounts. Many-to-one relationship.

 


***7. Accounts_clients.*** Because that the account  and client tables have a many-to-many relationship a cross-reference table is created with their primary keys to match each client with his account.

- curp: Client curp.
- clabe: Account clabe.

***Accounts_clients - Clients*** relationship (curp): A client can have many different accounts (SAVINGS, CHECKING, INVESTMENT).

***Accounts_clients - Accounts*** relationship (clabe): An account can belong to different clients. (e.g. a joint bank account)

***Composite primary key(curp, clabe)***. So, because of the 2 relationships, it's a many-to-many relationship, the primary key of client can appear in different records and the same with account.



***8. Transaction.***

- id: Identifier that identifies each transaction, it's  a UUID, which means Universal Unique Identifier. 

- amount: How much money was moved.

- origin_clabe: From which account the money came, If it is a cash deposit or it is a transfer made by the bank itself,  the field is left empty.

- destination_clabe: Which account the money arrived at, if it is a cash withdrawal or it is a payment for the bank, the field is left empty.

- transaction_type:  'DEPOSIT', 'WITHDRAWAL', 'TRANSFER', 'PAYMENT', 'LOAN', 'INTEREST', 'FD_OPENING', 'FD_MATURITY'.

- transaction_state:  Whether the transaction went well or not. ('SUCCESSFUL', 'FAILED', 'PENDING').

- date_time: Exact date and time when the transacion was made.

***Transaction - Account:*** relationship (origin_clabe): One transaction was made by only one account, and one account can do many transactions. Many-to-one relationship.

***Transaction - Account*** relationship (destination_clabe): One transaction is targeted to an only account, and one account can receive many transactions. Many-to-one relationship.



***9. Account interest.*** Every year or every month, depending on the bank, they look at how much money was in your account and calculate the interest you're owed. 

- id: ID of the interest paid for each account.

- clabe: The account to which the interest was paid.

- previous_balance: How much was in your account at the time of calcultation.

- annual_interest_rate:  The percentage that was used for calculate the interest.

- interest_amount: How much interest you were paid.

- transaction_id: The ID of the transaction that made the interest deposit.

***Account interest - Account*** relationship (clabe): One account interest's payment is made for only one account, and one account can receive many account interest's payments.  Many-to-one relationship. 

***Account interest - Transaction*** relationship (transaction_id): One account interest's payment is made by one transaction, and one transaction only belongs to one account interest´s payment. One-to-one realtionship.



***10. Loan type.***

- type: 'PERSONAL', 'AUTO', 'MORTGAGE', 'STUDENT'.

- annual_interest_rate: The interest percentage to pay along with the loan.

- advance_payment_charge: If you want to pay early, how much they charge you.



***11. Loan:***

- id:  ID that identifies the loan granted to each client. 

- clabe: The account to which the loan is transferred and from which the fee is charged

- borrowed_amount: How much money the bank lent you.

- type:  'PERSONAL', 'AUTO', 'MORTGAGE', 'STUDENT'.

- annual_interest_rate: The interest percentage to pay along with the loan 

- term_years: In how many years you will pay.

- monthly_payment: The monthly payment that you must pay of the loan.

- outstanding_debt: Amount that you owe. It updates for each monthly payment.

- start_date: When the loan was transferred.

- status: Whether the loan is still being paid, has already been paid off, or has not been paid and is in default. ('ACTIVE', 'LIQUIDATED', 'DEFAULTER').

- disbursement_transaction: The ID of the transaction that deposited the loan money to the customer.

***Loan - Account*** relationship (clabe): A loan is requested by one account, and one account can request some loans. Many-to-one relationship.

***Loan - Loan type*** relationship (type): A loan is of one loan type, and one loan type are in many loans. Many-to-one relationship.


***Loan - Transaction*** relationship (disbursement_transaction): One loan disbursement is made by one transaction, and one transaction can only belong to a loan disbursement. One-to-one relationship.




***12. Loan payment.*** Every time a customer pays his monthly fee of his loan, the bank records it here to determine whether they're current or not.

- id: ID of the monthly payment 

- transaction_id: monthly payment transaction.

- loan_id: ID of the loan related  to this monthly payment.

- monthly_payment: How much you paid on that month.

- date_time: The day you paid.

***Loan payment - Transaction*** relationship (transaction_id): A loan payment is made by one transaction, and one transaction can only belong to one loan payment. One-to-one realtionship.

***Loan payment - Loan*** relationship (loan_id): A monthly loan payment is made for a loan, and a loan can receive many monthly loan payments. Many-to-one relationship.




***13. Fixed deposit.*** Fixed-term deposit, when a customer decides to give the bank an amount of money they can't withdraw for a period of time (for example,  1 or 2 years), the bank pays them a higher rate in return. 

- id: Fixed deposit identifier.

- clabe: The account from which the client took the money to put it into FD.

- amount: How much money the client put in.

- annual_interest_rate: The rate you will be paid.

- term_years: How many years will you leave the money locked up.

- opening_date_time: Date and time when you opened it

- maturity_date_time: Date and time when your fixed-term deposit and interest earned will be deposited to your account.

- status: If it's still running, it has been already paid or you cancelled it before. ('ACTIVE', 'PAID', 'CANCELED').

- transaction_id: Transaction of the fixed-term deposit for the bank and can make it  grow.

***Fixed deposit - Account*** relationship (clabe): One fixed-term deposit is made by one account, and one account can do many fixed-term deposits. Many-to-one relationship.

***Fixed deposit - Transaction*** relationship (transaction_id): One fixed-term deposit is made by one transaction, and one transaction can only belong to one fixed-term deposit. One-to-one relationship.



***14. Fixed deposit interest.***  When the fixed-term deposit matures, the bank calculates the interest earned and returns it to you along with the principal (amount of the FD without interest ).

- id:  ID of the fixed-term deposit's interest paid.

- fd_id: ID of the fixed-term deposit related a this interest paid.

- fixed_deposit_amount: Amount deposited in the FD_opening

- interest_amount: Interest earned when the maturity date is reached.

- transaction_id: Transaction of the fixed-term deposit plus the interest earned.

***Fd_interest - Fixed deposit*** relationship (fd_id): One fd_interest payment is made for just one fixed-term deposit, and one fixed-term deposit just have one fd_interest payment. One-to-one relationship.

***Fd_interest - Transaction*** relationship (transaction_id): One fd_interest payment is made by one transaction, and one transaction can just belong to one fd_interest payment. One-to-one relationship.








