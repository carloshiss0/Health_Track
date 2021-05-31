-- Gerado por Oracle SQL Developer Data Modeler 20.4.1.406.0906
--   em:        2021-05-22 15:33:04 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE r_dieta (
    t_refeicao_id_ref  NUMBER(15) NOT NULL,
    t_dietas_id_diet   NUMBER(15) NOT NULL
);

ALTER TABLE r_dieta ADD CONSTRAINT r_dieta_pk PRIMARY KEY ( t_refeicao_id_ref,
                                                            t_dietas_id_diet );

CREATE TABLE r_prato (
    t_alimentos_id_al  NUMBER(15) NOT NULL,
    t_refeicao_id_ref  NUMBER(15) NOT NULL
);

ALTER TABLE r_prato ADD CONSTRAINT r_prato_pk PRIMARY KEY ( t_alimentos_id_al,
                                                            t_refeicao_id_ref );

CREATE TABLE t_alimentos (
    id_al       NUMBER(15) NOT NULL,
    nome        VARCHAR2(30) NOT NULL,
    calorias    NUMBER(10) NOT NULL,
    descrisão   VARCHAR2(150) NOT NULL,
    quantidade  NUMBER(10) NOT NULL
);

ALTER TABLE t_alimentos ADD CONSTRAINT t_alimentos_pk PRIMARY KEY ( id_al );

CREATE TABLE t_certi (
    id_cert            NUMBER(15) NOT NULL,
    certificacao       VARCHAR2(50) NOT NULL,
    data_cert          DATE NOT NULL,
    diploma            BLOB NOT NULL,
    t_nutri_id_nutri   NUMBER(15) NOT NULL,
    t_personal_id_per  NUMBER(15) NOT NULL
);

ALTER TABLE t_certi ADD CONSTRAINT t_certi_pk PRIMARY KEY ( id_cert );

CREATE TABLE t_dietas (
    id_diet           NUMBER(15) NOT NULL,
    nome              VARCHAR2(30) NOT NULL,
    descrisao         VARCHAR2(200) NOT NULL,
    t_nutri_id_nutri  NUMBER(15) NOT NULL
);

ALTER TABLE t_dietas ADD CONSTRAINT t_dietas_pk PRIMARY KEY ( id_diet );

CREATE TABLE t_endereco (
    id_end            NUMBER(15) NOT NULL,
    numero            NUMBER(10) NOT NULL,
    logradouro        VARCHAR2(50) NOT NULL,
    cidade            VARCHAR2(50) NOT NULL,
    estado            VARCHAR2(30) NOT NULL,
    pais              VARCHAR2(30) NOT NULL,
    cep               NUMBER(8) NOT NULL,
    complemento       VARCHAR2(200),
    t_login_id_login  NUMBER(15) NOT NULL
);

ALTER TABLE t_endereco ADD CONSTRAINT t_endereco_pk PRIMARY KEY ( id_end );

CREATE TABLE t_exercicios (
    id_ex              NUMBER(15) NOT NULL,
    tipo               VARCHAR2(20),
    nome               VARCHAR2(50) NOT NULL,
    descricao          VARCHAR2(200) NOT NULL,
    imagem             BLOB,
    url_video          VARCHAR2(100),
    t_personal_id_per  NUMBER(15) NOT NULL
);

ALTER TABLE t_exercicios ADD CONSTRAINT t_exercicios_pk PRIMARY KEY ( id_ex );

CREATE TABLE t_hist_pag (
    id_hist           NUMBER(15) NOT NULL,
    valor_pago        NUMBER(15) NOT NULL,
    data_pag          DATE NOT NULL,
    desconto          NUMBER(5),
    desc_desconto     VARCHAR2(200),
    t_login_id_login  NUMBER(15) NOT NULL
);

ALTER TABLE t_hist_pag ADD CONSTRAINT t_hist_pag_pk PRIMARY KEY ( id_hist );

CREATE TABLE t_login (
    id_login    NUMBER(15) NOT NULL,
    login       VARCHAR2(30) NOT NULL,
    hash_senha  VARCHAR2(64) NOT NULL,
    email       VARCHAR2(100) NOT NULL,
    telefone    NUMBER(16) NOT NULL
);

ALTER TABLE t_login ADD CONSTRAINT t_login_pk PRIMARY KEY ( id_login );

