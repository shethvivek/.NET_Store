Create table Category
(
	CategoryID int primary key,
	CategoryName varchar(50) not null
);

Insert into Category values
(1,'Electronics'),
(2,'Furniture'),
(3,'Mobile');

Select * from Category;

-----------------------------------------------------------------------------------------------------------------------------------------

Create table Product
(
	ProductID varchar(5) primary key,
	ProductName varchar(50) not null,
	Price int not null,
	Quantity int not null,
	CategoryID int REFERENCES dbo.Category(CategoryID) 
)

insert into Product values
('P101','3D LED',35000,5,1),
('P102','Plasma',42000,2,1),
('P103','Sofa',8200,20,2),
('P104','Chair',1100,50,2),
('P105','Asus Zenfone',15000,10,3)

SELECT * from Product

-----------------------------------------------------------------------------------------------------------------------------------------

Create table Customer
(
CustomerId int Primary Key,
CustomerNAme varchar(50) not null,
City varchar(50) not null,
Country varchar(50) not null
)

insert into Customer values
(1,'Roony','Berlin','Germany'),
(2,'Mike','London','UK'),
(3,'John','Utrecht','NL'),
(4,'Newton','Amsterdams','NL'),
(5,'Ila','Delhi','India'),
(6,'Vivek','Pune','India')

select * from Customer

-----------------------------------------------------------------------------------------------------------------------------------------

Create table Department
(
	DepartmentId int Primary key,
	DepartmentName varchar(50) not null
)

insert into Department values
(1,'Software'),
(2,'Marketing'),
(3,'Finance'),
(4,'HR'),
(5,'Research')

select * from Department


-----------------------------------------------------------------------------------------------------------------------------------------

--

Create table Employee
(
EmployeeId int primary key,
EmployeeName varchar(50) null,
Salary int constraint chk_sal check(Salary between 10000 and 20000) not null,
JoiningDate date default getdate(),
DepartmentId int references dbo.Department(DepartmentId)
	on delete cascade on update cascade
)

-----------------------------------------------------------------------------------------------------------------------------------------

--Inner join

select e.EmployeeId,e.EmployeeName,d.DepartmentName
from Employee e
inner join Department d
on e.DepartmentId = d.DepartmentId;

-- Outer Join
select * from Employee,Department

--Full outer join

Select EmployeeName,DepartmentName from Employee
full outer join Department
on Employee.DepartmentId = Department.DepartmentId

--left outer join

select EmployeeName,DepartmentName from Employee
left outer join Department
on Employee.DepartmentId=Department.DepartmentId

--Right outer join
select EmployeeName,DepartmentName from Employee
Right outer join Department
on Employee.DepartmentId=Department.DepartmentId

--Self join

select e.EmployeeId,e.EmployeeName,e.ManagerId,m.EmployeeName
 from Employee e
join
Employee m
on e.ManagerId=m.EmployeeId

-----------------------------------------------------------------------------------------------------------------------------------------
--Views

Create view [Products above average price]
as
select Product.ProductName,Product.Price from Product
where price >
(select AVG(Price) from Product)

select * from [Products above average price];

------------------------------------------------------------------
--Insert records in View. 

Create view AddProduct
as
select * from Product

insert into AddProduct values
('P109','Moto G',10500,15,3)

select * from AddProduct
select * from Product

-----------------------------------------------------------------------------------------------------------------------------------------
--Bulk INSERT

Create table testdb
(
testid varchar(100),
testname varchar(100),
testtype varchar(100)
)

drop table testdb;

select * from testdb;

bulk insert testdb
from 'D:\\SQL\test.txt'
with
(
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '.\n'
);
Go

-----------------------------------------------------------------------------------------------------------------------------------------
--INSERT XML record in DATABASE

--Inserting RECORD
declare @SampleXml xml;
SET @SampleXML ='
<root>
	<Data>This is my first Data</Data>
	<Data>This is my Second Data</Data>
</root>
'
Insert into tbl_MyXMLTab values(@SampleXml);

--Create Table
Create table tbl_MyXMLTab
(
	IdVal integer primary key Identity,
	DataVal xml
)

select * from tbl_MyXMLTab

