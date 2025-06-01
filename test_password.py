from passlib.context import CryptContext
import sqlite3

pwd_context = CryptContext(schemes=['bcrypt'], deprecated='auto')

conn = sqlite3.connect('marodb.db')
cursor = conn.cursor()
cursor.execute('SELECT hashed_password FROM users WHERE email = "admin@maroai.com"')
result = cursor.fetchone()

if result:
    stored_hash = result[0]
    test_password = 'admin123'
    is_valid = pwd_context.verify(test_password, stored_hash)
    print(f'Пароль admin123 валидный: {is_valid}')
    print(f'Хеш из БД: {stored_hash[:50]}...')
else:
    print('Пользователь не найден')

conn.close() 