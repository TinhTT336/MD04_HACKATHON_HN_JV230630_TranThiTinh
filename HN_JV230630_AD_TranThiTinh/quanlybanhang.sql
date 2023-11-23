create database QUANLYBANHANG;
use QUANLYBANHANG;

create table CUSTOMERS(
customer_id varchar(4) not null primary key,
name varchar(100) not null,
email varchar(100) not null,
phone varchar(25) not null,
address varchar(255) not null
);

create table ORDERS(
order_id varchar(4) not null primary key,
customer_id varchar(4) not null,
foreign key (customer_id) references CUSTOMERS (customer_id),
order_date date not null,
total_amount double not null
);

create table PRODUCTS (
product_id varchar(4) not null primary key,
name varchar(255) not null,
description text,
price double not null,
status bit(1) not null default 1
);

create table ORDERS_DETAILS(
order_id varchar(4) not null,
foreign key (order_id) references ORDERS (order_id),
product_id varchar(4) not null,
foreign key (product_id) references PRODUCTS (product_id),
quantity int(11) not null,
price double not null,
primary key (order_id,product_id)
);

-- Bài 2: Thêm dữ liệu
INSERT INTO CUSTOMERS(customer_id,name,email,phone,address)VALUES
('C001','Nguyễn Trung Mạnh','manhnt@gmail.com','984756322','Cầu Giấy, Hà Nội'),
('C002','Hồ Hải Nam','namhh@gmail.com','984875926','Ba Vì, Hà Nội'),
('C003','Tô Ngọc Vũ','vutn@gmail.com','904725784','Mộc Châu, Sơn La'),
('C004','Phạm Ngọc Anh','anhpn@gmail.com','984635365','Vinh, Nghệ An'),
('C005','Trương Minh Cường','cuongtm@gmail.com','989735624','Hai Bà Trưng, Hà Nội');

INSERT INTO PRODUCTS(product_id,name,description,price)VALUES
('P001','Iphone 13 ProMax','Bản 512G, xanh lá',22999999),
('P002','Dell Vostro V3510','Core i5, Ram 8GB',14999999),
('P003','Macbook Pro M2','8CPU 10GPU 8GB 256GB',28999999),
('P004','Apple Watch Ultra','Titanium Alpine Loop Small',18999999),
('P005','Airpods 2 2022','Spatial Audio',4090000);

INSERT INTO ORDERS(order_id,customer_id,total_amount,order_date)VALUES
('H001','C001',52999997,'2023-02-22'),
('H002','C001',80999997,'2023-03-11'),
('H003','C002',54359998,'2023-01-22'),
('H004','C003',102999995,'2023-03-14'),
('H005','C003',80999997,'2022-03-12'),
('H006','C004',110449994,'2023-02-01'),
('H007','C004',79999996,'2023-03-29'),
('H008','C005',29999998,'2023-02-14'),
('H009','C005',28999999,'2023-01-10'),
('H010','C005',149999994,'2023-04-01');


insert into ORDERS_DETAILS(order_id, product_id, price, quantity) values
 ('H001', 'P002', 14999999, 1),
('H001', 'P004', 18999999, 2),
('H002', 'P001', 22999999, 1),
('H002', 'P003', 28999999, 2),
('H003', 'P004', 18999999, 2),
('H003', 'P005', 4090000, 4),
('H004', 'P002', 14999999, 3),
('H004', 'P003', 28999999, 2),
('H005', 'P001', 22999999, 1),
('H005', 'P003', 28999999, 2),
('H006', 'P005', 4090000, 5),
('H006', 'P002', 14999999, 6),
('H007', 'P004', 18999999, 3),
('H007', 'P001', 22999999, 1),
('H008', 'P002', 14999999, 2),
('H009', 'P003', 28999999, 1),
('H010', 'P003', 28999999, 2),
('H010', 'P001', 22999999, 4);

-- Bài 3: Truy vấn dữ liệu [30 điểm]:
-- 1. Lấy ra tất cả thông tin gồm: tên, email, số điện thoại và địa chỉ trong bảng Customers .
SELECT name as Tên, email, phone as 'Số điện thoại', address as 'Địa chỉ' from Customers;

-- 2. Thống kê những khách hàng mua hàng trong tháng 3/2023 (thông tin bao gồm tên, số điện thoại và địa chỉ khách hàng). [4 điểm]
SELECT c.name as Tên, c.phone as 'Số điện thoại', c.address as 'Địa chỉ' from Customers c
JOIN ORDERS o ON c.customer_id=o.customer_id 
where c.customer_id IN(select o.customer_id from ORDERS WHERE o.order_date LIKE '2023-03-%%') ;