--Insert into tbl_MyXMLTab values('<Doc2></Doc2>');
Insert into tbl_MyXMLTab values('<Doc1><Doc1><Doc2></Doc2>');


-----------------------------------------------------------------------------------------------------------------------------------------
--Output Keyword

Create table Books
(
BookId int Primary key,
BookTitle varchar(50) not null,
ModifiedDate datetime not null
)

insert into Books values
(101,'Learn MVC in 7 Days','2015-01-01'),
(102,'.NET interview Question','2015-01-01'),
(103,'ITIL Foundation','2015-01-01')

select * from Books

drop table Books

declare @deletedOutput table
(
	BId int,
	Btitle varchar(50),
	ModifiedDate datetime
)
delete Books output deleted.* into @deletedOutput where BookId=103
select * from @deletedOutput;

-----------------------------------------------------------------------------------------------------------------------------------------
--TOP clause
Select * from Product
select top(3) * from Product
select top(3) with ties * from Product order by price

-----------------------------------------------------------------------------------------------------------------------------------------
--ROW_NUMBER()
select
ProductId,ProductName,Price,CategoryId,
ROW_NUMBER() over (Order by price desc)
as RowNo
from Product
order by RowNo

--Rank()
select ProductId,ProductName, Price,
Rank() over (ORder by Price desc)
as Rank
from Product

--DENSE_RANK()
select ProductId, ProductName, Price,
DENSE_RANK() over (order by price desc)
As DenseRank
from Product

--NTILE()
select ProductId, ProductName, Price,
NTILE(2) over (order by Price desc) as NTILE_Number
from Product

-----------------------------------------------------------------------------------------------------------------------------------------

--Pivot

Create table SalesDetail
(
Make varchar(50),
Year int,
Sales int
)

Insert into SalesDetail values
('Honda',2005,6000),
('Honda',2006,8000),
('Maruti',2005,6500),
('Honda',2006,4500),
('Maruti',2006,4500)

select * from SalesDetail

--Pivot
Select * from SalesDetail
Pivot(Sum(Sales) for year in ([2005],[2006])) as YearSales

-----------------------------------------------------------------------------------------------------------------------------------------

--CTE (Common Table Expression)

select * from Employee

--Without CTE
select * from Employee as e inner join
(select employeeId from Employee group by EmployeeId) as c
on e.EmployeeId=c.EmployeeId;

--With CTE
with c(EmployeeId)
as (select employeeId from Employee
group by EmployeeId)
select * from employee e inner join c
on e.EmployeeId=c.EmployeeId

-----------------------------------------------------------------------------------------------------------------------------------------
-- Identity
Create table orders
(
OrderiId int identity(1001,1) primary key,
OrderNAme varchar(20)
)

drop table orders;

insert into orders values
('Pen'),
('Notebook')

select * from orders;

/*To Insert values explicitly into the table for Identity*/
SET Identity_Insert orders on
insert into orders(OrderiId,OrderNAme) values(1003,'Pencil');
SET Identity_Insert orders OFF

Insert into orders values ('Marker');

-----------------------------------------------------------------------------------------------------------------------------------------
Difference between Identity and Sequence

-----------------------------------------------------------------------------------------------------------------------------------------

--Create SEQUENCE

Create SEQUENCE mySeq
		as TinyINT
		start with 1	--	Start with value 1
		Increment by 1	--	Increment with value 1
		MinValue 1		-- Minimum value to start is 1
		MaxValue 10		--	Maximum it can go to 10
		No cycle		-- Do not increase above 10
		cache 10		--	Increment 9 values in memory rather than cache
Go
--Generate next value for sequence
Select Next value for mySeq

Drop SEQUENCE mySeq

Create table testdb1
(
	id int,
	testname varchar(100)
)

Insert into testdb1 values(Next value for MySeq,'Test1');
Insert into testdb1 values(Next value for MySeq,'Test2');
Insert into testdb1 values(Next value for MySeq,'Test3');
Insert into testdb1 values(Next value for MySeq,'Test4');
Insert into testdb1 values(Next value for MySeq,'Test5');
Insert into testdb1 values(Next value for MySeq,'Test6');
Insert into testdb1 values(Next value for MySeq,'Test7');
Insert into testdb1 values(Next value for MySeq,'Test8');
Insert into testdb1 values(Next value for MySeq,'Test9');
Insert into testdb1 values(Next value for MySeq,'Test10');
Insert into testdb1 values(Next value for MySeq,'Test11');		-- It will give an error for this record.

