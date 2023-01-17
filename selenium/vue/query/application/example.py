from vue.shared.infrastructure.factories.db import get_db


def run():
    db = get_db()
    db.execute("SELECT @@version;")
    row = db.fetchone()
    while row:
        print(row[0])
        row = db.fetchone()

run()