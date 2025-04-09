-- 기존 관리자 계정 확인
SELECT * FROM admin;

-- 관리자 계정이 없으면 추가
INSERT INTO admin (admin_id, admin_pwd, admin_name, admin_roll, admin_email, admin_fail_login, admin_lock_state)
SELECT 'admin', '1234', '관리자', '관리자', 'admin@example.com', 0, 'N'
FROM dual
WHERE NOT EXISTS (SELECT 1 FROM admin LIMIT 1);

-- 추가 후 확인
SELECT * FROM admin; 