select * from testdb1

drop table testdb1;

Select current_value from sys.sequences where name='Myseq'

-----------------------------------------------------------------------------------------------------------------------------------------
--Merge

Create table Customer1
(
FirstName varchar(20) not null,
DOB date not null,
Email varchar(100) not null
)

Create table UpdateCustomerInfo
(
	FirstName varchar(50) not null,
	DOB date not null,
	Email varchar(100) not null
)

Insert into Customer1
(FirstName,DOB,Email)
values
('Dave','1976-02-26','Dave@Robinson.com'),
('Phill','1971-05-13','Phill@PhillJones.com')

Insert into UpdateCustomerInfo
(FirstName,DOB,Email)
values
('Dave','1976-02-26','Dave@Robinson.com'),	--No change
('Phill','1999-12-14','Phill@PhillJones.com'),	--	Update
('Jack','1979-01-05','Jack@Jackwhite.com')


Merge Customer1 as [Target]
using UpdateCustomerInfo as [Source]
	on [Target].Email = Source.Email
When matched and
(
	[Target].FirstName <> Source.FirstName
	or [Target].DOB <> Source.DOB
)
Then Update SET
FirstName = Source.FirstName,
DOB = Source.DOB
When NOT Matched by Target
then Insert(Email,FirstName,DOB)
values(
Source.Email,
Source.FirstName,
Source.DOB
);

select * from Customer1
select * from UpdateCustomerInfo

------------------------------------------------------------------------------------------------------------------------------------------
--Stored Procedure

--****************************************************************************
-- Demo 1
--****************************************************************************

Create procedure usp_FetchProduct
as
Begin
	Select * from Product
End

-- Calling Procedure
Exec usp_FetchProduct

--Dropping procedure
drop procedure usp.FetchProduct;

--****************************************************************************
-- Demo 2
--****************************************************************************

Create procedure usp_FetchProductDetailById
(
@PId char(4)
)
as
begin
select * from Product where ProductID=@PId
end

drop procedure usp_FetchProductDetailById

--Execution
Exec usp_FetchProductDetailById 'P101';

--****************************************************************************
-- Demo 3
--****************************************************************************

Create procedure usp_FetchProductNameAndPrice
(
@PId char(4),
@PName varchar(20) out,
@Price int out
)
as
begin
	select @Pname=ProductName,@Price=Price from Product
end

--Execution
declare @ProdName varchar(20)
declare @Prodprice int

begin
Exec usp_FetchProductNameAndPrice 'P103', @Prodname out, @Prodprice out
select @ProdName,@Prodprice
end

--****************************************************************************
-- Demo 4
--****************************************************************************

Create procedure usp_CheckProductId
(
@Pid char(4)
)
as
begin
	if exists(select * from Product where ProductID=@Pid)
	return 1
	else
	return -1
end

--Execution

declare @retval int
begin
exec @retval = usp_CheckProductId 'P104';
select @retval
end

------------------------------------------------------------------------------------------------------------------------------------------
--Function

Create function ufn_Addition(@num1 int, @num2 int)
returns int
as
begin
return @num1+@num2
end

--Execution

Declare @ret int
begin
exec @ret=ufn_Addition 25,10
select @ret;
end

--Another way to invoke function

select [dbo].ufn_Addition(25,10);

--****************************************************************************
--Inline table value function
--****************************************************************************

Create function ufn_FetchDetails()
returns table
as
return(select * from Product)

--Execution

Select * from ufn_FetchDetails();

--****************************************************************************
--Multi statement table value function
--****************************************************************************

Create table emp
(
Id int,
Salary numeric(10),
Deptid int
)

insert into emp values
(1,10000,30),
(2,20000,20),
(3,5000,10)

select * from emp

