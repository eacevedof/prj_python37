from vue.shared.infrastructure.factories.db import get_db


def invoke():
    db = get_db()
    db.execute("SELECT * FROM users;")
    row = db.fetchone()
    while row:
        print(row)
        row = db.fetchone()

