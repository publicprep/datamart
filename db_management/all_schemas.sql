CREATE OR REPLACE VIEW db_management.all_schemas AS
SELECT DISTINCT datname AS database, 
       nspname AS schema
FROM stv_tbl_perm
JOIN pg_class ON pg_class.oid = stv_tbl_perm.id
JOIN pg_namespace ON pg_namespace.oid = relnamespace
JOIN pg_database ON pg_database.oid = stv_tbl_perm.db_id
ORDER BY datname, nspname;
