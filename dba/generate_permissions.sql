--run this SQL statment.  then copy/paste the results into a bew window and execute the commands.

--FIRST BLOCK:
--procedurally generates commands to give select, insert, and update rights to analysts in all tables 
--across all schemas in the redshift db.
--NOTE: these privileges will *NOT* apply to tables that are created AFTER this command is run.

--SECOND BLOCK
--procedurally generates commands to alter the schema-level privileges so that *new* tables 
--have grant/select/insert/update rights to analysts.
--NOTE: this ONLY applies to newly created tables in the schema
--you still need to explicitly grant privileges to existing tables (see above)
--per: https://docs.aws.amazon.com/redshift/latest/dg/r_ALTER_DEFAULT_PRIVILEGES.html

SELECT 'GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA '||schema||' TO GROUP analysts;' AS command
FROM db_management.all_schemas
WHERE schema NOT IN ('pg_internal', 'pg_catalog')

UNION ALL

SELECT 'ALTER DEFAULT PRIVILEGES IN SCHEMA '||schema||' GRANT SELECT, INSERT, UPDATE ON TABLES TO GROUP analysts;' AS command
FROM db_management.all_schemas
WHERE schema NOT IN ('pg_internal', 'pg_catalog');
