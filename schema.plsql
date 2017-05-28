(SYS)
connect / as sysdba
create user hr identified by 123456;
grant create create session to hr;
grant create to hr;
(HR)
connect hr/123456;

create table ChiNhanh (
	maCN varchar2(50) NOT NULL,
	tenCN varchar2(50),
	truongChiNhanh varchar2(50) ,
	CONSTRAINT chinhanh_pk PRIMARY KEY (maCN)
)
/
create table NhanVien (
	manv varchar2(50) NOT NULL,
	hoTen varchar2(50) ,
	diaChi varchar2(50) ,
	dienThoai varchar2(50) ,
	email varchar2(50) ,
	maPhog varchar2(50) ,
	chiNhanh varchar2(50),
	luong varchar2(128),
	hashkey varchar2(128),
	CONSTRAINT nhanvien_pk PRIMARY KEY (manv)
)
/
create table  PhanCong (
	manv varchar2(50) NOT NULL,
	duAN varchar2(50),
	vaiTro varchar2(50),
	phuCap number(10),
	chuKy varchar2(512),
	CONSTRAINT phancong_pk PRIMARY KEY (manv, duAN)
)
/
create table ChiTieu (
	maChiTieu varchar2(50) NOT NULL,
	tenChiTieu varchar2(50),
	soTien varchar2(512),
	duAN varchar2(50),
	hashedPrivKey varchar2(512),
	CONSTRAINT chitieu_pk PRIMARY KEY (maChiTieu)
)
/
create table PhongBan (
	maPhong varchar2(50) NOT NULL,
	tenPhong varchar2(50),
	TruongPhong varchar2(50),
	ngayNhanChuc DATE,
	soNhanVien number(5),
	chiNhanh varchar2(50),
	CONSTRAINT phongban_pk PRIMARY KEY (maPhong)
)
/
create table DuAn(
	maDA varchar2(50) NOT NULL ,
	tenDA varchar2(50),
	kinhphi number(10),
	phongChuTri varchar2(50),
	TruongDA varchar2(50),
	CONSTRAINT duan_pk PRIMARY KEY (maDA)
)
/
--------------------------------------------------------------------------------

ALTER TABLE ChiNhanh ADD CONSTRAINT fk_chinhanh_nhanvien FOREIGN KEY (truongChiNhanh) REFERENCES NhanVien (manv);

ALTER TABLE NhanVien ADD CONSTRAINT fk_nhanvien_phongban FOREIGN KEY (maPhog) REFERENCES PhongBan(maPhong);
ALTER TABLE NhanVien ADD CONSTRAINT fk_nhanvien_chinhanh FOREIGN KEY (chiNhanh) REFERENCES ChiNhanh(maCN);

ALTER TABLE PhanCong ADD CONSTRAINT fk_phancong_nhanvien FOREIGN KEY (manv) REFERENCES NhanVien(manv);
ALTER TABLE PhanCong ADD CONSTRAINT fk_phancong_duan FOREIGN KEY (duAN) REFERENCES DuAn(maDA);

ALTER TABLE ChiTieu ADD CONSTRAINT fk_chitieu_duan FOREIGN KEY (duAN) REFERENCES DuAn(maDA);

ALTER TABLE PhongBan ADD CONSTRAINT fk_phongban_chinhanh FOREIGN KEY (chiNhanh) REFERENCES ChiNhanh(maCN);

ALTER TABLE DuAn ADD CONSTRAINT fk_duan_phongban FOREIGN KEY (phongChuTri) REFERENCES PhongBan(maPhong);
ALTER TABLE DuAn ADD CONSTRAINT fk_duan_nhanvien FOREIGN KEY (TruongDA) REFERENCES NhanVien(manv);


-----------------------------------------Insert---------------------------------------
insert into ChiNhanh (maCN, tenCN, truongChiNhanh) values('CN001', 'The gioi hoan my', NULL);
insert into ChiNhanh (maCN, tenCN, truongChiNhanh) values('CN002', 'The gioi mo', NULL);
insert into ChiNhanh (maCN, tenCN, truongChiNhanh) values('CN003', 'The gioi than quen', NULL);
insert into ChiNhanh (maCN, tenCN, truongChiNhanh) values('CN004', 'Vo than chi quyen', NULL);
insert into ChiNhanh (maCN, tenCN, truongChiNhanh) values('CN005', 'Dien loi am thu', NULL);