-- 3. Thống kê doanh thua theo từng tháng của cửa hàng trong năm 2023 (thông tin bao gồm tháng và tổng doanh thu ). [4 điểm]
select month(order_date) as Tháng, sum(total_amount) as 'Tổng doanh thu' from ORDERS GROUP BY month(order_date);

-- 4. Thống kê những người dùng không mua hàng trong tháng 2/2023 (thông tin gồm tên khách hàng, địa chỉ , email và số điên thoại). [4 điểm]
SELECT c.name as Tên, c.phone as 'Số điện thoại', c.address as 'Địa chỉ', email from Customers c
LEFT JOIN ORDERS o ON c.customer_id=o.customer_id AND month(o.order_date)=2 and year(o.order_date)=2023
WHERE o.order_id is null;

-- 5. Thống kê số lượng từng sản phẩm được bán ra trong tháng 3/2023 (thông tin bao gồm mã sản phẩm, tên sản phẩm và số lượng bán ra). [4 điểm]
SELECT p.product_id as 'mã sản phẩm',p.name as 'tên sản phẩm', sum(od.quantity) as 'số lượng bán ra' from PRODUCTS p
JOIN ORDERS_DETAILS od ON p.product_id=od.product_id 
JOIN ORDERS o ON o.order_id=od.order_id
AND month(o.order_date)=3 and year(o.order_date)=2023 
GROUP BY p.product_id,p.name;

-- 6. Thống kê tổng chi tiêu của từng khách hàng trong năm 2023 sắp xếp giảm dần theo mức chi tiêu (thông tin bao gồm mã khách hàng, tên khách hàng và mức chi tiêu). [5 điểm]
SELECT c.customer_id as 'mã khách hàng',c.name as 'tên khách hàng', sum(o.total_amount) as 'mức chi tiêu' from CUSTOMERS c
JOIN ORDERS o ON c.customer_id=o.customer_id GROUP BY c.customer_id ORDER BY sum(o.total_amount) DESC;

-- 7. Thống kê những đơn hàng mà tổng số lượng sản phẩm mua từ 5 trở lên (thông tin bao gồm tên người mua, tổng tiền , ngày tạo hoá đơn, tổng số lượng sản phẩm) . [5 điểm]
SELECT o.order_id,c.name as 'tên khách hàng', o.total_amount as 'tổng tiền' , o.order_date as 'ngày tạo hoá đơn', sum(od.quantity) as 'tổng số lượng sản phẩm'
from CUSTOMERS c JOIN ORDERS o ON c.customer_id=o.customer_id 
JOIN ORDERS_DETAILS od ON o.order_id=od.order_id GROUP BY order_id HAVING sum(od.quantity)>=5;

-- Bài 4: Tạo View, Procedure [30 điểm]:
-- 1. Tạo VIEW lấy các thông tin hoá đơn bao gồm : Tên khách hàng, số điện thoại, địa chỉ, tổng tiền và ngày tạo hoá đơn . [3 điểm]
create view vw_order as
select c.name as 'Tên khách hàng',c.phone as 'số điện thoại',c.address as 'địa chỉ',o.total_amount as 'tổng tiền', o.order_date as 'ngày tạo hoá đơn' 
from CUSTOMERS c JOIN ORDERS o ON c.customer_id =o.customer_id; 

-- 2. Tạo VIEW hiển thị thông tin khách hàng gồm : tên khách hàng, địa chỉ, số điện thoại và tổng số đơn đã đặt. [3 điểm]
create view vn_customers as
select c.name as 'tên khách hàng',c.address as 'địa chỉ', c.phone as 'số điện thoại', count(o.order_id) as 'tổng số đơn đã đặt' from CUSTOMERS c
JOIN ORDERS o ON c.customer_id=o.customer_id GROUP BY o.customer_id;
-- select * from vn_customers;

-- 3. Tạo VIEW hiển thị thông tin sản phẩm gồm: tên sản phẩm, mô tả, giá và tổng số lượng đã bán ra của mỗi sản phẩm.[3 điểm]
create view vw_products as
select p.name as 'tên sản phẩm',p.description as 'mô tả',p.price as giá, sum(od.quantity) as 'tổng số lượng đã bán ra' from PRODUCTS p
JOIN ORDERS_DETAILS od ON p.product_id=od.product_id GROUP BY p.product_id;
select * from vw_products;

-- 4. Đánh Index cho trường `phone` và `email` của bảng Customer. [3 điểm]
create index index_phone_email on CUSTOMERS(phone,email);

