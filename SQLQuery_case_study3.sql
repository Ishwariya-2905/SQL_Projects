use Functions

select * from Continent
select * from customer1
select * from [Transaction]

-- Display the count of customers in each region who have done the
--transaction in the year 2020
select count(distinct CU.customer_id) as Count_of_customers, region_name from Continent as CO 
inner join
customer1 as CU
on CO.region_id = CU.region_id
inner join
[transaction] as T
on T.customer_id = CU.customer_id
where year(txn_date) = 2020
group by region_name

-- Display the maximum and minimum transaction amount of each
--transaction type.
select max(txn_amount) as Maximum_amount, min(txn_amount) as Minimum_amount, txn_type
from [Transaction]
group by txn_type

-- Display the customer id, region name and transaction amount where
--transaction type is deposit and transaction amount > 2000
select  T.customer_id, region_name, txn_amount from Continent as CO
inner join
customer1 as CU
on CO.region_id = CU.region_id
inner join
[transaction] as T
on T.customer_id = CU.customer_id
where txn_amount > 2000 and txn_type = 'deposit'

-- Find duplicate records in the Customer table.
SELECT region_id, Start_Date, End_Date, COUNT(*) AS Duplicate_Count
FROM customer1
GROUP BY region_id, Start_Date, End_Date
HAVING COUNT(*) > 1;

-- Display the customer id, region name, transaction type and transaction
--amount for the minimum transaction amount in deposit.
select T.customer_id,region_name, txn_type, txn_amount , min(txn_amount) as Minimum_amount from Continent as CO
inner join
customer1 as CU
on CO.region_id = CU.region_id
inner join
[transaction] as T
on T.customer_id = CU.customer_id
where txn_type = 'deposit'
group by T.customer_id,region_name, txn_type, txn_amount

-- Create a stored procedure to display details of customers in the
--Transaction table where the transaction date is greater than Jun 2020
create procedure transaction_details as
select * from customer1 as C
inner join
[Transaction] as T
on C.customer_id = T.customer_id
where txn_date > '2020-06-30'

exec dbo.transaction_details

--Create a stored procedure to insert a record in the Continent table
create procedure inserting_record
    @region_id int,
	@region_name varchar(20)
as
begin 
      insert into Continent values(@region_id, @region_name)
end

exec inserting_record @region_id=6, @region_name= '	Africa'
select * from Continent

-- Create a stored procedure to display the details of transactions that
--happened on a specific day.
create procedure gettransactionsdate
       @txn_date DATE
as
begin
     select *
	 from [Transaction]
	 where txn_date = @txn_date
end
       
exec gettransactionsdate @txn_date = '2020-01-14'

-- Create a user defined function to add 10% of the transaction amount in a table.
create function add_amount(@input decimal(10,2))
returns decimal(10,2)
as 
begin
     declare @updated_amount decimal(10,2);
	 set @updated_amount = @input + (@input * 0.10)

return @updated_amount
end

update [transaction]
set txn_amount = dbo.add_amount(txn_amount)

select * from [Transaction]

--Create a user defined function to find the total transaction amount for a
--given transaction type.
create function total_transaction()
returns table
as 
return
(
    select txn_type , sum(txn_amount) as Total_amount
	from [Transaction]
	group by txn_type
)

select * from total_transaction()

--Create a table value function which comprises the columns customer_id,
--region_id ,txn_date , txn_type , txn_amount which will retrieve data from the above table.
create function retrieve_data()
returns table
as
return
(
   select T.customer_id, CU.region_id , txn_date,txn_type, txn_amount
   from Continent as CO
   inner join
   customer1 as CU
   on CO.region_id = CU.region_id
   inner join
   [transaction] as T
   on T.customer_id = CU.customer_id
)

Select * from retrieve_data()

--Create a TRY...CATCH block to print a region id and region name in a
--single column.
begin try
       select cast(region_id as nvarchar) + ' - ' + region_name as region_details
	   from continent
end try
begin catch
          select error_message() as error_message;
end catch

-- Create a TRY...CATCH block to insert a value in the Continent table.
begin try
        insert into continent (region_id , region_name)
		values (7, 'India')
end try
begin catch
         select error_number() as error_number,
		        error_message() as error_message;
end catch

select * from continent

-- Create a trigger to prevent deleting a table in a database
create trigger prevent_delete
on database
for drop_table
as
begin
    print('Table deletion will not be allowed in this database')
	rollback
end

drop table customer1

--Create a trigger to audit the data in a table
----------------------------------

--Create a trigger to prevent login of the same user id 
--in multiple pages.





-- Display top n customers on the basis of transaction type.
select customer_id,txn_type ,sum(txn_amount) as Total_amount
from [Transaction]
group by customer_id, txn_type
order by sum(txn_amount) desc

-- Create a pivot table to display the total purchase, withdrawal and
--deposit for all the customers.
select customer_id,
[deposit] as Total_deposit,
[Purchase] as Total_purchase,
[withdrawal] as Total_withdrawal
from
   (select 
         customer_id,
		 txn_type,
		 txn_amount
		 from [Transaction]) as Source_Table
Pivot
     (sum(txn_amount) for txn_type in ([deposit], [Purchase],[withdrawal])) as Pivot_table
order by customer_id
	 