insert into NhanVien (manv ,hoTen ,diaChi ,dienThoai ,email ,maPhog, chiNhanh ,luong) values('1412193', 'Nguyen Thai Hoc', '30/24r', '0839160512', 'thaihocmap123@gmai.com', NULL,'CN001', 10000);
insert into NhanVien (manv ,hoTen ,diaChi ,dienThoai ,email ,maPhog, chiNhanh ,luong) values('1412257', 'Vu Dang Khoa', 'Binh Dinh','09834865767','vudangkhoa@gmai.com', NULL, 'CN001', 22222);
insert into NhanVien (manv ,hoTen ,diaChi ,dienThoai ,email ,maPhog, chiNhanh ,luong) values('1412258', 'Bui Duy Khoi', 'Quang Ngai', '0908451355','duykhoibui@gmai.com', NULL, 'CN002', 23231);
insert into NhanVien (manv ,hoTen ,diaChi ,dienThoai ,email ,maPhog, chiNhanh ,luong) values('1412176', 'Hoang Kha Hoa', 'Long An', '0684687','hoangkhahoa@gmai.com', NULL, 'CN002', 89672);
insert into NhanVien (manv ,hoTen ,diaChi ,dienThoai ,email ,maPhog, chiNhanh ,luong) values('1412195', 'Doan Van Huy', 'Thai Binh', '012348878','vandoanhuy@gmai.com', NULL, 'CN003', 433434);
insert into NhanVien (manv ,hoTen ,diaChi ,dienThoai ,email ,maPhog, chiNhanh ,luong) values('1412186', 'Tran Thien Hoang', 'Dong Nai', '0234354','thienhoang@gmai.com', NULL, 'CN003', 324354);
insert into NhanVien (manv ,hoTen ,diaChi ,dienThoai ,email ,maPhog, chiNhanh ,luong) values('1412192', 'Thien Minh Quan', 'Dak Nong', '08978324','minhquan@gmai.com', NULL, 'CN003', 21983);
insert into NhanVien (manv ,hoTen ,diaChi ,dienThoai ,email ,maPhog, chiNhanh ,luong) values('1412173', 'Tran Thi Thanh Hai', 'Phan Thiet', '09323723','tranthanhhai@gmai.com', NULL, 'CN004', 67612);
insert into NhanVien (manv ,hoTen ,diaChi ,dienThoai ,email ,maPhog, chiNhanh ,luong) values('1412232', 'Nguyen Phan Anh', 'Phan Thiet', '93824098','anhquan@gmai.com', NULL, 'CN005', 912302);
insert into NhanVien (manv ,hoTen ,diaChi ,dienThoai ,email ,maPhog, chiNhanh ,luong) values('1412245', 'Tran Thi Loan', 'Dak Lak', '09213213','loantran@gmai.com',NULL, 'CN004', 21362);
insert into NhanVien (manv ,hoTen ,diaChi ,dienThoai ,email ,maPhog, chiNhanh ,luong) values('1412200', 'Nguyen Anh Tuyet', 'Lam Dong', '0921321342','darkknight92@gmail.com',NULL, 'CN001', 21362);
insert into NhanVien (manv ,hoTen ,diaChi ,dienThoai ,email ,maPhog, chiNhanh ,luong) values('1412201', 'Lai Hua Leo', 'Ha Tinh', '0921321361','leolai@gmail.com',NULL, 'CN001', 21362);
insert into NhanVien (manv ,hoTen ,diaChi ,dienThoai ,email ,maPhog, chiNhanh ,luong) values('1412202', 'Tran Van Teo', 'Binh Thuan', '0921321357','teocute@gmail.com',NULL, 'CN001', 21362);
insert into NhanVien (manv ,hoTen ,diaChi ,dienThoai ,email ,maPhog, chiNhanh ,luong) values('1412203', 'Vo Van Song Toan', 'Quang Ngai', '0921321341','fatgnome@gmail.com',NULL, 'CN002', 21362);
insert into NhanVien (manv ,hoTen ,diaChi ,dienThoai ,email ,maPhog, chiNhanh ,luong) values('1412204', 'Pham Quang Gioi', 'Kon Tum', '0921321318','johnygioi@gmail.com',NULL, 'CN003', 21362);
insert into NhanVien (manv ,hoTen ,diaChi ,dienThoai ,email ,maPhog, chiNhanh ,luong) values('1412205', 'Pham Van Bang', 'Kon Tum', '0921321300','johnygioi@gmail.com',NULL, 'CN001', 21362);
insert into NhanVien (manv ,hoTen ,diaChi ,dienThoai ,email ,maPhog, chiNhanh ,luong) values('1412206', 'Nguyen Vo Tran', 'Da Nang', '0921321301','giacatluong123@gmail.com',NULL, 'CN001', 21362);
insert into NhanVien (manv ,hoTen ,diaChi ,dienThoai ,email ,maPhog, chiNhanh ,luong) values('1412207', 'Su Nghin Hanh', 'Lang Son', '0921321302','dannyvid@gmail.com',NULL, 'CN001', 21362);
insert into NhanVien (manv ,hoTen ,diaChi ,dienThoai ,email ,maPhog, chiNhanh ,luong) values('1412208', 'An Duong Hoang Tu', 'Cao Bang', '0921321303','froutsenco@gmail.com',NULL, 'CN001', 21362);
insert into NhanVien (manv ,hoTen ,diaChi ,dienThoai ,email ,maPhog, chiNhanh ,luong) values('1412209', 'Luong Khac Quang', 'Dong Thap', '0921321304','fulinano@gmail.com',NULL, 'CN001', 21362);
insert into NhanVien (manv ,hoTen ,diaChi ,dienThoai ,email ,maPhog, chiNhanh ,luong) values('1412210', 'Luong Bich Hang', 'Cao Bang', '0921321305','beriona@gmail.com',NULL, 'CN001', 21362);
insert into NhanVien (manv ,hoTen ,diaChi ,dienThoai ,email ,maPhog, chiNhanh ,luong) values('1412211', 'Vu Khoa Dang', 'Binh Duong', '0921321306','melanie@gmail.com',NULL, 'CN001', 21362);
insert into NhanVien (manv ,hoTen ,diaChi ,dienThoai ,email ,maPhog, chiNhanh ,luong) values('1412212', 'Vo Quan Tu', 'Long An', '0921321307','blackdox@gmail.com',NULL, 'CN003', 21362);
insert into NhanVien (manv ,hoTen ,diaChi ,dienThoai ,email ,maPhog, chiNhanh ,luong) values('1412213', 'Nguyen Manh Hung', 'Binh Duong', '0921321308','maanee@gmail.com',NULL, 'CN001', 21362);

