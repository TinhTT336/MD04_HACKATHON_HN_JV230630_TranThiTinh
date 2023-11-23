create database QUANLYDIEMTHI;
use QUANLYDIEMTHI;

create table STUDENT(
student_id varchar(4) not null primary key,
student_name varchar(100)not null,
birthday date not null,
gender bit(1)not null,
address text not null,
phone_number varchar(45) unique
);

create table SUBJECT(
subject_id varchar(4) not null primary key,
subject_name varchar(45) not null,
priority int(11) not null
);

create table MARK(
subject_id varchar(4) not null,
foreign key(subject_id) references SUBJECT(subject_id),
student_id varchar(4) not null,
foreign key(student_id) references STUDENT(student_id),
point double not null,
primary key(subject_id,student_id)
);

-- Bài 2: Thêm , sửa , xoá dữ liệu
INSERT INTO STUDENT(student_id,student_name,birthday,gender,address,phone_number)VALUES
('S001','Nguyễn Thế Anh','1999-01-11',1,'Hà Nội','984678082'),
('S002','Đặng Bảo Trâm','1998-12-22',0,'Lao Cai','904982654'),
('S003','Trần Hà Phương','2000-05-05',0,'Nghệ An','947645363'),
('S004','Đỗ Tiến Mạnh','1999-03-26',1,'Hà Nội','983665353'),
('S005','Phạm Duy Nhất','1998-04-10',1,'Tuyên Quang','987242678'),
('S006','Mai Văn Thái','2002-06-22',1,'Nam Định','982654268'),
('S007','Giang Gia Hân','1996-11-10',0,'Phú Thọ','982364753'),
('S008','Nguyễn Ngọc Bảo My','1999-01-22',0,'Hà Nam','927867453'),
('S009','Nguyễn Tiến Đạt','1998-08-07',1,'Tuyên Quang','989275673'),
('S010','Nguyễn Thiều Quang','2000-09-18',1,'Hà Nội','984378291');

INSERT INTO SUBJECT(subject_id,subject_name,priority)VALUES
('MH01','Toán',2),
('MH02','Vật Lý',2),
('MH03','Hoá học',1),
('MH04','Ngữ Văn',1),
('MH05','Tiếng Anh',2);

INSERT INTO MARK(student_id,subject_id,point)VALUES
('S001','MH01',8.5),
('S001','MH02',7),
('S001','MH03',9),
('S001','MH04',9),
('S001','MH05',5),
('S002','MH01',9),
('S002','MH02',8),
('S002','MH03',6.5),
('S002','MH04',8),
('S002','MH05',6),
('S003','MH01',7.5),
('S003','MH02',6.5),
('S003','MH03',8),
('S003','MH04',7),
('S003','MH05',7),
('S004','MH01',6),
('S004','MH02',7),
('S004','MH03',5),
('S004','MH04',6.5),
('S004','MH05',8),
('S005','MH01',5.5),
('S005','MH02',8),
('S005','MH03',7.5),
('S005','MH04',8.5),
('S005','MH05',9),
('S006','MH01',8),
('S006','MH02',10),
('S006','MH03',9),
('S006','MH04',7.5),
('S006','MH05',6.5),
('S007','MH01',9.5),
('S007','MH02',9),
('S007','MH03',6),
('S007','MH04',9),
('S007','MH05',4),
('S008','MH01',10),
('S008','MH02',8.5),
('S008','MH03',8.5),
('S008','MH04',6),
('S008','MH05',9.5),
('S009','MH01',7.5),
('S009','MH02',7),
('S009','MH03',9),
('S009','MH04',5),
('S009','MH05',10),
('S010','MH01',6.5),
('S010','MH02',8),
('S010','MH03',5.5),
('S010','MH04',4),
('S010','MH05',7);

-- Cập nhật dữ liệu
-- - Sửa tên và hệ số môn học có mã `MH05` thành “NgoạiNgữ” và hệ số là 1.
UPDATE SUBJECT SET subject_name='Ngoại Ngữ',priority=1 WHERE subject_id='MH05';

-- Cập nhật lại điểm của học sinh có mã `S009` thành (MH01 : 8.5, MH02 : 7,MH03 : 5.5, MH04 : 6,MH05 : 9).
UPDATE MARK SET point=8.5 WHERE student_id='S009' and subject_id='MH01';
UPDATE MARK SET point=7 WHERE student_id='S009' and subject_id='MH02';
UPDATE MARK SET point=5.5 WHERE student_id='S009' and subject_id='MH03';
UPDATE MARK SET point=6 WHERE student_id='S009' and subject_id='MH04';
UPDATE MARK SET point=9 WHERE student_id='S009' and subject_id='MH05';

-- Xoá toàn bộ thông tin của học sinh có mã `S010` bao gồm điểm thi ở bảng MARK và thông tin học sinh này ở bảng STUDENT.
DELETE FROM MARK WHERE student_id='S010';
DELETE FROM STUDENT WHERE student_id='S010';

-- Bài 3: Truy vấn dữ liệu
-- 1. Lấy ra tất cả thông tin của sinh viên trong bảng Student . [4 điểm]
SELECT * FROM STUDENT;

-- 2. Hiển thị tên và mã môn học của những môn có hệ số bằng 1. [4 điểm]
SELECT subject_id as 'Mã môn học',subject_name as 'Tên môn học' from SUBJECT WHERE priority=1;

-- 3. Hiển thị thông tin học sinh bào gồm: mã học sinh, tên học sinh, tuổi (bằng năm hiện tại tr năm sinh) , giới tính (hiển thị nam hoặc nữ) và quê quán của tất cả học sinh. [4 điểm]
SELECT student_id as 'Mã học sinh',student_name as'Tên học sinh',(Year(current_date())-Year(birthday)) as Tuổi, (if(gender=1,'Nam','Nữ')) as 'Giới tính', address as 'Quê quán' from STUDENT;

-- 4. Hiển thị thông tin bao gồm: tên học sinh, tên môn học , điểm thi của tất cả học sinh của môn Toán và sắp xếp theo điểm giảm dần. [4 điểm]
SELECT s.student_name as'Tên học sinh',sj.subject_name as 'Tên môn học', m.point as 'Điểm thi môn Toán' from STUDENT s 
JOIN MARK m ON s.student_id=m.student_id
JOIN SUBJECT sj ON sj.subject_id=m.subject_id
WHERE subject_name='Toán'
ORDER BY point DESC;

-- 5. Thống kê số lượng học sinh theo giới tính ở trong bảng (Gồm 2 cột: giới tính và số lượng).
SELECT (if(gender=1,'Nam','Nữ')) as 'Giới tính',
 count(
 CASE WHEN gender=1 Then 1 WHEN gender=0 THEN 1 END) as 'Số lượng'  from STUDENT GROUP BY gender;

-- 6. Tính tổng điểm và điểm trung bình của các môn học theo từng học sinh (yêu cầu sử dụng hàm để tính toán) , bảng gồm mã học sinh, tên hoc sinh, tổng điểm và điểm trung bình. [5 điểm]
SELECT s.student_id as 'Mã học sinh', s.student_name as 'Tên học sinh', SUM(m.point) as 'Tổng điểm',AVG(m.point) as 'Điểm trung bình'
FROM STUDENT s
JOIN MARK m ON s.student_id=m.student_id
GROUP BY s.student_id;

-- Bài 4: Tạo View, Index, Procedure
-- 1. Tạo VIEW có tên STUDENT_VIEW lấy thông tin sinh viên bao gồm : mã học sinh, tên học sinh, giới tính , quê quán . [3 điểm]
CREATE VIEW STUDENT_VIEW AS
SELECT student_id as 'Mã học sinh',student_name as'Tên học sinh', (if(gender=1,'Nam','Nữ')) as 'Giới tính', address as 'Quê quán' from STUDENT;

-- 2. Tạo VIEW có tên AVERAGE_MARK_VIEW lấy thông tin gồm:mã học sinh, tên học sinh, điểm trung bình các môn học . [3 điểm]
CREATE VIEW AVERAGE_MARK_VIEW AS
SELECT s.student_id as 'Mã học sinh',s.student_name as'Tên học sinh', AVG(m.point) as 'điểm trung bình các môn học' from STUDENT s
JOIN MARK m ON s.student_id=m.student_id
GROUP BY s.student_id;

-- 3. Đánh Index cho trường `phoneNumber` của bảng STUDENT.
CREATE INDEX id_phone ON STUDENT(phone_number);
-- ALTER TABLE STUDENT ADD UNIQUE INDEX index_phone (phone_number);

-- 4. Tạo các PROCEDURE sau:
-- Tạo PROC_INSERTSTUDENT dùng để thêm mới 1 học sinh bao gồm tất cả thông tin học sinh đó. [4 điểm]
DELIMITER //
create procedure PROC_INSERTSTUDENT(
IN student_id_in varchar(4), IN student_name_in date,IN birthday_in date, IN gender_in bit(1),IN address_in text, IN phone_number_in varchar(45))
begin
INSERT INTO STUDENT(student_id,student_name,birthday,gender,address,phone_number)VALUES(student_id_in,student_name_in,birthday_in,gender_in,address_in,phone_number_in);
end;
// 

-- Tạo PROC_UPDATESUBJECT dùng để cập nhật tên môn học theo mã môn học.
DELIMITER //
create procedure PROC_UPDATESUBJECT(
IN subject_id_in varchar(4),IN subject_name_in varchar(45))
begin
UPDATE SUBJECT SET subject_name=subject_name_in WHERE subject_id=subject_id_in;
end;
// 
-- call PROC_UPDATESUBJECT('MH05','Ngoại Ngữ');

-- Tạo PROC_DELETEMARK dùng để xoá toàn bộ điểm các môn học theo mã học sinh và trả về số bản ghi đã xóa. [4 điểm]
DELIMITER //
create procedure PROC_DELETEMARK(
IN student_id_in varchar(4), OUT count INT)
begin
SET count = (select count(*) FROM MARK WHERE student_id=student_id_in);
DELETE FROM MARK WHERE student_id=student_id_in;
end;
// 
 /*call PROC_DELETEMARK('S001',@count);
SELECT @count;*/