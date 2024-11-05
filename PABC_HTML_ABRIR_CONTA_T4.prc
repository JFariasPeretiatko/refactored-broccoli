create or replace PROCEDURE PABC_HTML_ABRIR_CONTA_T4 (
    nr_sequencia_p   IN   NUMBER,
    nm_usuario_p     IN   VARCHAR2,
    nm_table_p       IN   VARCHAR2,
    nm_path_p        IN   VARCHAR2,
    nm_operation_p   IN   VARCHAR2,
	NR_REFERENCE_p      in VARCHAR2 DEFAULT null
) IS
    nr_seq_interno_w dtt_log_replicate_tables.nr_sequencia%TYPE;
BEGIN
nr_seq_interno_w:= null;
SELECT
                dtt_log_replicate_tables_seq.NEXTVAL
            INTO nr_seq_interno_w
            FROM
                dual;
    if nm_operation_p != 'INVALID' then
    INSERT INTO dtt_log_replicate_tables (
        nr_sequencia,
        dt_atualizacao,
        nm_usuario,
        NR_SEQ_REF,
        nm_table,
        nm_path,
        nm_operation,
        ds_table,
        NR_REFERENCE
    ) VALUES (
        nr_seq_interno_w,
        sysdate,
        nm_usuario_p,
        nr_sequencia_p,
        nm_table_p,
        nm_path_p,
        nm_operation_p,
        OBTER_DESC_TABELA(nm_table_p),
        NR_REFERENCE_p
    );
    end if;
       exception
            when no_data_found then
			NULL;

commit;
END PABC_HTML_ABRIR_CONTA_T4;
/
