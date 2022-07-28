import sqlalchemy
from sqlalchemy.orm import sessionmaker
import os
from Models import create_tables, add_data, Publisher, Shop, Book, Stock, Sale

def main():
    user_name = os.getenv('P_USER_NAME')
    user_password = os.getenv('P_USER_PASS')
    db_name = os.getenv('P_DB_NAME')
    host = os.getenv('P_HOST')
    port = os.getenv('P_PORT')
    if user_name is None or user_password is None or db_name is None or host is None or port is None:
        print('Значение одной из переменных для DSN отсутствует. Проверьте переменные окружения')
        return

    DSN = f'postgresql://{user_name}:{user_password}@{host}:{port}/{db_name}'
    engine = sqlalchemy.create_engine(DSN)
    create_tables(engine)

    Session = sessionmaker(bind=engine)
    session = Session()
    add_data(session)

    print('Номер | Название')
    for c in session.query(Publisher.id, Publisher.name):
        print(f'{c[0]:^6}| {c[1]}')

    try:
        publisher_id = int(input('Введите номер издателя: ').strip())
    except ValueError:
        print(f'Введеннок значение "{publisher_id}" не является числом')
        return

    for c in session.query(Publisher.id, Publisher.name).filter(Publisher.id == publisher_id):
        print(f'Издатель - {c[1]}')
        for c1 in session.query(Book.id, Book.title).filter(Book.id_publisher == c[0]):
            for c2 in session.query(Stock.id, Stock.id_shop, Stock.count, Shop.name).join(Shop).filter(Stock.id_book == c1[0]):
                print(f'    Название книги - {c1[1]}. Остаток {c2[2]} шт. Магазин - {c2[3]}')
                for c3 in session.query(Sale.price, Sale.date_sale, Sale.count).filter(Sale.id_stock == c2[0]):
                    print(f'        Цена - {c3[0]} | Дата продажи - {c3[1]} | Продано {c3[2]} шт.')

    session.close()

if __name__ == '__main__':
    main()