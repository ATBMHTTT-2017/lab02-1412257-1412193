## Câu 1: Tạo tài khoản cho các nhân viên trong bảng nhân viên

### Tạo các user ứng với mã nhân viên, trong đó:

>`User 1412239 là Giám Đốc`

>`Những User :  1412193, 1412176, 1412195, 1412245, 1412232, ... (có rất nhiều Trưởng chi nhánh nhưng tụi em liệt kê 1 số ra) là các Trưởng chi nhánh`

>`Những User :  1412200 , 1412201, 1412202, 1412173, 1412203, 1412204, ... là các Trưởng phòng`

>`Những User :  1412205, 1412206, 1412207, 1412208, 1412209, ... là quản lý dự án`

>`Những User : 1412186, 1412192, 1412257, 1412258, .... là các Nhân viên bình thường`

+ #### Ví dụ từ mã nguồn:

>`create user "1412193" identified by 123456;`

## Câu 2: Tạo role cho các vị trí phù hợp của công ty

### Tạo ra 5 role gồm: GiamDoc, truongphong, truongchinhanh, truongduan, nhanvien

+ #### Ví dụ từ mã nguồn:

>`create role giamdoc;`

>`create role truongphong;`

>`create role truongchinhanh;`

>`create role truongduan;`

>`create role nhanvien;`

## Security 1: Giải pháp mã hóa thông tin lương để chỉ nhân viên được phép xem lương của mình 

#### giải pháp : Cách làm của nhóm tụi em là ta sẽ làm như sau : ta tạo 3 hàm 

+ ##### Lưu ý : thầy có chỉ các gói mà oracle có sẵn để mã hóa đối xứng, nhưng nó có 1 vấn đề về hàm giải mã như sau em xin trình bày tại đây và đồng thơi nêu ra cách giải quyết của nhóm em đối với vấn đề này : dbms_crypto.decrypt (đầu vào , cách băm hay cách giải, key muốn giải). Nhưng ở chỗ -key muốn giải- nó chỉ hoạt động khi Key chúng ta nhập là đúng và hàm này sẽ bị crash nếu -key sai- điều này dẫn tới nó không chạy được là 1 câu select trên bảng nhân viên vì thế các giải quyết nhóm em là

##### cách giải quyết vấn đề trên : chúng em thêm 1 trường để lưu key nhưng key này đã được mã hóa bằng Hash (trưởng này sẽ chứa key được băm và khi check đúng sai thì cho phép qua còn không thì ta trả về lương chưa mã hóa)

+ #### Ví dụ từ mã nguồn (thêm trường Hashkey trong bảng nhân viên)

+ #### Vú dụ từ mã nguồn (kiểm tra Hashkey xem đúng hay sai và tiếp tục)

##### hàm 1 : mã hóa lương hiện tại có trong bảng thành cách dãy số nhằm che dấu với các nhân viên khác . Mã hóa theo các key mà nhân viên cung cấp cho ta mỗi nhân viên trong bảng sẽ có 1 key riêng để quản lý trưởng lương của mình trong bảng nhân viên (sử dụng dbms_crypto.encrypt : để mã hóa lương theo key của mỗi nhân viên) - có 2 thông số (lương hiện tại, key)


+ #### Ví dụ từ mã nguồn:

##### hàm 2 : hàm giải mã (sử dụng dbms_crypto.decrypt) biến truyền vào (Data, hashkey, <key của người dùng muón giải>)

+ #### Ví dụ từ mã nguồn:

##### hàm 3 : hàm mã hóa key của nhân viên thành 1 chuỗi Hash (sử dụng dbms_crypto.Hash) biến truyền vào (<Key của ta>)

+ #### Ví dụ từ mã nguồn:

#### Bước tiếp theo : cập nhật các trưởng lương hiện tại bằng hàm mã hóa (hàm 1 : hàm mã hóa)

+ #### Ví dụ từ mã nguồn:

#### Bước tiếp theo : cập nhật trưởng Hashkey cho bảng nhân viên tương ứng với mỗi nhân viên (hàm 3 : hàm băm )

+ #### Ví dụ từ mã nguồn:

#### Bước tiếp theo : Để có thể thao tác tốt hơn với hàm giải mã . em tạo 1 SP dùng để giải mã (hàm 2 : giải mã) 

+ #### Ví dụ từ mã nguồn:

## Security 2:

+ #### Ví dụ từ mã nguồn:

## Security 3: Chỉ trưởng dự án được phép xem và cập nhật thông tin chi tiêu của dự án của mình 

#### Câu này chúng em sử dụng VPD để xây dựng nó 

#### Hướng giải quyết và làm của nhóm em : xây dựng 1 function dùng để chech xem có phải là trưởng dự án hay không ? nếu có thì trả về các dự án của người đó bằng câu lệnh exists và nếu không phải thì trả về tất cả (trưởng phòng, trưởng chi nhánh)

+ #### Ví dụ từ mã nguồn:

#### Tạo function xong thì kế tiếp ta add policy cho table đó 

+ #### Ví dụ từ mã nguồn:


## Security 4:

+ #### Ví dụ từ mã nguồn:



