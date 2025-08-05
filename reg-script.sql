-- ------------------------------------------------------------
-- File: create_db_user.sql
-- Purpose: Create a new user and grant basic access on a Postgres DB
-- Usage: psql -h <host> -U <admin_user> -d <DB_NAME> -f create_db_user.sql
-- ------------------------------------------------------------

-- 1) Create the login role (user)
--    Replace <USER> and <PASSWORD> with your desired username/password.
CREATE ROLE <USER> 
  WITH 
    LOGIN 
    PASSWORD '<PASSWORD>' 
    NOSUPERUSER 
    INHERIT 
    NOCREATEDB 
    NOCREATEROLE 
    NOREPLICATION;

-- 2) Grant CONNECT on the database
--    Replace <DB_NAME> with your database name.
GRANT CONNECT ON DATABASE <DB_NAME> TO <USER>;

-- 3) Grant USAGE on the schema (so the user can see and use objects in it)
--    Replace <SCHEMA> (often 'public') as needed.
GRANT USAGE ON SCHEMA <SCHEMA> TO <USER>;

-- 4) Grant CRUD privileges on all existing tables in that schema
GRANT SELECT, INSERT, UPDATE, DELETE
  ON ALL TABLES IN SCHEMA <SCHEMA>
  TO <USER>;

-- 5) Ensure future tables get the same privileges automatically
ALTER DEFAULT PRIVILEGES 
  IN SCHEMA <SCHEMA>
  GRANT SELECT, INSERT, UPDATE, DELETE
  ON TABLES TO <USER>;

-- 6) (Optional) Grant privileges on sequences, if you use SERIAL/BIGSERIAL
GRANT USAGE, SELECT
  ON ALL SEQUENCES IN SCHEMA <SCHEMA>
  TO <USER>;

ALTER DEFAULT PRIVILEGES 
  IN SCHEMA <SCHEMA>
  GRANT USAGE, SELECT
  ON SEQUENCES TO <USER>;

-- 7) Verify role creation
--    This query will list the new role in pg_roles:
--    SELECT rolname, rolsuper, rolcreatedb, rolreplication FROM pg_roles WHERE rolname = '<USER>';
