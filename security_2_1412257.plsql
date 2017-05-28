conn hr/hr

create or replace function create_signature(
    p_data in varchar2,
	priv_key in CLOB)
return raw deterministic
is
  signature raw(32000);
begin
  signature := ORA_RSA.SIGN(message => UTL_I18N.STRING_TO_RAW(p_data, 'AL32UTF8'),
        private_key => UTL_RAW.cast_to_raw(priv_key),
        private_key_password => '',
        hash => ORA_RSA.HASH_SHA256);
  return signature;
END;
/

create or replace function verify(p_data in varchar2, p_signature in raw, pub_key in CLOB)
return varchar2 deterministic
is
  signature_check_result PLS_INTEGER;
BEGIN
	if p_signature IS NULL then
		return 'FAILED!';
	end if;
    signature_check_result := ORA_RSA.VERIFY(message => UTL_I18N.STRING_TO_RAW(p_data, 'AL32UTF8'), 
        signature => p_signature, 
        public_key => UTL_RAW.cast_to_raw(pub_key),
        hash => ORA_RSA.HASH_SHA256);
 
    IF signature_check_result = 1 THEN
       return 'Successful'; 
    ELSE
       return 'FAILED!'; 
    END IF;   
END;
/