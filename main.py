import psycopg2

def create_db(connector):
    with connector.cursor() as cur:
        cur.execute("""
            CREATE TABLE IF NOT EXISTS client (
                client_id SERIAL PRIMARY KEY,
                client_name VARCHAR(200) NOT NULL,
                client_surname VARCHAR(200) NOT NULL,
                email VARCHAR(100) NOT NULL UNIQUE
            );

            CREATE TABLE IF NOT EXISTS phone(
                phone_id SERIAL PRIMARY KEY,
                phone_number VARCHAR(20) NOT NULL UNIQUE,
                client_id INTEGER REFERENCES client(client_id)
            );""")
        connector.commit()

def add_new_client(connector):
    client = input('Имя и фамилию нового клиента: ').strip().split()
    client_email = input('Email клиента: ').strip()
    phone_numbers = input('Номера телефонов клиента (укажите через запятую): ').strip()

    with connector.cursor() as cur:
        cur.execute("""
            INSERT INTO client(
                client_name, client_surname, email)
            VALUES(%s, %s, %s) 
            RETURNING client_id;""", (client[0].strip(), client[1].strip(), client_email))
        client_id = cur.fetchone()

        if len(phone_numbers) > 0:
            phone_numbers = phone_numbers.split(',')
            for phone_number in phone_numbers:
                cur.execute("""
                    INSERT INTO phone(
                        phone_number, client_id)
                    VALUES(%s, %s);""", (phone_number.strip(), client_id))
                connector.commit()

def find_client(connector):
    client = input('Введите имя и фамилию клиента: ').strip().split()
    with connector.cursor() as cur:
        cur.execute("""
            SELECT client_id FROM client
            WHERE client_name=%s AND client_surname=%s;""", (client[0], client[1]))
        client_id = cur.fetchone()

    if client_id == None:
        print(f'Клиент {client[0]} {client[1]} отсутствует в базе данных')
        return None
    else:
        return client_id[0]

def add_phone(connector):
    client_id = find_client(connector)
    if client_id == None:
        return

    with connector.cursor() as cur:
        phone = input('Введите номер телефона: ').strip()
        cur.execute("""
            INSERT INTO phone(
                phone_number, client_id)
            VALUES(%s, %s);""", (phone, client_id))
        connector.commit()

def change_client(connector):
    client_id = find_client(connector)
    if client_id == None:
        return

    act = input("""Укажите какие данные Вы хотите изменить:
             1. Имя
             2. Фамилия
             3. Email
             4. Номера телефонов""").strip()

    with connector.cursor() as cur:
        if act == '4':
            cur.execute("""
                        SELECT phone_id, phone_number FROM phone
                        WHERE client_id=%s;""", (client_id,))
            phones = cur.fetchall()
            if len(phones) > 0:
                print('Существующие номера телефонов:')
                print('№   | Номер телефона')
                for phone in phones:
                    print(f'{phone[0]}   | {phone[1]}')
                phone_id = input('Введите № номера телефона, который хотите изменить: ').strip()
                new_phone = input('Введите новый телефон: ').strip()
                cur.execute("""
                                UPDATE phone SET phone_number=%s
                                WHERE phone_id=%s;""", (new_phone, phone_id))
                connector.commit()
            else:
                print('У клиента отсутствуют номера телефонов')

            return

        if act == '1':
            client = input('Введите новое имя клиента: ').strip()
            cur.execute("""
                            UPDATE client SET client_name=%s
                            WHERE client_id=%s;""", (client, client_id))
        if act == '2':
            client = input('Введите новую фамилию клиента: ').strip()
            cur.execute("""
                            UPDATE client SET client_surname=%s
                            WHERE client_id=%s;""", (client, client_id))
        if act == '3':
            client = input('Введите новый Email клиента: ').strip()
            cur.execute("""
                            UPDATE client SET email=%s
                            WHERE client_id=%s;""", (client, client_id))
        cur.execute("""
                        SELECT client_name, client_surname, email FROM client
                        WHERE client_id=%s;""", (client_id,))
        client = cur.fetchone()
        print(f'Имя - {client[0]} | Фамилия - {client[1]} | Email - {client[2]}')   