CREATE TABLE t_nutri (
    id_nutri          NUMBER(15) NOT NULL,
    crn               NUMBER(30) NOT NULL,
    especialidade     VARCHAR2(30) NOT NULL,
    t_login_id_login  NUMBER(15) NOT NULL
);

CREATE UNIQUE INDEX t_nutri__idx ON
    t_nutri (
        t_login_id_login
    ASC );

ALTER TABLE t_nutri ADD CONSTRAINT t_nutri_pk PRIMARY KEY ( id_nutri );

CREATE TABLE t_personal (
    id_per            NUMBER(15) NOT NULL,
    nome_fantasia     VARCHAR2(40) NOT NULL,
    especialidade     VARCHAR2(50) NOT NULL,
    codigo_ind        VARCHAR2(20) NOT NULL,
    t_login_id_login  NUMBER(15) NOT NULL
);

CREATE UNIQUE INDEX t_personal__idx ON
    t_personal (
        t_login_id_login
    ASC );

ALTER TABLE t_personal ADD CONSTRAINT t_personal_pk PRIMARY KEY ( id_per );

CREATE TABLE t_pessoa (
    id_person         NUMBER(15) NOT NULL,
    nome              VARCHAR2(40) NOT NULL,
    cpf               NUMBER(11),
    genero            VARCHAR2(10) NOT NULL,
    foto_perfil       BLOB,
    t_login_id_login  NUMBER(15) NOT NULL
);

CREATE UNIQUE INDEX t_pessoa__idx ON
    t_pessoa (
        t_login_id_login
    ASC );

ALTER TABLE t_pessoa ADD CONSTRAINT t_pessoa_pk PRIMARY KEY ( id_person );

CREATE TABLE t_plano (
    id_plan    NUMBER(15) NOT NULL,
    nome       VARCHAR2(20) NOT NULL,
    descrisao  VARCHAR2(254) NOT NULL,
    valor      NUMBER(15) NOT NULL,
    duracao    NUMBER(2) NOT NULL
);

ALTER TABLE t_plano ADD CONSTRAINT t_plano_pk PRIMARY KEY ( id_plan );

CREATE TABLE t_refeicao (
    id_ref     NUMBER(15) NOT NULL,
    nome       VARCHAR2(30) NOT NULL,
    descricao  VARCHAR2(150) NOT NULL,
    consumo    VARCHAR2(30) NOT NULL
);

ALTER TABLE t_refeicao ADD CONSTRAINT t_refeicao_pk PRIMARY KEY ( id_ref );

CREATE TABLE t_user (
    id_user             NUMBER(15) NOT NULL,
    peso                NUMBER(5) NOT NULL,
    altura              NUMBER(3) NOT NULL,
    biotipo             VARCHAR2(20),
    t_plano_id_plan     NUMBER(15) NOT NULL,
    t_exercicios_id_ex  NUMBER(15) NOT NULL,
    t_dietas_id_diet    NUMBER(15) NOT NULL,
    t_login_id_login    NUMBER(15) NOT NULL
);

CREATE UNIQUE INDEX t_user__idx ON
    t_user (
        t_login_id_login
    ASC );

ALTER TABLE t_user ADD CONSTRAINT t_user_pk PRIMARY KEY ( id_user );

ALTER TABLE r_dieta
    ADD CONSTRAINT r_dieta_t_dietas_fk FOREIGN KEY ( t_dietas_id_diet )
        REFERENCES t_dietas ( id_diet );

ALTER TABLE r_dieta
    ADD CONSTRAINT r_dieta_t_refeicao_fk FOREIGN KEY ( t_refeicao_id_ref )
        REFERENCES t_refeicao ( id_ref );

ALTER TABLE r_prato
    ADD CONSTRAINT r_prato_t_alimentos_fk FOREIGN KEY ( t_alimentos_id_al )
        REFERENCES t_alimentos ( id_al );

ALTER TABLE r_prato
    ADD CONSTRAINT r_prato_t_refeicao_fk FOREIGN KEY ( t_refeicao_id_ref )
        REFERENCES t_refeicao ( id_ref );

ALTER TABLE t_certi
    ADD CONSTRAINT t_certi_t_nutri_fk FOREIGN KEY ( t_nutri_id_nutri )
        REFERENCES t_nutri ( id_nutri );

