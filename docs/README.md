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

- Giải pháp : Cách làm của nhóm tụi em là ta sẽ làm như sau : ta tạo 3 hàm 

+ ##### Lưu ý : thầy có chỉ các gói mà oracle có sẵn để mã hóa đối xứng, nhưng nó có 1 vấn đề về hàm giải mã như sau em xin trình bày tại đây và đồng thơi nêu ra cách giải quyết của nhóm em đối với vấn đề này : dbms_crypto.decrypt (đầu vào , cách băm hay cách giải, key muốn giải). Nhưng ở chỗ -key muốn giải- nó chỉ hoạt động khi Key chúng ta nhập là đúng và hàm này sẽ bị crash nếu -key sai- điều này dẫn tới nó không chạy được là 1 câu select trên bảng nhân viên vì thế các giải quyết nhóm em là

- Cách giải quyết vấn đề trên : chúng em thêm 1 trường để lưu key nhưng key này đã được mã hóa bằng Hash (trưởng này sẽ chứa key được băm và khi check đúng sai thì cho phép qua còn không thì ta trả về lương chưa mã hóa)

#### Ví dụ từ mã nguồn (thêm trường Hashkey trong bảng nhân viên)

#### Ví dụ từ mã nguồn (kiểm tra Hashkey xem đúng hay sai và tiếp tục)

##### Hàm 1 : mã hóa lương hiện tại có trong bảng thành cách dãy số nhằm che dấu với các nhân viên khác . Mã hóa theo các key mà nhân viên cung cấp cho ta mỗi nhân viên trong bảng sẽ có 1 key riêng để quản lý trưởng lương của mình trong bảng nhân viên (sử dụng dbms_crypto.encrypt : để mã hóa lương theo key của mỗi nhân viên) - có 2 thông số (lương hiện tại, key)


#### Ví dụ từ mã nguồn:

##### Hàm 2 : hàm giải mã (sử dụng dbms_crypto.decrypt) biến truyền vào (Data, hashkey, <key của người dùng muón giải>)

#### Ví dụ từ mã nguồn:

##### Hàm 3 : hàm mã hóa key của nhân viên thành 1 chuỗi Hash (sử dụng dbms_crypto.Hash) biến truyền vào (<Key của ta>)

#### Ví dụ từ mã nguồn:

- Bước tiếp theo : cập nhật các trưởng lương hiện tại bằng hàm mã hóa (hàm 1 : hàm mã hóa)

#### Ví dụ từ mã nguồn:

#### Bước tiếp theo : cập nhật trưởng Hashkey cho bảng nhân viên tương ứng với mỗi nhân viên (hàm 3 : hàm băm )

#### Ví dụ từ mã nguồn:

#### Bước tiếp theo : Để có thể thao tác tốt hơn với hàm giải mã . em tạo 1 SP dùng để giải mã (hàm 2 : giải mã) 

#### Ví dụ từ mã nguồn:

## Security 2: Xây dựng giải pháp để nhân viên và trưởng dự án xác định thông tin lương có đúng là do trưởng dự án thiết lập không. 
- Giải pháp: Cho phép trưởng dự án sử dụng chữ ký điện tử ngay sau khi cập nhật thông tin lương để nhân viên có thể xác nhận rằng thông tin đó không bị thay đổi từ khi ký. Để làm được điều đó, ta dùng thuật toán mã hóa bất đối xứng (ở đây là RSA), trưởng dự án giữ key private để ký, mọi nhân viên xác nhận chữ ký đó đều dùng key public tương ứng. 
- Cách sử dụng chữ ký điện tử: Trưởng dự án lấy thông tin lương đã có đem Hash, kết quả đó sẽ được đem đi mã hóa bằng key private của trưởng dự án, kết quả tiếp theo được gọi là chữ ký điện tử và được lưu lại kèm với thông tin lương. Nhân viên muốn xác nhận thông tin lương có đúng là trưởng dự án đã ký hay không sẽ hash thông tin lương được kết quả r1, sau đó sử dụng key public của mình giải mã chữ ký được kết quả r2. Nếu cả 2 kết quả đó giống nhau thì đã xác nhận được đúng là trưởng dự án đã ký ngay sau khi cập nhật thông tin lương, ngược lại nếu không giống nhau thì chứng tỏ đã bị thay đổi bởi một người nào đó không phải trưởng dự án.

