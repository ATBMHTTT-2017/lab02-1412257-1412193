conn hr/hr

create or replace function encrypt_RSA(
  p_data in varchar2,
  p_public_key in CLOB)
return raw deterministic
is
    encrypted_data raw(32000);
BEGIN
  encrypted_data := ORA_RSA.ENCRYPT(message => UTL_I18N.STRING_TO_RAW(p_data, 'AL32UTF8'),
                             public_key => UTL_RAW.CAST_TO_RAW(p_public_key));  
	return encrypted_data;
END;
/

create or replace function hash_private_key(p_private_key in CLOB)
return raw deterministic
is
begin
    return DBMS_CRYPTO.HASH(UTL_RAW.CAST_TO_RAW(p_private_key), 2);
end;
/

create or replace function decrypt_RSA(
    p_data in varchar2,
    p_private_key in varchar2,
	p_hashed_private_key in raw)
return varchar2 deterministic
is
  decrypted_data raw(32000);
  hashed_private_key raw(32000);
begin
  if p_hashed_private_key is NULL then
    return 'Khong the giai ma.';
  end if;
  hashed_private_key := hash_private_key(p_private_key);
  if hashed_private_key = p_hashed_private_key then
    decrypted_data := ORA_RSA.DECRYPT(p_data, UTL_RAW.CAST_TO_RAW(p_private_key));
    return UTL_I18N.RAW_TO_CHAR(decrypted_data, 'AL32UTF8');
  else
    return 'Khong the giai ma.';
  end if;
end;
/