create function ufn_UpdateSalary(@id int)
returns @temp table
(
empid int,
sal numeric(10),
did int
)
as
begin
	Declare @eid int
	Declare @sal numeric(10)
	Declare @did int

	select @eid=id, @sal=salary,@did=DeptId from emp
	where DeptId=@id

	if(@did=10)
		set @sal+=500
	else
		set @sal+=1000

		insert into @temp values(@eid,@sal,@did)
		return;
end
Go

--Execution

select * from ufn_UpdateSalary(10)

------------------------------------------------------------------------------------------------------------------------------------------

--Transaction

Create table course(
CourseId int,
CourseName varchar(50)
)

begin transaction INS_RECS
insert into course values
(1,'ASP.NET'),
(2,'C#')

Save transaction INS_SVPT

insert into course values
(3,'HTML')

rollback transaction INS_SVPT	-- this transaction will be Rollback till INS_SVPT

select * from course

commit transaction INS_RECS

------------------------------------------------------------------------------------------------------------------------------------------
--Error Handling

Begin try
select 1/0;
end try

begin catch
select
		ERROR_NUMBER() as ErrorNumber,
		ERROR_SEVERITY() as ErrorSeverity,
		ERROR_STATE() as ErrorState,
		ERROR_PROCEDURE() as ErrorProcedure,
		ERROR_LINE() as ErrorLine,
		ERROR_MESSAGE() as ErrorMessage;
end catch


------------------------------------------------------------------------------------------------------------------------------------------

--Index
--Clustered and Non Clustered

Create table MyIndexTest
(
id int,
name varchar(20)
)

insert into MyIndexTest values
(4,'Sachin'),
(1,'Vijay'),
(3,'Ram'),
(2,'Shyam'),
(5,'Vivek')

select * from MyIndexTest;
select name from MyIndexTest where id=5;
select id from MyIndexTest where name='Ram';

sp_help MyIndexTest;

--Create index on MyIndexTest(name)
Create nonclustered index idx_1 on MyIndexTest(name);
drop index idx_1 on MyIndexTest;

Create nonclustered index idx_4 on MyIndexTest(name);
drop index idx_4 on MyIndexTest;

--Create index on MyIndexTest(id)
Create clustered index idx_2 on MyIndexTest(id);		--Record will arrange in ascending order.
drop index idx_2 on MyIndexTest;

Create clustered index idx_3 on MyIndexTest(id);		--It will give an error.
drop index idx_3 on MyIndexTest;

------------------------------------------------------------------------------------------------------------------------------------------

--Triggers

--Instead trigger
--After Trigger (Insert, Update, DELETE)

--SET BOCOUNT on	-- no message displayed like 5 row afftected.

Create table CustomerInfo
(
CustomerId int identity(1,1) primary key,
Name varchar(50) not null,
Country varchar(50) not null
)

Insert into CustomerInfo values
('Vijay','India'),
('Rahul','US'),
('John','UK'),
('Anna','US')

select * from CustomerInfo;

Create table CustomerLogs
(
LogId int Identity(1,1) primary key,
CustomerId int not null,
Action varchar(50) not null
)

Create trigger Customer_Insert
on CustomerInfo
After Insert
as
BEGIN
	Set nocount on;

	Declare @CustomerId INT;

	Select @CustomerId = inserted.CustomerId from inserted;

	insert into CustomerLogs values(@CustomerId,'Inserted.')
End

Insert into CustomerInfo values
('Vivek Sheth','India')

select * from CustomerInfo;
Select * from CustomerLogs;


Create trigger Customer_InsteadOfDelete
on CustomerInfo
Instead of Delete
as
Begin
		Set Nocount on;

		Declare @CustomerId INT;

		Select @CustomerId = deleted.CustomerId from deleted;

		if @CustomerId = 2
		Begin
			RAISERROR('Rahuls record cannot be deleted',16,1)
			Rollback;
			Insert into CustomerLogs values(@CustomerId,'Record cannot be deleted');
		End
		ELSE
		Begin
			Delete from CustomerInfo where CustomerId=@CustomerId
			Insert into CustomerLogs values(@CustomerId,'Instead of Delete')

		End
End

delete from CustomerInfo where CustomerId=2;

select * from CustomerInfo;
Select * from CustomerLogs;

------------------------------------------------------------------------------------------------------------------------------------------