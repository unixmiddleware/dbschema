DECLARE
  ddl CLOB;
BEGIN
  FOR t IN (SELECT table_name FROM all_tables WHERE owner='SVGMGR' ORDER BY table_name) LOOP
    ddl := DBMS_METADATA.GET_DDL('TABLE', t.table_name, 'SVGMGR');
    DBMS_XSLPROCESSOR.CLOB2FILE(ddl, 'DDL_DIR', 'tables/' || t.table_name || '.sql');
  END LOOP;
END;
/