insert into PhongBan (maPhong , tenPhong ,TruongPhong ,ngayNhanChuc, soNhanVien,chiNhanh) values('PB001', 'Nhan_Su', '1412200', TO_DATE('17/12/2015', 'DD/MM/YYYY'), 10, 'CN001');
insert into PhongBan (maPhong , tenPhong ,TruongPhong ,ngayNhanChuc, soNhanVien,chiNhanh) values('PB002', 'Ke_Toan', '1412201',TO_DATE('2/4/2017', 'DD/MM/YYYY'), 12, 'CN001');
insert into PhongBan (maPhong , tenPhong ,TruongPhong ,ngayNhanChuc, soNhanVien,chiNhanh) values('PB003', 'Ke_Hoach', '1412202', TO_DATE('1/3/2017', 'DD/MM/YYYY') , 5, 'CN001');
insert into PhongBan (maPhong , tenPhong ,TruongPhong ,ngayNhanChuc, soNhanVien,chiNhanh) values('PB004', 'Nhan_Su', '1412173', NULL, 10, 'CN003');
insert into PhongBan (maPhong , tenPhong ,TruongPhong ,ngayNhanChuc, soNhanVien,chiNhanh) values('PB005', 'Ke_Toan', '1412203', NULL, 10, 'CN002');
insert into PhongBan (maPhong , tenPhong ,TruongPhong ,ngayNhanChuc, soNhanVien,chiNhanh) values('PB006', 'Ke_Hoach', '1412204', NULL, 10, 'CN003');

update NhanVien set maPhog = 'PB001' where manv = '1412193' or manv = '1412257' or manv='1412200' or manv='1412205' or manv='1412210';
update NhanVien set maPhog = 'PB002' where manv = '1412258' or manv = '1412176' or manv='1412201' or manv='1412206' or manv='1412211';
update NhanVien set maPhog = 'PB003' where manv = '1412195' or manv = '1412186' or manv = '1412192' or manv='1412202' or manv='1412207' or manv='1412213';
update NhanVien set maPhog = 'PB004' where manv = '1412173' or manv = '1412208' or manv='1412212';
update NhanVien set maPhog = 'PB005' where manv = '1412232' or manv = '1412203' or manv='1412209';
update NhanVien set maPhog = 'PB006' where manv = '1412245' or manv = '1412204';