- Cách làm của nhóm: Sử dụng gói hàm mã hóa ORA_RSA của Didisoft (bản dùng thử 30 ngày). Trong bài này ta dùng 2 hàm:
1. ORA_RSA.SIGN(): truyền vào thông tin cần ký, private key và lựa chọn thuật toán Hash, trả về chữ ký điện tử
#### Ví dụ từ mã nguồn:
>`signature := ORA_RSA.SIGN(message => UTL_I18N.STRING_TO_RAW(p_data, 'AL32UTF8'),
        private_key => UTL_RAW.cast_to_raw(priv_key),
        private_key_password => '',
        hash => ORA_RSA.HASH_SHA256);`
        
2. ORA_RSA.VERIFY(): truyền vào thông tin cần xác nhận, chữ ký, public key và thuật toán Hash tương ứng, trả về kết quả đúng/sai
#### Ví dụ từ mã nguồn:
>`signature_check_result := ORA_RSA.VERIFY(message => UTL_I18N.STRING_TO_RAW(p_data, 'AL32UTF8'), 
        signature => p_signature, 
        public_key => UTL_RAW.cast_to_raw(pub_key),
        hash => ORA_RSA.HASH_SHA256);`

## Security 3: Chỉ trưởng dự án được phép xem và cập nhật thông tin chi tiêu của dự án của mình 

- Câu này chúng em sử dụng VPD để xây dựng nó 

- Hướng giải quyết và làm của nhóm em : xây dựng 1 function dùng để chech xem có phải là trưởng dự án hay không ? nếu có thì trả về các dự án của người đó bằng câu lệnh exists và nếu không phải thì trả về tất cả (trưởng phòng, trưởng chi nhánh)

#### Ví dụ từ mã nguồn:

#### Tạo function xong thì kế tiếp ta add policy cho table đó 

#### Ví dụ từ mã nguồn:


## Security 4: Xây dựng giải pháp cho phép trưởng dự án mã hóa thông tin chi tiêu của dự án của mình và chỉ cho phép một số người dùng nhất định giải mã thông tin này.
- Giải pháp: Sử dụng thuật toán mã hóa bất đối xứng (RSA), Trưởng dự án giữ key public để mã hóa thông tin chi tiêu và key private để giải mã. Nếu trưởng dự án muốn cho người nào đó xem thông tin chi tiêu thì sẽ đưa cho người đó key private để người đó giải mã.

- Các hàm đã sử dụng:
1. ORA_RSA.ENCRYPT(): truyền vào thông tin cần mã hóa và key public, trả về thông tin đã mã hóa. Hàm đã sử dụng thuật toán mã hóa RSA.
#### Ví dụ từ mã nguồn:
>`encrypted_data := ORA_RSA.ENCRYPT(message => UTL_I18N.STRING_TO_RAW(p_data, 'AL32UTF8'),
  public_key => UTL_RAW.CAST_TO_RAW(p_public_key));`
  
2. DBMS_CRYPTO.HASH(): truyền vào thông tin cần hash và id thuật toán Hash. Ta dùng hàm này để hash key private để nhân viên có thể kiểm tra khóa key private xem có thể giải mã được không trước khi giải mã. Như vậy thì sẽ tránh được lỗi không thể giải mã nếu key sai.
#### Ví dụ từ mã nguồn:
>`return DBMS_CRYPTO.HASH(UTL_RAW.CAST_TO_RAW(p_private_key), 2);`

3. ORA_RSA.DECRYPT(): Truyền vào thông tin đã mã hóa và private key, trả về thông tin đã giải mã
#### Ví dụ từ mã nguồn:
>`decrypted_data := ORA_RSA.DECRYPT(p_data, UTL_RAW.CAST_TO_RAW(p_private_key));`

