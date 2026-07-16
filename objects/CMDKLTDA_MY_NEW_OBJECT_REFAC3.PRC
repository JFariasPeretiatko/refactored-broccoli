CREATE OR REPLACE PROCEDURE CMDKLTDA_MY_NEW_OBJECT_REFAC3 (
    p_id          IN NUMBER, 
    p_texto_extra IN VARCHAR2 DEFAULT NULL
)
IS
    v_nome_final VARCHAR2(400);       
BEGIN
    -- Busca o nome atual e faz concatenação
    SELECT DS_NAME
      INTO v_nome_final
      FROM CMDKLTD_CUSTOM_REFACTORED
     WHERE NR_SEQUENCIA = p_id;                   

    -- Concatenação de strings
    v_nome_final := v_nome_final || ' - ' || 
                    NVL(p_texto_extra, 'ATUALIZADO') || 
                    ' [' || TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI') || ']';

    -- Atualiza o registro com o nome concatenado
    UPDATE CMDKLTD_CUSTOM_REFACTORED
       SET DS_NAME = v_nome_final
     WHERE NR_SEQUENCIA = p_id;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Nome concatenado com sucesso: ' || v_nome_final);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Registro com ID ' || p_id || ' não encontrado.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
END;
/