insert into DuAn (maDA,tenDA ,kinhphi ,phongChuTri,TruongDA ) values('DA001', 'Hello world for Oracle', 201221, 'PB001', '1412205');
insert into DuAn (maDA,tenDA ,kinhphi ,phongChuTri,TruongDA ) values('DA002', 'Xet tinh bao mat', 123213, 'PB002', '1412206');
insert into DuAn (maDA,tenDA ,kinhphi ,phongChuTri,TruongDA ) values('DA003', 'hadoop with PSQL', 232332, 'PB003', '1412207');
insert into DuAn (maDA,tenDA ,kinhphi ,phongChuTri,TruongDA ) values('DA004', 'Checking for website', 46565, 'PB004', '1412208');
insert into DuAn (maDA,tenDA ,kinhphi ,phongChuTri,TruongDA ) values('DA005', 'Robotor and Create', 8965, 'PB005', '1412209');
insert into DuAn (maDA,tenDA ,kinhphi ,phongChuTri,TruongDA ) values('DA006', 'Tao Fanpage', 4854, 'PB005', '1412209');
insert into DuAn (maDA,tenDA ,kinhphi ,phongChuTri,TruongDA ) values('DA007', 'Tuyen nhan su quy I 2017', 3420, 'PB001', '1412205');
insert into DuAn (maDA,tenDA ,kinhphi ,phongChuTri,TruongDA ) values('DA008', 'Team building thang 3/2017', 5555, 'PB002', '1412207');
insert into DuAn (maDA,tenDA ,kinhphi ,phongChuTri,TruongDA ) values('DA009', 'He thong nhan dang khuon mat', 1578, 'PB003', '1412208');
insert into DuAn (maDA,tenDA ,kinhphi ,phongChuTri,TruongDA ) values('DA010', 'Thong ke vat lieu', 2000, 'PB004', '1412208');
insert into DuAn (maDA,tenDA ,kinhphi ,phongChuTri,TruongDA ) values('DA011', 'Ke hoach hop tac voi Formosa', 1540, 'PB001', '1412209');
insert into DuAn (maDA,tenDA ,kinhphi ,phongChuTri,TruongDA ) values('DA012', 'Keu goi von nuoc ngoai', 1490, 'PB002', '1412205');
insert into DuAn (maDA,tenDA ,kinhphi ,phongChuTri,TruongDA ) values('DA013', 'Ap dung he thong tu dong hoa', 9001, 'PB003', '1412206');

insert into ChiTieu (maChiTieu ,tenChiTieu ,soTien ,duAN) values('CT001', 'Coming to the best', 2131, 'DA001');
insert into ChiTieu (maChiTieu ,tenChiTieu ,soTien ,duAN) values('CT002', 'Road into bounus', 5654, 'DA002');
insert into ChiTieu (maChiTieu ,tenChiTieu ,soTien ,duAN) values('CT003', 'Never land', 6765, 'DA003');
insert into ChiTieu (maChiTieu ,tenChiTieu ,soTien ,duAN) values('CT004', 'Check point in the Code', 1254, 'DA004');
insert into ChiTieu (maChiTieu ,tenChiTieu ,soTien ,duAN) values('CT005', 'Never hope back', 8987, 'DA005');

insert into PhanCong (manv , duAN, vaiTro ,phuCap) values('1412193', 'DA001', 'Create Controll', 1234);
insert into PhanCong (manv , duAN, vaiTro ,phuCap) values('1412257', 'DA001', 'Desgin and analyisc web', 4353);
insert into PhanCong (manv , duAN, vaiTro ,phuCap) values('1412258', 'DA001', 'Create remote controll', 6576);
insert into PhanCong (manv , duAN, vaiTro ,phuCap) values('1412176', 'DA001', 'Config database and to connect DB', 8798);
insert into PhanCong (manv , duAN, vaiTro ,phuCap) values('1412176', 'DA002', 'Hostting server', 6576);
insert into PhanCong (manv , duAN, vaiTro ,phuCap) values('1412195', 'DA002', 'Desgin structer data', 1223);
insert into PhanCong (manv , duAN, vaiTro ,phuCap) values('1412195', 'DA003', 'Manager Developer', 234);
insert into PhanCong (manv , duAN, vaiTro ,phuCap) values('1412193', 'DA003', 'connect to localhost from win', 546);
insert into PhanCong (manv , duAN, vaiTro ,phuCap) values('1412173', 'DA004', 'Make your connect to app', 5654);
insert into PhanCong (manv , duAN, vaiTro ,phuCap) values('1412258', 'DA004', 'Create server', 9912);
insert into PhanCong (manv , duAN, vaiTro ,phuCap) values('1412232', 'DA005', 'Set up Routting',9213);
insert into PhanCong (manv , duAN, vaiTro ,phuCap) values('1412195', 'DA005', 'Desgin MVC Template', 2132);
insert into PhanCong (manv , duAN, vaiTro ,phuCap) values('1412258', 'DA005', 'Create layouts', 24543);
insert into PhanCong (manv , duAN, vaiTro ,phuCap) values('1412257', 'DA005', 'Create particals', 21323);

update ChiNhanh set truongChiNhanh = '1412193' where maCN = 'CN001';
update ChiNhanh set truongChiNhanh = '1412176' where maCN = 'CN002';
update ChiNhanh set truongChiNhanh = '1412195' where maCN = 'CN003';
update ChiNhanh set truongChiNhanh = '1412245' where maCN = 'CN004';
update ChiNhanh set truongChiNhanh = '1412232' where maCN = 'CN005';
---------------------------------------------------------------------------------
