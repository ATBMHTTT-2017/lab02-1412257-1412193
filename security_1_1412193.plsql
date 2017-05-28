-- HASH
create or replace function Hash_data(p_key IN VARCHAR2)
return RAW DETERMINISTIC
IS
v_key RAW(128) := UTL_RAW.cast_to_raw(p_key);
l_HASH raw(1024);
BEGIN
	l_HASH := dbms_crypto.hash(
			 src => v_key,
			 typ => dbms_crypto.HASH_SH1);
	return l_HASH;
END Hash_data;
/

-- m„ hÛa
create or replace function encrypt_data_luong(
	p_data IN VARCHAR2,
	v_keysx IN VARCHAR2)
return RAW DETERMINISTIC
IS
v_key RAW(128) := UTL_RAW.cast_to_raw(v_keysx);
l_data raw(1024) := utl_raw.cast_to_raw(p_data);
l_encrypted raw(1024);
BEGIN
	l_encrypted := dbms_crypto.encrypt(
		src => l_data,
		typ => dbms_crypto.DES_CBC_PKCS5,
		key => v_key);
	return l_encrypted;
END encrypt_data_luong;
/

--- gi?i m„
create or replace function decrypt_data_luong(
	p_data IN VARCHAR2,
	p_hash_data in VARCHAR2,
	v_keysx IN VARCHAR2)
return VARCHAR2 DETERMINISTIC
IS
v_key RAW(128) := UTL_RAW.cast_to_raw(v_keysx);
l_decrypted raw(1024);
l_HASH raw(1024);
BEGIN
	l_HASH := dbms_crypto.hash(
			 src => v_key,
			 typ => dbms_crypto.HASH_SH1);

	if (l_HASH = p_hash_data)  then
	l_decrypted := dbms_crypto.decrypt(
		src => p_data,
		typ => dbms_crypto.DES_CBC_PKCS5,
		key => v_key);
	return utl_raw.cast_to_varchar2(l_decrypted);

	else
		return TO_CHAR(p_data);
	end if;

END decrypt_data_luong;
/

update nhanvien set hashkey = Hash_data('passwordexesx10') where manv = '1412193';
update nhanvien set hashkey = Hash_data('passwordexesx20') where manv = '1412257';
update nhanvien set hashkey = Hash_data('passwordexesx30') where manv = '1412258';
update nhanvien set hashkey = Hash_data('passwordexesx40') where manv = '1412176';
update nhanvien set hashkey = Hash_data('passwordexesx50') where manv = '1412195';
update nhanvien set hashkey = Hash_data('passwordexesx60') where manv = '1412186';
update nhanvien set hashkey = Hash_data('passwordexesx70') where manv = '1412192';
update nhanvien set hashkey = Hash_data('passwordexesx80') where manv = '1412173';
update nhanvien set hashkey = Hash_data('passwordexesx90') where manv = '1412232';
update nhanvien set hashkey = Hash_data('passwordexesx100') where manv = '1412245';
update nhanvien set hashkey = Hash_data('passwordexesx101') where manv = '1412200';
update nhanvien set hashkey = Hash_data('passwordexesx102') where manv = '1412201';
update nhanvien set hashkey = Hash_data('passwordexesx103') where manv = '1412202';
update nhanvien set hashkey = Hash_data('passwordexesx104') where manv = '1412203';
update nhanvien set hashkey = Hash_data('passwordexesx105') where manv = '1412204';
update nhanvien set hashkey = Hash_data('passwordexesx106') where manv = '1412205';
update nhanvien set hashkey = Hash_data('passwordexesx107') where manv = '1412206';
update nhanvien set hashkey = Hash_data('passwordexesx108') where manv = '1412207';
update nhanvien set hashkey = Hash_data('passwordexesx109') where manv = '1412208';
update nhanvien set hashkey = Hash_data('passwordexesx110') where manv = '1412209';
update nhanvien set hashkey = Hash_data('passwordexesx111') where manv = '1412210';
update nhanvien set hashkey = Hash_data('passwordexesx112') where manv = '1412211';
update nhanvien set hashkey = Hash_data('passwordexesx113') where manv = '1412212';
update nhanvien set hashkey = Hash_data('passwordexesx114') where manv = '1412213';

update nhanvien set luong = encrypt_data_luong(luong, 'passwordexesx10') where manv = '1412193';
update nhanvien set luong = encrypt_data_luong(luong, 'passwordexesx20') where manv = '1412257';
update nhanvien set luong = encrypt_data_luong(luong, 'passwordexesx30') where manv = '1412258';
update nhanvien set luong = encrypt_data_luong(luong, 'passwordexesx40') where manv = '1412176';
update nhanvien set luong = encrypt_data_luong(luong, 'passwordexesx50') where manv = '1412195';
update nhanvien set luong = encrypt_data_luong(luong, 'passwordexesx60') where manv = '1412186';
update nhanvien set luong = encrypt_data_luong(luong, 'passwordexesx70') where manv = '1412192';
update nhanvien set luong = encrypt_data_luong(luong, 'passwordexesx80') where manv = '1412173';
update nhanvien set luong = encrypt_data_luong(luong, 'passwordexesx90') where manv = '1412232';
update nhanvien set luong = encrypt_data_luong(luong, 'passwordexesx100') where manv = '1412245';
update nhanvien set luong = encrypt_data_luong(luong, 'passwordexesx101') where manv = '1412200';
update nhanvien set luong = encrypt_data_luong(luong, 'passwordexesx102') where manv = '1412201';
update nhanvien set luong = encrypt_data_luong(luong, 'passwordexesx103') where manv = '1412202';
update nhanvien set luong = encrypt_data_luong(luong, 'passwordexesx104') where manv = '1412203';
update nhanvien set luong = encrypt_data_luong(luong, 'passwordexesx105') where manv = '1412204';
update nhanvien set luong = encrypt_data_luong(luong, 'passwordexesx106') where manv = '1412205';
update nhanvien set luong = encrypt_data_luong(luong, 'passwordexesx107') where manv = '1412206';
update nhanvien set luong = encrypt_data_luong(luong, 'passwordexesx108') where manv = '1412207';
update nhanvien set luong = encrypt_data_luong(luong, 'passwordexesx109') where manv = '1412208';
update nhanvien set luong = encrypt_data_luong(luong, 'passwordexesx110') where manv = '1412209';
update nhanvien set luong = encrypt_data_luong(luong, 'passwordexesx111') where manv = '1412210';
update nhanvien set luong = encrypt_data_luong(luong, 'passwordexesx112') where manv = '1412211';
update nhanvien set luong = encrypt_data_luong(luong, 'passwordexesx113') where manv = '1412212';
update nhanvien set luong = encrypt_data_luong(luong, 'passwordexesx114') where manv = '1412213';

create procedure nhanvienLuong (key in varchar2 ,prc out sys_refcursor)
is
begin
  open prc for
	select manv, decrypt_data_luong(luong, hashkey, key) as LUONG from nhanvien;
end;

grant execute on nhanvienLuong to nhanvien;