def delete_phone(connector):
    client_id = find_client(connector)
    if client_id == None:
        return

    with connector.cursor() as cur:
        cur.execute("""
            SELECT phone_id, phone_number FROM phone
            WHERE client_id=%s;""", (client_id, ))
        phones = cur.fetchall()

        if len(phones) > 0:
            print('Существующие номера телефонов:')
            print('№   | Номер телефона')
            for phone in phones:
                print(f'{phone[0]}   | {phone[1]}')
            phone_id = input('Введите № номера телефона, который хотите удалить: ').strip()

            cur.execute("""
                DELETE FROM phone
                WHERE phone_id=%s;""", (phone_id, ))
            connector.commit()
        else:
            print('У клиента отсутствуют номера телефонов')
            return

def delete_client(connector):
    client_id = find_client(connector)
    if client_id == None:
        return

    with connector.cursor() as cur:
        cur.execute("""
            DELETE FROM phone
            WHERE client_id=%s;""", (client_id, ))
        cur.execute("""
            DELETE FROM client
            WHERE client_id=%s""", (client_id, ))
        connector.commit()

def print_client(client_list, cur):
    if len(client_list) == 0:
        print("Список клиентов пуст")
        return

    for client in client_list:
        print(f'Имя - {client[1]} | Фамилия - {client[2]} | Email - {client[3]}')
        cur.execute("""
                    SELECT phone_number FROM phone
                    WHERE client_id=%s;""", (client[0],))
        result = cur.fetchall()
        print('Телефоны:')
        for phone_number in result:
            print(f'    - {phone_number[0]}')

def find_by(connector):
    print("""Найти клиента по:
             1. Имени и фамилии
             2. Email
             3. Номеру телефона""")
    variant = input('Введите номер: ').strip()

    with connector.cursor() as cur:
        if variant == '3':
            phone = input("Введите номер телефона: ").strip()

            cur.execute("""
                        SELECT client_id FROM phone
                        WHERE phone_number=%s;""", (phone, ))
            result = cur.fetchall()

            if len(result) == 0:
                print('Указанного номера не существует')
                return

            cur.execute("""
                        SELECT * FROM client
                        WHERE client_id=%s;""", (result[0][0], ))
            print_client(cur.fetchall(), cur)

            return
        if variant == '1':
            client = input('Введите имя и фамилию клиента: ').strip().split()
            cur.execute("""
                        SELECT * FROM client
                        WHERE client_name=%s AND client_surname=%s;""", (client[0], client[1]))
            print_client(cur.fetchall(), cur)

        if variant == '2':
            email = input('Введите Email клиента: ').strip()
            cur.execute("""
                        SELECT * FROM client
                        WHERE email=%s;""", (email, ))
            print_client(cur.fetchall(), cur)

def out(connector):
    return 'out'

def main():
    database = input("Введите имя баз данных: ").strip()
    user = input("Введите имя пользователя: ").strip()
    password = input("Введите пароль: ").strip()

    conn = psycopg2.connect(database=database, user=user, password=password)

    create_db(conn)

    func_dict = {
        '1': add_new_client,
        '2': add_phone,
        '3': change_client,
        '4': delete_phone,
        '5': delete_client,
        '6': find_by,
        'Q': out
    }
    while True:
        print("""
                1 - Добавить нового клиента
                2 - Добавить телефон для существующего клиента
                3 - Изменить данные о клиенте
                4 - Удалить телефон для существующего клиента
                5 - Удалить клиента
                6 - Найти клиента по его данным
                Q - Выход""")

        try:
            if func_dict[input('Введите вариант: ').strip()](conn) == 'out':
                break
        except KeyError:
            print('Введено неверное значение')

    conn.close()



if __name__ == '__main__':
    main()