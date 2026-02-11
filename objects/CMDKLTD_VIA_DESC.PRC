CREATE OR REPLACE PROCEDURE CMDKLTD_VIA_DESC AS
    v_observacao DIC_EXPRESSAO.DS_REVISAO%TYPE;
	v_descricao varchar2(4000);
   seq CMDKLTD_RECRIADO.NR_SEQUENCIA%TYPE;

BEGIN
   SELECT DS_REVISAO, 
   obter_desc_expressao(cd_expressao, ds_expressao_br)
    INTO v_observacao, v_descricao
    FROM DIC_EXPRESSAO
    where ROWNUM = 1;

    INSERT INTO CMDKLTD_CUSTOM_REFACTORED (
        NR_SEQUENCIA, DS_NAME
    ) VALUES (
        2,
        v_observacao 
    );
    select nr_sequencia into seq from CMDKLTD_RECRIADO;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'Erro ao cadastrar na CMDKLTD_CUSTOM: ' || SQLERRM);
END CMDKLTD_VIA_DESC;
/