-- 5. Tạo PROCEDURE lấy tất cả thông tin của 1 khách hàng dựa trên mã số khách hàng.[3 điểm]
DELIMITER //
create procedure PROC_GETCUSTOMERBYCUSTOMERID(
IN customer_id_in varchar(4))
begin
select * from CUSTOMERS WHERE customer_id=customer_id_in;
end;
// 
-- call PROC_GETCUSTOMERBYCUSTOMERID('C001');

-- 6. Tạo PROCEDURE lấy thông tin của tất cả sản phẩm. [3 điểm]
DELIMITER //
create procedure PROC_GETPRODUCTS()
begin
select * from PRODUCTS;
end;
// 

-- 7. Tạo PROCEDURE hiển thị danh sách hoá đơn dựa trên mã người dùng. [3 điểm]
DELIMITER //
create procedure PROC_GETORDERBYCUSTOMERID(IN customer_id_in varchar(4))
begin
select * from ORDERS where customer_id=customer_id_in;
end;
// 

-- 8. Tạo PROCEDURE tạo mới một đơn hàng với các tham số là mã khách hàng, tổng tiền và ngày tạo hoá đơn, và hiển thị ra mã hoá đơn vừa tạo. [3 điểm]
DELIMITER //
create procedure PROC_ADDORDER( INOUT order_id_io varchar(4),IN customer_id_in varchar(4), IN total_amount_in double, IN order_date_in date)
begin
declare last_order_id varchar(4);
DECLARE number INT;
DECLARE increased_number INT;
SET last_order_id=(select order_id from ORDERS ORDER BY order_id DESC LIMIT 1);
SET number=CAST(substring(last_order_id,2,3) AS UNSIGNED);
SET increased_number=number+1;
SET order_id_io=concat('H',LPAD(increased_number, 3, '0'));

INSERT INTO ORDERS(order_id,customer_id,total_amount,order_date)VALUES(order_id_io,customer_id_in,total_amount_in,order_date_in);

select order_id_io;
end;
// 
-- drop procedure PROC_ADDORDER;
-- call PROC_ADDORDER(@order_id_io,'C001',28999999,'2023-02-22');
-- select @order_id_io;


/* -- cach 2
DELIMITER //
create procedure PROC_ADDNEWORDER( IN order_id_io varchar(4),IN customer_id_in varchar(4), IN total_amount_in double, IN order_date_in date)
begin
INSERT INTO ORDERS(order_id,customer_id,total_amount,order_date)VALUES(order_id_io,customer_id_in,total_amount_in,order_date_in);
SELECT order_id from ORDERS where order_id=order_id_io;
end;
// 
-- call PROC_ADDNEWORDER('H011','C005',28999999,'2023-11-23'); */


-- 9. Tạo PROCEDURE thống kê số lượng bán ra của mỗi sản phẩm trong khoảng thời gian cụ thể với 2 tham số là ngày bắt đầu và ngày kết thúc. [3 điểm]
DELIMITER //
create procedure PROC_COUNTBOUGHTPRODUCTS( IN start_date date, IN close_date date)
begin
select p.name as 'tên sản phẩm',p.price as giá, sum(od.quantity) as 'tổng số lượng đã bán ra' from PRODUCTS p
JOIN ORDERS_DETAILS od ON p.product_id=od.product_id 
JOIN ORDERS o ON o.order_id=od.order_id 
WHERE o.order_date>=start_date and o.order_date<=close_date 
GROUP BY p.product_id;
end;
// 
-- drop procedure PROC_COUNTBOUGHTPRODUCTS;
-- call PROC_COUNTBOUGHTPRODUCTS('2023-01-01','2023-11-23');

-- 10. Tạo PROCEDURE thống kê số lượng của mỗi sản phẩm được bán ra theo thứ tự giảm dần của tháng đó với tham số vào là tháng và năm cần thống kê. [3 điểm]
DELIMITER //
create procedure PROC_COUNTBOUGHTPRODUCTSINMONTH( IN month_in int, IN year_in int)
begin
select p.name as 'tên sản phẩm',p.price as giá, sum(od.quantity) as 'tổng số lượng đã bán ra' from PRODUCTS p
JOIN ORDERS_DETAILS od ON p.product_id=od.product_id 
JOIN ORDERS o ON o.order_id=od.order_id 
WHERE month(o.order_date)=month_in and year(o.order_date)=year_in 
GROUP BY p.product_id ORDER BY sum(od.quantity) DESC;
end;
// 
call PROC_COUNTBOUGHTPRODUCTSINMONTH(3,2023);