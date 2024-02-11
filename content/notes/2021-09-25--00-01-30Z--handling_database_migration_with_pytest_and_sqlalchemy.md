+++
title = "Handling database migration with Pytest and SQLAlchemy"
author = ["Ben Mezger"]
date = 2021-09-24T21:01:00
slug = "handling_database_migration_with_pytest_and_sqlalchemy"
tags = ["python", "testing", "programming"]
type = "notes"
draft = false
bookCollapseSection = true
+++

-   Related pages
    -   [Python]({{<relref "2020-05-31--16-04-33Z--python.md#" >}})
    -   [Python's name mangling]({{<relref "2021-09-18--23-30-27Z--python_name_mangling.md#" >}})

---

Recently I wanted to get [pytest](https://docs.pytest.org/) to work the same way [pytest-django](https://pytest-django.readthedocs.io/en/latest/database.html) handles
migrations and database fixtures. As a bonus, I wanted to add some custom
=pytest=flags to control the database during tests.

```python
import pytest

from sqlalchemy import MetaData, create_engine
from sqlalchemy import orm
from sqlalchemy_utils import create_database, database_exists, drop_database

from app import config as app_config
from app.db.session import SessionLocal

# we keep SessionLocal as default, but
# we later overwrite it if we use the testing
# db
TestingSessionLocal = SessionLocal


# see https://docs.pytest.org/en/stable/reference.html
# about pytest_addoption
def pytest_addoption(parser):
    # NOTE: when adding or removing an option,
    # remove to remove/add from app/conftest.py:addoption_params
    parser.addoption(
        "--no-db", default=False, action="store_true", help="Disable testing database"
    )
    parser.addoption(
        "--drop-db",
        default=False,
        action="store_true",
        help="Drop test database after running tests",
    )
    parser.addoption(
        "--reuse-db", default=False, action="store_true", help="Reuse previous database"
    )
    parser.addoption(
        "--echo-db",
        default=False,
        action="store_true",
        help="Echo database queries to stdout",
    )
    parser.addoption(
        "--database-uri",
        default=str(config.TEST_DATABASE_URL),
        action="store",
        help="Provice custom database url",
    )


def addoption_params(config):
    # NOTE: Params are defined pytest_addoption
    return {
        "drop-db": config.getoption("--drop-db"),
        "no-db": config.getoption("--no-db"),
        "reuse-db": config.getoption("--reuse-db"),
        "echo-db": config.getoption("--echo-db"),
        "database-uri": config.getoption("--database-uri"),
    }


def pytest_configure(config):
    global TestingSessionLocal

    # check if we should ovewrite the database and
    # skip it if set
    params = addoption_params(config)
    if params.get("no-db"):
        return

    database_uri = params.get("database-uri")
    echo_db = params.get("echo-db")

    if database_exists(database_uri):
        # if reuse-db is set, don't drop the database
        # as we want to use the previous database
        if not params.get("reuse-db"):
            drop_database(database_uri)
            create_database(database_uri)
    else:
        create_database(database_uri)

    engine = create_engine(database_uri, echo=echo_db)

    # dont drop and create the database if reuse-db is set
    if not params.get("reuse-db"):
        DBBase.metadata.drop_all(engine)
        DBBase.metadata.create_all(engine)
        engine.execute("create extension pg_trgm;")

    # overwrite TestingSessionLocal with the testing database
    TestingSessionLocal = orm.sessionmaker(bind=engine, autocommit=True, autoflush=True)


def pytest_unconfigure(config):
    params = addoption_params(config)
    # nothing to do if no-db is set
    if params.get("no-db"):
        return

    database_uri = params.get("database-uri")

    # don't drop the database if drop-db is set.
    if params.get("drop-db") and database_exists(database_uri):
        drop_database(database_uri)


@pytest.fixture
def params(request):
    return addoption_params(request.config)


@pytest.fixture(autouse=True, scope="session")
def truncate_db(pytestconfig):
    params = addoption_params(pytestconfig)
    # don't truncate if no-db is set
    if params.get("no-db"):
        return

    database_uri = params.get("database-uri")
    echo_db = params.get("echo-db")

    engine = create_engine(database_uri, echo=echo_db)
    meta = MetaData(bind=engine, reflect=True)

    con = engine.connect()
    trans = con.begin()

    # truncate all tables
    for table in meta.sorted_tables:
        con.execute(f'ALTER TABLE "{table.name}" DISABLE TRIGGER ALL;')
        con.execute(table.delete())
        con.execute(f'ALTER TABLE "{table.name}" ENABLE TRIGGER ALL;')

    trans.commit()


@pytest.fixture
def db(mocker):
    # just to ensure.
    # Patch sqlalchemy's Session with TestingSessionLocal
    patched_session = mocker.patch(
        "sqlalchemy.orm.session.Session", return_value=TestingSessionLocal
    )

    return patched_session

@pytest.fixture
def db_session():
    try:
        db = TestingSessionLocal()
        yield db
    finally:
        db.close()
```

I am unsure whether using `pytest_configure` to initialize the database and
overwrite the `TestingSessionLocal` is the recommended or correct approach, but
it works well.

The `db` fixture patches SQLAlchemy's `Session` and sets `TestingSessionLocal`
as the return value – I am unsure if this is needed, but it does seem to ensure
that any call to `Session` returns `TestingSessionLocal`. Further, `db_session`
returns an SQLAlchemy's Session.

Finally, simply call the `db_session` fixture.

```python
...

def test_create_users(db_session):
    assert len(db_session().query(models.User).all()) == 10

...
```


## Update <span class="timestamp-wrapper"><span class="timestamp">&lt;2021-09-30 Thu&gt;</span></span> {#update}

I forgot to mention that ideally, you would handle `TestingSessionLocal` as a
normal SQLAlchemy's `Session` and have different application configurations when
running tests. In Django, you could manage this as different settings:
`app/settings.py` for production and `app/testing_settings.py`. The reason I
needed to add this hacky part had to do with the codebase I was working on. The
codebase was not structured with the unit test in consideration and was going
through some major refactors to improve, so I initially had to hack a little bit
to get things to work well at the beginning.

Fortunately, the refactoring is going well, and we don't need this hack anymore.
