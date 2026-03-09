-- =====================================================================
-- SVGMGR One-File-Per-Object DDL Extraction Script
-- Produces deterministic, Git-friendly DDL for DevOps pipelines
-- =====================================================================

SET SERVEROUTPUT ON
SET LONG 2000000000
SET LONGCHUNKSIZE 2000000
SET PAGESIZE 0
SET LINESIZE 2000
SET TRIMSPOOL ON
SET FEEDBACK OFF
SET HEADING OFF
SET ECHO OFF

PROMPT Initialising DBMS_METADATA transforms...

BEGIN
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'STORAGE', false);
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'TABLESPACE', false);
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'SEGMENT_ATTRIBUTES', false);
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'CONSTRAINTS', true);
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'REF_CONSTRAINTS', true);
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'SQLTERMINATOR', true);
END;
/

PROMPT Creating output directories...

HOST mkdir -p ddl_output/tables
HOST mkdir -p ddl_output/views
HOST mkdir -p ddl_output/sequences
HOST mkdir -p ddl_output/packages
HOST mkdir -p ddl_output/package_bodies
HOST mkdir -p ddl_output/triggers
HOST mkdir -p ddl_output/synonyms

-- =====================================================================
-- Helper procedure to write CLOB to file
-- =====================================================================

DECLARE
  PROCEDURE write_file(p_clob CLOB, p_dir VARCHAR2, p_file VARCHAR2) IS
  BEGIN
    DBMS_XSLPROCESSOR.CLOB2FILE(
      p_clob,
      p_dir,
      p_file
    );
  END;
BEGIN
  NULL;
END;
/