ALTER TABLE t_certi
    ADD CONSTRAINT t_certi_t_personal_fk FOREIGN KEY ( t_personal_id_per )
        REFERENCES t_personal ( id_per );

ALTER TABLE t_dietas
    ADD CONSTRAINT t_dietas_t_nutri_fk FOREIGN KEY ( t_nutri_id_nutri )
        REFERENCES t_nutri ( id_nutri );

ALTER TABLE t_endereco
    ADD CONSTRAINT t_endereco_t_login_fk FOREIGN KEY ( t_login_id_login )
        REFERENCES t_login ( id_login );

ALTER TABLE t_exercicios
    ADD CONSTRAINT t_exercicios_t_personal_fk FOREIGN KEY ( t_personal_id_per )
        REFERENCES t_personal ( id_per );

ALTER TABLE t_hist_pag
    ADD CONSTRAINT t_hist_pag_t_login_fk FOREIGN KEY ( t_login_id_login )
        REFERENCES t_login ( id_login );

ALTER TABLE t_nutri
    ADD CONSTRAINT t_nutri_t_login_fk FOREIGN KEY ( t_login_id_login )
        REFERENCES t_login ( id_login );

ALTER TABLE t_personal
    ADD CONSTRAINT t_personal_t_login_fk FOREIGN KEY ( t_login_id_login )
        REFERENCES t_login ( id_login );

ALTER TABLE t_pessoa
    ADD CONSTRAINT t_pessoa_t_login_fk FOREIGN KEY ( t_login_id_login )
        REFERENCES t_login ( id_login );

ALTER TABLE t_user
    ADD CONSTRAINT t_user_t_dietas_fk FOREIGN KEY ( t_dietas_id_diet )
        REFERENCES t_dietas ( id_diet );

ALTER TABLE t_user
    ADD CONSTRAINT t_user_t_exercicios_fk FOREIGN KEY ( t_exercicios_id_ex )
        REFERENCES t_exercicios ( id_ex );

ALTER TABLE t_user
    ADD CONSTRAINT t_user_t_login_fk FOREIGN KEY ( t_login_id_login )
        REFERENCES t_login ( id_login );

ALTER TABLE t_user
    ADD CONSTRAINT t_user_t_plano_fk FOREIGN KEY ( t_plano_id_plan )
        REFERENCES t_plano ( id_plan );

CREATE OR REPLACE TRIGGER arc_arc_2_t_nutri BEFORE
    INSERT OR UPDATE OF t_login_id_login ON t_nutri
    FOR EACH ROW
DECLARE
    d NUMBER(15);
BEGIN
    SELECT
        a.id_login
    INTO d
    FROM
        t_login a
    WHERE
        a.id_login = :new.t_login_id_login;

    IF ( d IS NULL OR d <> t_n_l ) THEN
        raise_application_error(-20223,
                               'FK T_NUTRI_T_LOGIN_FK in Table T_NUTRI violates Arc constraint on Table T_LOGIN - discriminator column id_login doesn''t have value T_N_L');
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_arc_2_t_personal BEFORE
    INSERT OR UPDATE OF t_login_id_login ON t_personal
    FOR EACH ROW
DECLARE
    d NUMBER(15);
BEGIN
    SELECT
        a.id_login
    INTO d
    FROM
        t_login a
    WHERE
        a.id_login = :new.t_login_id_login;

    IF ( d IS NULL OR d <> t_p_l ) THEN
        raise_application_error(-20223,
                               'FK T_PERSONAL_T_LOGIN_FK in Table T_PERSONAL violates Arc constraint on Table T_LOGIN - discriminator column id_login doesn''t have value T_P_L');
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_arc_2_t_user BEFORE
    INSERT OR UPDATE OF t_login_id_login ON t_user
    FOR EACH ROW
DECLARE
    d NUMBER(15);
BEGIN
    SELECT
        a.id_login
    INTO d
    FROM
        t_login a
    WHERE
        a.id_login = :new.t_login_id_login;

    IF ( d IS NULL OR d <> t_u_l ) THEN
        raise_application_error(-20223,
                               'FK T_USER_T_LOGIN_FK in Table T_USER violates Arc constraint on Table T_LOGIN - discriminator column id_login doesn''t have value T_U_L');
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            15
-- CREATE INDEX                             4
-- ALTER TABLE                             32
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           3
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
