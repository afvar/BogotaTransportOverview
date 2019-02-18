/*The database was created in SQL server Microsoft SQL Server 2017 (RTM) - 14.0.1000.169 (X64) Express Edition (64-bit)*/

--Create DataBase--

SET NOCOUNT ON
GO

USE MASTER
GO

IF EXISTS (SELECT * FROM SYSDATABASES WHERE NAME = 'BogTrPoll')
	DROP DATABASE BogTrPoll
IF EXISTS (SELECT [name] FROM master.sys.sql_logins WHERE [name] = 'ReadUserBTP')
BEGIN
	DROP LOGIN ReadUserBTP
END
IF EXISTS(SELECT [name] FROM master.sys.sysusers WHERE [name] = 'ReadUserBTP')
BEGIN
	DROP USER ReadUserBTP
END
GO

DECLARE @project_directory NVARCHAR(200) = 'C:\Users\felip\Documents\BogotaTransportOverview\' -- Change this location to your project folder ubication

EXEC (N'CREATE DATABASE BogTrPoll
	ON PRIMARY (NAME = N''BogTrPoll'', FILENAME = N''' + @project_directory + N'BogTrPoll_DataBase\Database\bogtrpoll.mdf'')
	LOG ON (NAME = N''BogTrPoll_log'',  FILENAME = N''' + @project_directory  + N'BogTrPoll_DataBase\Database\bogtrpoll.ldf'')')
GO

USE BogTrPoll
GO

--Create Reading User--

CREATE LOGIN ReadUserBTP WITH PASSWORD = 'Reader123$'

CREATE USER ReadUserBTP FOR LOGIN ReadUserBTP
EXEC sp_addrolemember N'db_datareader', N'ReadUserBTP'
GO

--Build the Structure--

CREATE TABLE ACTIVIDAD 
(
	ID_ACTIVIDAD NUMERIC(2,0) NOT NULL,
	ACTIVIDAD_PRINCIPAL NVARCHAR(255) NULL,
	CONSTRAINT id_actividad_pk PRIMARY KEY CLUSTERED (ID_ACTIVIDAD)
)
GO

CREATE TABLE ACTIVIDADECONOMICA
(
	ID_ACTIVIDADECONOMICA NUMERIC(2,0) NOT NULL,
	ACTIVIDAD_ECONOMICA NVARCHAR(255) NULL,
	CONSTRAINT id_actividadeconomica_pk PRIMARY KEY CLUSTERED (ID_ACTIVIDADECONOMICA)
)
GO

CREATE TABLE AGRESIONFISICA
(
	ID_AGRESIONFISICA NUMERIC(2,0) NOT NULL,
	DESCRIPCION NVARCHAR(70) NULL,
	CONSTRAINT id_agresionfisica_pk PRIMARY KEY CLUSTERED (ID_AGRESIONFISICA)
)
GO

CREATE TABLE AGRESIONSEXUAL
(
	ID_AGRESIONSEXUAL NUMERIC(2,0) NOT NULL,
	DESCRIPCION NVARCHAR(150) NULL,
	CONSTRAINT id_agresionsexual_pk PRIMARY KEY CLUSTERED (ID_AGRESIONSEXUAL)
)
GO

CREATE TABLE BENEFICIOSITP
(
	ID_BENEFICIOSITP NUMERIC(1,0) NOT NULL,
	DESCRIPCION NVARCHAR(50) NULL,
	CONSTRAINT id_beneficiositp_pk PRIMARY KEY CLUSTERED (ID_BENEFICIOSITP)
)
GO

CREATE TABLE CONTACTOS
(
	CODIGO INT NOT NULL,
	DEFINICION NVARCHAR(64) NULL,
	CONSTRAINT id_contactos_pk PRIMARY KEY CLUSTERED (CODIGO)
)
GO

CREATE TABLE CULTURA
(
	ID_CULTURA NUMERIC(2,0) NOT NULL,
	CULTURA NVARCHAR(50) NULL,
	CONSTRAINT id_cultura_pk PRIMARY KEY CLUSTERED (ID_CULTURA)
)
GO

CREATE TABLE CURSOLICENCIA
(
	ID_CURSOLICENCIA NUMERIC(1,0) NOT NULL,
	DESCRIPCION NVARCHAR(255) NULL,
	CONSTRAINT id_cursolicencia_pk PRIMARY KEY CLUSTERED (ID_CURSOLICENCIA)
)
GO

CREATE TABLE DEPARTAMENTO
(
	ID_DEPARTAMENTO INT NOT NULL,
	NOMBRE NVARCHAR(350) NULL,
	CONSTRAINT id_departamento_pk PRIMARY KEY CLUSTERED (ID_DEPARTAMENTO)
)
GO

CREATE TABLE DISPONIBILIDADVEHICULOS
(
	ID_ENCUESTA INT NOT NULL,
	ID_VEHICULO NUMERIC(2,0) NOT NULL,
	CANTIDAD NUMERIC(2,0) NULL,
	FACTOR_EXP_CAL TEXT NULL,
	CONSTRAINT id_disponibilidad_pk PRIMARY KEY CLUSTERED (ID_ENCUESTA, ID_VEHICULO)
)
GO

CREATE TABLE RANGOINGRESOS
(
	ID_RANGOINGRESOS INT NOT NULL,
	DESCRIPCION NVARCHAR(50) NOT NULL,
	CONSTRAINT id_rangoingresos_pk PRIMARY KEY CLUSTERED (ID_RANGOINGRESOS)
)
GO

CREATE TABLE TIPOVIVIENDA
(
	ID_TIPOVIVIENDA NUMERIC(1, 0) NOT NULL,
	DESCRIPCION NVARCHAR(20) NOT NULL,
	CONSTRAINT id_tipovivienda_pk PRIMARY KEY CLUSTERED (ID_TIPOVIVIENDA)
)
GO

CREATE TABLE VIVIENDAPROPIA
(
	ID_VIVIENDAPROPIA NUMERIC(1, 0) NOT NULL,
	DESCRIPCION NVARCHAR(50) NOT NULL,
	CONSTRAINT id_viviendapropia_pk PRIMARY KEY CLUSTERED (ID_VIVIENDAPROPIA)
)
GO

CREATE TABLE ENCUESTA
(
	ID_ENCUESTA INT NOT NULL,
	BARRIO NVARCHAR(255) NULL,
	ID_TIPOVIVIENDA NUMERIC(1, 0) NOT NULL,
	ID_VIVIENDAPROPIA NUMERIC(1, 0) NOT NULL,
	NUMERO_HOGARES INT NULL,
	NUMERO_PERSONAS NUMERIC(2, 0) DEFAULT 0 NULL,
	PUNTAJE_SISBEN NUMERIC(10, 0) NULL,
	ID_BENEFICIOSITP NUMERIC(1, 0) NULL,
	FECHA_UPLOAD SMALLDATETIME NULL,
	DURACION NVARCHAR(20) NULL,
	ENCUESTA_COMPLETA NVARCHAR(15) NULL,
	UTCDIF INT NULL,
	ENCUESTADOR_FECHA DATE NULL,
	ENCUESTADOR_HORA NVARCHAR(30) NULL,
	ESTRATO_ENERGIA NUMERIC(1, 0) NULL,
	ESTRATO_ACUEDUCTO NUMERIC(1, 0) NULL,
	ESTRATO_ALCANTARILLADO NUMERIC(1, 0) NULL,
	ESTRATO_RECOLECCION_BASURAS NUMERIC(1, 0) NULL,
	ESTRATO_GAS_NATURAL NUMERIC(1, 0) NULL,
	ID_BENEFICIOSITP2 NUMERIC(1, 0) NULL,
	ID_BENEFICIOSITP3 NUMERIC(1, 0) NULL,
	ID_BENEFICIOSITP4 INT NULL,
	PERSONA1HOGAR INT NULL,
	PERSONA2HOGAR INT NULL,
	PERSONA3HOGAR INT NULL,
	PERSONA4HOGAR INT NULL,
	PERSONA5HOGAR INT NULL,
	PERSONA6HOGAR INT NULL,
	PERSONA7HOGAR INT NULL,
	PERSONA8HOGAR INT NULL,
	PERSONA9HOGAR INT NULL,
	SUPERVISION INT NULL,
	HORA_FIN NVARCHAR(30) NULL,
	FINALIZADA INT NULL,
	SRV_ENERGIA NUMERIC(2, 0) NULL,
	SRV_ACUEDUCTO NUMERIC(1, 0) NULL,
	SRV_ALCANTARILLADO NUMERIC(1, 0) NULL,
	SRV_RECOLECCION_BASURAS NUMERIC(1, 0) NULL,
	SRV_GAS_NATURAL NUMERIC(1, 0) NULL,
	FECHA_PROCESO_BD NVARCHAR(70) NULL,
	COMPLETA_TELEFONICAMENTE INT NULL,
	ID_RANGOINGRESOS INT NULL,
	VEHIC_PERSONAIDONEA INT NULL,
	DIA_SEMANA NVARCHAR(20) NULL,
	ENCUESTA_SISBEN INT NULL,
	CLASIFICACION_SISBEN INT NULL,
	LATITUD_HOGAR NUMERIC(20, 15) NULL,
	LONGITUD_HOGAR NUMERIC(20, 15) NULL,
	ZAT_HOGAR INT NULL,
	PONDERADOR_CALIBRADO TEXT NULL,
	ESTRATO INT NULL,
	FACTOR_AJUSTE NUMERIC(20, 15) NULL,
	PI_K_I NUMERIC(20, 15) NULL,
	PI_K_II NUMERIC(20, 15) NULL,
	PI_K_III NUMERIC(20, 15) NULL,
	FE_TOTAL NUMERIC(20, 15) NULL,
	ID_MANZANA NVARCHAR(20) NULL,
	ID_MUNICIPIO INT NULL,
	CONSTRAINT id_ENCUESTA_pk PRIMARY KEY CLUSTERED (ID_ENCUESTA),
	CONSTRAINT fk_ENCUESTA_tipovivienda FOREIGN KEY (ID_TIPOVIVIENDA) REFERENCES dbo.TIPOVIVIENDA(ID_TIPOVIVIENDA),
	CONSTRAINT fk_ENCUESTA_viviendapropia FOREIGN KEY (ID_VIVIENDAPROPIA) REFERENCES dbo.VIVIENDAPROPIA(ID_VIVIENDAPROPIA),
	CONSTRAINT fk_ENCUESTA_beneficiositp FOREIGN KEY (ID_BENEFICIOSITP) REFERENCES dbo.BENEFICIOSITP(ID_BENEFICIOSITP),
	CONSTRAINT fk_ENCUESTA_rangoingresos FOREIGN KEY (ID_RANGOINGRESOS) REFERENCES dbo.RANGOINGRESOS(ID_RANGOINGRESOS),
)
GO
 CREATE  INDEX idx_ENCUESTA ON dbo.ENCUESTA(ID_MANZANA)
GO
 CREATE  INDEX idx_ENCUESTA_0 ON dbo.ENCUESTA(ID_TIPOVIVIENDA)
GO
 CREATE  INDEX idx_ENCUESTA_1 ON dbo.ENCUESTA(ID_VIVIENDAPROPIA)
GO
 CREATE  INDEX idx_ENCUESTA_2 ON dbo.ENCUESTA(ZAT_HOGAR)
GO
 CREATE  INDEX idx_ENCUESTA_5 ON dbo.ENCUESTA(ID_BENEFICIOSITP)
GO
 CREATE  INDEX idx_ENCUESTA_6 ON dbo.ENCUESTA(ID_RANGOINGRESOS)
GO


CREATE TABLE EXENTOPP
(
	ID_EXENTOPP NUMERIC(2, 0) NOT NULL,
	DESCRIPCION NVARCHAR(50) NULL,
	CONSTRAINT id_exentopp_pk PRIMARY KEY CLUSTERED (ID_EXENTOPP)
)
GO


CREATE TABLE LICENCIACONDUCCION
(
	ID_LICENCIACONDUCCION NUMERIC(1, 0) NOT NULL,
	DESCRIPCION NVARCHAR(70) NULL,
	CONSTRAINT id_licenciaconduccion_pk PRIMARY KEY CLUSTERED (ID_LICENCIACONDUCCION)
)
GO


CREATE TABLE LIMITACIONFISICA
(
	ID_LIMITACIONFISICA NUMERIC(2, 0) NOT NULL,
	LIMITACION NVARCHAR(255) NULL,
	CONSTRAINT id_limitacionfisica_pk PRIMARY KEY CLUSTERED (ID_LIMITACIONFISICA)
)
GO


CREATE TABLE LUGARAGRESION
(
	ID_LUGARAGRESION NUMERIC(2, 0) NOT NULL,
	DESCRIPCION NVARCHAR(70) NULL,
	CONSTRAINT id_lugaragresion_pk PRIMARY KEY CLUSTERED (ID_LUGARAGRESION)
)
GO


CREATE TABLE LUGARPARQUEO
(
	ID_LUGARPARQUEO NUMERIC(2, 0) NOT NULL,
	DESCRIPCION NVARCHAR(50) NULL,
	CONSTRAINT id_lugarparqueo_pk PRIMARY KEY CLUSTERED (ID_LUGARPARQUEO)
)
GO


CREATE TABLE MEDIOPREDOMINANTE
(
	CODIGO NVARCHAR(15) NULL,
	NOMBRE NVARCHAR(30) NULL,
	ID_MEDIOPREDOMINANTE INT NOT NULL,
	CONSTRAINT id_mediopredominante_pk PRIMARY KEY CLUSTERED (ID_MEDIOPREDOMINANTE)
)
GO


CREATE TABLE MEDIOTRASPORTE
(
	ID_MEDIOTRASPORTE NUMERIC(2, 0) NOT NULL,
	DESCRIPCION NVARCHAR(100) NULL,
	CONSTRAINT id_mediotrasporte_pk PRIMARY KEY CLUSTERED (ID_MEDIOTRASPORTE)
)
GO


CREATE TABLE MOTIVONOVEHICULO
(
	ID_MOTIVONOVEHICULO NUMERIC(2, 0) NOT NULL,
	DESCRIPCION NVARCHAR(70) NULL,
	CONSTRAINT id_motivonovehiculo_pk PRIMARY KEY CLUSTERED (ID_MOTIVONOVEHICULO)
)
GO


CREATE TABLE MOTIVOVIAJE
(
	ID_MOTIVOVIAJE NUMERIC(2, 0) NOT NULL,
	DESCRIPCION NVARCHAR(70) NULL,
	CONSTRAINT id_motivoviaje_pk PRIMARY KEY CLUSTERED (ID_MOTIVOVIAJE)
)
GO


CREATE TABLE MUNICIPIO
(
	ID_MUNICIPIO NUMERIC(14, 0) NOT NULL,
	ID_DEPARTAMENTO INT NULL,
	NOMBRE NVARCHAR(350) NOT NULL,
	CODIGO_DANE TEXT NULL,
	CONSTRAINT id_municipio_pk PRIMARY KEY CLUSTERED (ID_MUNICIPIO),
	CONSTRAINT fk_municipio_departamento FOREIGN KEY (ID_DEPARTAMENTO) REFERENCES DEPARTAMENTO(ID_DEPARTAMENTO)
)
GO


CREATE TABLE NIVELEDUCATIVO
(
	ID_NIVELEDUCATIVO NUMERIC(2, 0) NOT NULL,
	NIVEL_EDUCATIVO NVARCHAR(255) NULL,
	CONSTRAINT id_niveleducativo_pk PRIMARY KEY CLUSTERED (ID_NIVELEDUCATIVO)
)
GO


CREATE TABLE NOBICICLETA
(
	ID_NOBICICLETA NUMERIC(2, 0) NOT NULL,
	DESCRIPCION NVARCHAR(70) NULL,
	CONSTRAINT id_nobicicleta_pk PRIMARY KEY CLUSTERED (ID_NOBICICLETA)
)
GO


CREATE TABLE PARENTESCO
(
	ID_PARENTESCO NUMERIC(2, 0) NOT NULL,
	NOMBRE NVARCHAR(50) NULL,
	CONSTRAINT id_parentesco_pk PRIMARY KEY CLUSTERED (ID_PARENTESCO)
)
GO


CREATE TABLE SEXO
(
	ID_SEXO NUMERIC(1, 0) NOT NULL,
	SEXO NVARCHAR(255) NULL,
	CONSTRAINT id_sexo_pk PRIMARY KEY CLUSTERED (ID_SEXO)
)
GO


CREATE TABLE TIPOAGRESION
(
	ID_TIPOAGRESION NUMERIC(2, 0) NOT NULL,
	DESCRIPCION NVARCHAR(70) NULL,
	CONSTRAINT id_tipoagresion_pk PRIMARY KEY CLUSTERED (ID_TIPOAGRESION)
)
GO


CREATE TABLE TIPOCOMBUSTIBLE
(
	ID_TIPOCOMBUSTIBLE NUMERIC(2, 0) NOT NULL,
	DESCRIPCION NVARCHAR(20) NULL,
	CONSTRAINT id_tipocombustible_pk PRIMARY KEY CLUSTERED (ID_TIPOCOMBUSTIBLE)
)
GO


CREATE TABLE TIPOVEHICULO
(
	ID_TIPOVEHICULO NUMERIC(2, 0) NOT NULL,
	DESCRIPCION NVARCHAR(60) NULL,
	CONSTRAINT id_tipovehiculo_pk PRIMARY KEY CLUSTERED (ID_TIPOVEHICULO)
)
GO


CREATE TABLE TRABAJOACTIVIDAD
(
	ID_TRABAJOACTIVIDAD INT NOT NULL,
	NOMBRE NVARCHAR(40) NULL,
	CONSTRAINT id_trabajoactividad_pk PRIMARY KEY CLUSTERED (ID_TRABAJOACTIVIDAD)
)
GO


CREATE TABLE PERSONAS
(
	ID_ENCUESTA INT NOT NULL,
	NUMERO_PERSONA NUMERIC(2, 0) NOT NULL,
	ID_PARENTESCO NUMERIC(2, 0) NULL,
	ID_SEXO NUMERIC(1, 0) NULL,
	EDAD NUMERIC(3, 0) NULL,
	ID_CULTURA NUMERIC(2, 0) NULL,
	ID_NIVELEDUCATIVO NUMERIC(2, 0) NULL,
	ID_ACTIVIDAD NUMERIC(2, 0) NULL,
	ID_ACTIVIDADECONOMICA NUMERIC(2, 0) NULL,
	ASISTE_INSTITUCIONEDUCATIVA INT NULL,
	NUMERO_EMPLEOS NUMERIC(3, 0) NULL,
	LIMITACION_FISICA NUMERIC(2, 0) NULL,
	ID_LIMITACIONFISICA NUMERIC(2, 0) NULL,
	ID_LIMITACIONFISICA2 NUMERIC(2, 0) NULL,
	ID_LIMITACIONFISICA3 NUMERIC(2, 0) NULL,
	ID_MEDIOTRASPORTE3 NUMERIC(2, 0) NULL,
	ID_MEDIOTRASPORTE2 NUMERIC(2, 0) NULL,
	ID_MEDIOTRASPORTE NUMERIC(2, 0) NULL,
	ID_CURSOLICENCIA4 NUMERIC(1, 0) NULL,
	ID_CURSOLICENCIA3 NUMERIC(1, 0) NULL,
	ID_CURSOLICENCIA2 NUMERIC(1, 0) NULL,
	ID_CURSOLICENCIA NUMERIC(1, 0) NULL,
	REALIZO_DESPLAZAMIENTO INT NULL,
	TRABAJO_CASA INT NULL,
	USO_VEHICULOPRIVADO NUMERIC(2, 0) NULL,
	ID_MOTIVONOVEHICULO NUMERIC(2, 0) NULL,
	MOVILIZA_BICICLETA NUMERIC(1, 0) NULL,
	ID_NOBICICLETA1 NUMERIC(2, 0) NULL,
	ID_NOBICICLETA2 NUMERIC(2, 0) NULL,
	ID_NOBICICLETA3 NUMERIC(2, 0) NULL,
	ID_NOBICICLETA4 NUMERIC(2, 0) NULL,
	ID_NOBICICLETA5 NUMERIC(2, 0) NULL,
	ID_NOBICICLETA6 NUMERIC(2, 0) NULL,
	ID_NOBICICLETA7 NUMERIC(2, 0) NULL,
	ID_NOBICICLETA8 NUMERIC(2, 0) NULL,
	ID_NOBICICLETA9 NUMERIC(2, 0) NULL,
	ID_NOBICICLETA10 NUMERIC(2, 0) NULL,
	ID_NOBICICLETA11 NUMERIC(2, 0) NULL,
	ID_NOBICICLETA12 NUMERIC(2, 0) NULL,
	ID_NOBICICLETA13 NUMERIC(2, 0) NULL,
	ID_NOBICICLETA14 NUMERIC(2, 0) NULL,
	ID_NOBICICLETA15 NUMERIC(2, 0) NULL,
	ID_NOBICICLETA16 NUMERIC(2, 0) NULL,
	ID_NOBICICLETA17 NUMERIC(2, 0) NULL,
	REACCION_AUTORIDAD INT NULL,
	ID_TIPOAGRESION1 NUMERIC(2, 0) NULL,
	ID_TIPOAGRESION2 NUMERIC(2, 0) NULL,
	ID_TIPOAGRESION3 NUMERIC(2, 0) NULL,
	ID_TIPOAGRESION4 NUMERIC(2, 0) NULL,
	ID_TIPOAGRESION5 NUMERIC(2, 0) NULL,
	ID_TIPOAGRESION6 NUMERIC(2, 0) NULL,
	ID_TIPOAGRESION7 NUMERIC(2, 0) NULL,
	ID_TIPOAGRESION8 NUMERIC(2, 0) NULL,
	ID_AGRESIONFISICA3 NUMERIC(2, 0) NULL,
	ID_AGRESIONFISICA4 NUMERIC(2, 0) NULL,
	ID_AGRESIONFISICA5 NUMERIC(2, 0) NULL,
	ID_AGRESIONFISICA2 NUMERIC(2, 0) NULL,
	ID_AGRESIONFISICA1 NUMERIC(2, 0) NULL,
	ID_AGRESIONSEXUAL2 NUMERIC(2, 0) NULL,
	ID_AGRESIONSEXUAL1 NUMERIC(2, 0) NULL,
	ID_AGRESIONSEXUAL3 NUMERIC(2, 0) NULL,
	ID_AGRESIONSEXUAL4 NUMERIC(2, 0) NULL,
	ID_LUGARAGRESION NUMERIC(2, 0) NULL,
	ID_TRABAJOACTIVIDAD INT NULL,
	ID_LICENCIACONDUCCION1 NUMERIC(1, 0) NULL,
	ID_LICENCIACONDUCCION2 NUMERIC(1, 0) NULL,
	ID_LICENCIACONDUCCION3 NUMERIC(1, 0) NULL,
	ID_LICENCIACONDUCCION4 NUMERIC(1, 0) NULL,
	VICTIMA_AGRESION INT NULL,
	REG_ANTIGUO NUMERIC(1, 0) DEFAULT 0 NULL,
	PONDERADOR_CALIBRADO TEXT NULL,
	FACTOR_AJUSTE NUMERIC(20, 15) NULL,
	PI_K_I NUMERIC(20, 15) NULL,
	PI_K_II NUMERIC(20, 15) NULL,
	PI_K_III NUMERIC(20, 15) NULL,
	FE_TOTAL NUMERIC(20, 15) NULL,
	CONSTRAINT id_personas_pk PRIMARY KEY CLUSTERED (ID_ENCUESTA, NUMERO_PERSONA),
	CONSTRAINT fk_personas_ENCUESTA FOREIGN KEY (ID_ENCUESTA) REFERENCES ENCUESTA(ID_ENCUESTA),
	CONSTRAINT fk_personas_nobicicleta_1 FOREIGN KEY (ID_NOBICICLETA1) REFERENCES NOBICICLETA(ID_NOBICICLETA),
	CONSTRAINT fk_personas_nobicicleta_2 FOREIGN KEY (ID_NOBICICLETA2) REFERENCES NOBICICLETA(ID_NOBICICLETA),
	CONSTRAINT fk_personas_nobicicleta_3 FOREIGN KEY (ID_NOBICICLETA3) REFERENCES NOBICICLETA(ID_NOBICICLETA),
	CONSTRAINT fk_personas_nobicicleta_4 FOREIGN KEY (ID_NOBICICLETA4) REFERENCES NOBICICLETA(ID_NOBICICLETA),
	CONSTRAINT fk_personas_nobicicleta_5 FOREIGN KEY (ID_NOBICICLETA5) REFERENCES NOBICICLETA(ID_NOBICICLETA),
	CONSTRAINT fk_personas_nobicicleta_6 FOREIGN KEY (ID_NOBICICLETA6) REFERENCES NOBICICLETA(ID_NOBICICLETA),
	CONSTRAINT fk_personas_nobicicleta_7 FOREIGN KEY (ID_NOBICICLETA7) REFERENCES NOBICICLETA(ID_NOBICICLETA),
	CONSTRAINT fk_personas_nobicicleta_8 FOREIGN KEY (ID_NOBICICLETA8) REFERENCES NOBICICLETA(ID_NOBICICLETA),
	CONSTRAINT fk_personas_nobicicleta_9 FOREIGN KEY (ID_NOBICICLETA9) REFERENCES NOBICICLETA(ID_NOBICICLETA),
	CONSTRAINT fk_personas_nobicicleta_10 FOREIGN KEY (ID_NOBICICLETA10) REFERENCES NOBICICLETA(ID_NOBICICLETA),
	CONSTRAINT fk_personas_nobicicleta_11 FOREIGN KEY (ID_NOBICICLETA11) REFERENCES NOBICICLETA(ID_NOBICICLETA),
	CONSTRAINT fk_personas_nobicicleta_12 FOREIGN KEY (ID_NOBICICLETA12) REFERENCES NOBICICLETA(ID_NOBICICLETA),
	CONSTRAINT fk_personas_nobicicleta_13 FOREIGN KEY (ID_NOBICICLETA13) REFERENCES NOBICICLETA(ID_NOBICICLETA),
	CONSTRAINT fk_personas_nobicicleta_14 FOREIGN KEY (ID_NOBICICLETA14) REFERENCES NOBICICLETA(ID_NOBICICLETA),
	CONSTRAINT fk_personas_nobicicleta_15 FOREIGN KEY (ID_NOBICICLETA15) REFERENCES NOBICICLETA(ID_NOBICICLETA),
	CONSTRAINT fk_personas_nobicicleta_16 FOREIGN KEY (ID_NOBICICLETA16) REFERENCES NOBICICLETA(ID_NOBICICLETA),
	CONSTRAINT fk_personas_nobicicleta_17 FOREIGN KEY (ID_NOBICICLETA17) REFERENCES NOBICICLETA(ID_NOBICICLETA),
	CONSTRAINT fk_personas_motivonovehiculo FOREIGN KEY (ID_MOTIVONOVEHICULO) REFERENCES MOTIVONOVEHICULO(ID_MOTIVONOVEHICULO),
	CONSTRAINT fk_personas_parentesco FOREIGN KEY (ID_PARENTESCO) REFERENCES PARENTESCO(ID_PARENTESCO),
	CONSTRAINT fk_personas_sexo FOREIGN KEY (ID_SEXO) REFERENCES SEXO(ID_SEXO),
	CONSTRAINT fk_personas_cultura FOREIGN KEY (ID_CULTURA) REFERENCES CULTURA(ID_CULTURA),
	CONSTRAINT fk_personas_niveleducativo FOREIGN KEY (ID_NIVELEDUCATIVO) REFERENCES NIVELEDUCATIVO(ID_NIVELEDUCATIVO),
	CONSTRAINT fk_personas_actividadeconomica FOREIGN KEY (ID_ACTIVIDADECONOMICA) REFERENCES ACTIVIDADECONOMICA(ID_ACTIVIDADECONOMICA),
	CONSTRAINT fk_personas_actividad FOREIGN KEY (ID_ACTIVIDAD) REFERENCES ACTIVIDAD(ID_ACTIVIDAD),
	CONSTRAINT fk_personas_limitacionfisica FOREIGN KEY (ID_LIMITACIONFISICA) REFERENCES LIMITACIONFISICA(ID_LIMITACIONFISICA),
	CONSTRAINT fk_personas_limitacionfisica_2 FOREIGN KEY (ID_LIMITACIONFISICA2) REFERENCES LIMITACIONFISICA(ID_LIMITACIONFISICA),
	CONSTRAINT fk_personas_limitacionfisica_3 FOREIGN KEY (ID_LIMITACIONFISICA3) REFERENCES LIMITACIONFISICA(ID_LIMITACIONFISICA),
	CONSTRAINT fk_personas_cursolicencia FOREIGN KEY (ID_CURSOLICENCIA) REFERENCES CURSOLICENCIA(ID_CURSOLICENCIA),
	CONSTRAINT fk_personas_cursolicencia_2 FOREIGN KEY (ID_CURSOLICENCIA2) REFERENCES CURSOLICENCIA(ID_CURSOLICENCIA),
	CONSTRAINT fk_personas_cursolicencia_3 FOREIGN KEY (ID_CURSOLICENCIA3) REFERENCES CURSOLICENCIA(ID_CURSOLICENCIA),
	CONSTRAINT fk_personas_cursolicencia_4 FOREIGN KEY (ID_CURSOLICENCIA4) REFERENCES CURSOLICENCIA(ID_CURSOLICENCIA),
	CONSTRAINT fk_personas_mediotrasporte FOREIGN KEY (ID_MEDIOTRASPORTE) REFERENCES MEDIOTRASPORTE(ID_MEDIOTRASPORTE),
	CONSTRAINT fk_personas_mediotrasporte_2 FOREIGN KEY (ID_MEDIOTRASPORTE2) REFERENCES MEDIOTRASPORTE(ID_MEDIOTRASPORTE),
	CONSTRAINT fk_personas_mediotrasporte_3 FOREIGN KEY (ID_MEDIOTRASPORTE3) REFERENCES MEDIOTRASPORTE(ID_MEDIOTRASPORTE),
	CONSTRAINT fk_personas_tipoagresion_1 FOREIGN KEY (ID_TIPOAGRESION1) REFERENCES TIPOAGRESION(ID_TIPOAGRESION),
	CONSTRAINT fk_personas_tipoagresion_2 FOREIGN KEY (ID_TIPOAGRESION2) REFERENCES TIPOAGRESION(ID_TIPOAGRESION),
	CONSTRAINT fk_personas_tipoagresion_3 FOREIGN KEY (ID_TIPOAGRESION3) REFERENCES TIPOAGRESION(ID_TIPOAGRESION),
	CONSTRAINT fk_personas_tipoagresion_4 FOREIGN KEY (ID_TIPOAGRESION4) REFERENCES TIPOAGRESION(ID_TIPOAGRESION),
	CONSTRAINT fk_personas_tipoagresion_5 FOREIGN KEY (ID_TIPOAGRESION5) REFERENCES TIPOAGRESION(ID_TIPOAGRESION),
	CONSTRAINT fk_personas_tipoagresion_6 FOREIGN KEY (ID_TIPOAGRESION6) REFERENCES TIPOAGRESION(ID_TIPOAGRESION),
	CONSTRAINT fk_personas_tipoagresion_7 FOREIGN KEY (ID_TIPOAGRESION7) REFERENCES TIPOAGRESION(ID_TIPOAGRESION),
	CONSTRAINT fk_personas_tipoagresion_8 FOREIGN KEY (ID_TIPOAGRESION8) REFERENCES TIPOAGRESION(ID_TIPOAGRESION),
	CONSTRAINT fk_personas_agresionfisica_1 FOREIGN KEY (ID_AGRESIONFISICA1) REFERENCES AGRESIONFISICA(ID_AGRESIONFISICA),
	CONSTRAINT fk_personas_agresionfisica_2 FOREIGN KEY (ID_AGRESIONFISICA2) REFERENCES AGRESIONFISICA(ID_AGRESIONFISICA),
	CONSTRAINT fk_personas_agresionfisica_3 FOREIGN KEY (ID_AGRESIONFISICA3) REFERENCES AGRESIONFISICA(ID_AGRESIONFISICA),
	CONSTRAINT fk_personas_agresionfisica_4 FOREIGN KEY (ID_AGRESIONFISICA4) REFERENCES AGRESIONFISICA(ID_AGRESIONFISICA),
	CONSTRAINT fk_personas_agresionfisica_5 FOREIGN KEY (ID_AGRESIONFISICA5) REFERENCES AGRESIONFISICA(ID_AGRESIONFISICA),
	CONSTRAINT fk_personas_agresionsexual_1 FOREIGN KEY (ID_AGRESIONSEXUAL1) REFERENCES AGRESIONSEXUAL(ID_AGRESIONSEXUAL),
	CONSTRAINT fk_personas_agresionsexual_2 FOREIGN KEY (ID_AGRESIONSEXUAL2) REFERENCES AGRESIONSEXUAL(ID_AGRESIONSEXUAL),
	CONSTRAINT fk_personas_agresionsexual_3 FOREIGN KEY (ID_AGRESIONSEXUAL3) REFERENCES AGRESIONSEXUAL(ID_AGRESIONSEXUAL),
	CONSTRAINT fk_personas_agresionsexual_4 FOREIGN KEY (ID_AGRESIONSEXUAL4) REFERENCES AGRESIONSEXUAL(ID_AGRESIONSEXUAL),
	CONSTRAINT fk_personas_lugaragresion FOREIGN KEY (ID_LUGARAGRESION) REFERENCES LUGARAGRESION(ID_LUGARAGRESION),
	CONSTRAINT fk_personas_trabajoactividad FOREIGN KEY (ID_TRABAJOACTIVIDAD) REFERENCES TRABAJOACTIVIDAD(ID_TRABAJOACTIVIDAD),
	CONSTRAINT fk_personas_licenciaconduccion_1 FOREIGN KEY (ID_LICENCIACONDUCCION1) REFERENCES LICENCIACONDUCCION(ID_LICENCIACONDUCCION),
	CONSTRAINT fk_personas_licenciaconduccion_2 FOREIGN KEY (ID_LICENCIACONDUCCION2) REFERENCES LICENCIACONDUCCION(ID_LICENCIACONDUCCION),
	CONSTRAINT fk_personas_licenciaconduccion_3 FOREIGN KEY (ID_LICENCIACONDUCCION3) REFERENCES LICENCIACONDUCCION(ID_LICENCIACONDUCCION),
	CONSTRAINT fk_personas_licenciaconduccion_4 FOREIGN KEY (ID_LICENCIACONDUCCION4) REFERENCES LICENCIACONDUCCION(ID_LICENCIACONDUCCION),
)
GO
CREATE INDEX idx_personas ON dbo.PERSONAS(ID_NOBICICLETA1)
GO
CREATE INDEX idx_personas_0 ON dbo.PERSONAS(ID_NOBICICLETA2)
GO
CREATE INDEX idx_personas_1 ON dbo.PERSONAS(ID_NOBICICLETA3)
GO
CREATE INDEX idx_personas_2 ON dbo.PERSONAS(ID_NOBICICLETA4)
GO
CREATE INDEX idx_personas_3 ON dbo.PERSONAS(ID_NOBICICLETA5)
GO
CREATE INDEX idx_personas_4 ON dbo.PERSONAS(ID_NOBICICLETA6)
GO
CREATE INDEX idx_personas_5 ON dbo.PERSONAS(ID_NOBICICLETA7)
GO
CREATE INDEX idx_personas_6 ON dbo.PERSONAS(ID_NOBICICLETA8)
GO
CREATE INDEX idx_personas_7 ON dbo.PERSONAS(ID_NOBICICLETA9)
GO
CREATE INDEX idx_personas_8 ON dbo.PERSONAS(ID_NOBICICLETA10)
GO
CREATE INDEX idx_personas_9 ON dbo.PERSONAS(ID_NOBICICLETA11)
GO
CREATE INDEX idx_personas_10 ON dbo.PERSONAS(ID_NOBICICLETA12)
GO
CREATE INDEX idx_personas_11 ON dbo.PERSONAS(ID_NOBICICLETA13)
GO
CREATE INDEX idx_personas_12 ON dbo.PERSONAS(ID_NOBICICLETA14)
GO
CREATE INDEX idx_personas_13 ON dbo.PERSONAS(ID_NOBICICLETA15)
GO
CREATE INDEX idx_personas_14 ON dbo.PERSONAS(ID_NOBICICLETA16)
GO
CREATE INDEX idx_personas_15 ON dbo.PERSONAS(ID_NOBICICLETA17)
GO
CREATE INDEX idx_personas_16 ON dbo.PERSONAS(ID_MOTIVONOVEHICULO)
GO
CREATE INDEX idx_personas_17 ON dbo.PERSONAS(ID_PARENTESCO)
GO
CREATE INDEX idx_personas_18 ON dbo.PERSONAS(ID_SEXO)
GO
CREATE INDEX idx_personas_19 ON dbo.PERSONAS(ID_CULTURA)
GO
CREATE INDEX idx_personas_20 ON dbo.PERSONAS(ID_NIVELEDUCATIVO)
GO
CREATE INDEX idx_personas_21 ON dbo.PERSONAS(ID_ACTIVIDADECONOMICA)
GO
CREATE INDEX idx_personas_22 ON dbo.PERSONAS(ID_ACTIVIDAD)
GO
CREATE INDEX idx_personas_23 ON dbo.PERSONAS(ID_LIMITACIONFISICA)
GO
CREATE INDEX idx_personas_24 ON dbo.PERSONAS(ID_LIMITACIONFISICA2)
GO
CREATE INDEX idx_personas_25 ON dbo.PERSONAS(ID_LIMITACIONFISICA3)
GO
CREATE INDEX idx_personas_26 ON dbo.PERSONAS(ID_CURSOLICENCIA)
GO
CREATE INDEX idx_personas_27 ON dbo.PERSONAS(ID_CURSOLICENCIA2)
GO
CREATE INDEX idx_personas_28 ON dbo.PERSONAS(ID_CURSOLICENCIA3)
GO
CREATE INDEX idx_personas_29 ON dbo.PERSONAS(ID_CURSOLICENCIA4)
GO
CREATE INDEX idx_personas_30 ON dbo.PERSONAS(ID_MEDIOTRASPORTE)
GO
CREATE INDEX idx_personas_31 ON dbo.PERSONAS(ID_MEDIOTRASPORTE2)
GO
CREATE INDEX idx_personas_32 ON dbo.PERSONAS(ID_MEDIOTRASPORTE3)
GO
CREATE INDEX idx_personas_33 ON dbo.PERSONAS(ID_TIPOAGRESION1)
GO
CREATE INDEX idx_personas_34 ON dbo.PERSONAS(ID_TIPOAGRESION2)
GO
CREATE INDEX idx_personas_35 ON dbo.PERSONAS(ID_TIPOAGRESION3)
GO
CREATE INDEX idx_personas_36 ON dbo.PERSONAS(ID_TIPOAGRESION4)
GO
CREATE INDEX idx_personas_37 ON dbo.PERSONAS(ID_TIPOAGRESION5)
GO
CREATE INDEX idx_personas_38 ON dbo.PERSONAS(ID_TIPOAGRESION6)
GO
CREATE INDEX idx_personas_39 ON dbo.PERSONAS(ID_TIPOAGRESION7)
GO
CREATE INDEX idx_personas_40 ON dbo.PERSONAS(ID_TIPOAGRESION8)
GO
CREATE INDEX idx_personas_41 ON dbo.PERSONAS(ID_AGRESIONFISICA1)
GO
CREATE INDEX idx_personas_42 ON dbo.PERSONAS(ID_AGRESIONFISICA2)
GO
CREATE INDEX idx_personas_43 ON dbo.PERSONAS(ID_AGRESIONFISICA3)
GO
CREATE INDEX idx_personas_44 ON dbo.PERSONAS(ID_AGRESIONFISICA4)
GO
CREATE INDEX idx_personas_45 ON dbo.PERSONAS(ID_AGRESIONFISICA5)
GO
CREATE INDEX idx_personas_46 ON dbo.PERSONAS(ID_AGRESIONSEXUAL1)
GO
CREATE INDEX idx_personas_47 ON dbo.PERSONAS(ID_AGRESIONSEXUAL2)
GO
CREATE INDEX idx_personas_48 ON dbo.PERSONAS(ID_AGRESIONSEXUAL3)
GO
CREATE INDEX idx_personas_49 ON dbo.PERSONAS(ID_AGRESIONSEXUAL4)
GO
CREATE INDEX idx_personas_50 ON dbo.PERSONAS(ID_LUGARAGRESION)
GO
CREATE INDEX idx_personas_51 ON dbo.PERSONAS(ID_TRABAJOACTIVIDAD)
GO
CREATE INDEX idx_personas_52 ON dbo.PERSONAS(ID_LICENCIACONDUCCION1)
GO
CREATE INDEX idx_personas_53 ON dbo.PERSONAS(ID_LICENCIACONDUCCION2)
GO
CREATE INDEX idx_personas_54 ON dbo.PERSONAS(ID_LICENCIACONDUCCION3)
GO
CREATE INDEX idx_personas_55 ON dbo.PERSONAS(ID_LICENCIACONDUCCION4)
GO

CREATE TABLE VIAJES1
(
	ID_ENCUESTA INT,
	NUMERO_PERSONA NUMERIC(2, 0),
	NUMERO_VIAJE NUMERIC(2, 0),
	ID_MOTIVOVIAJE NUMERIC(2, 0),
	ID_MUNICIPIODESTINO NUMERIC(14, 0),
	TIEMPO_CAMINO INT,
	HORA_INICIO TIME,
	HORA_FIN TIME,
	ID_MEDIOPREDOMINANTE INT,
	ZAT_DESTINO INT,
	ZAT_ORIGEN INT,
	ID_MUNICIPIOORIGEN NUMERIC(14, 0),
	LATITUD_ORIGEN NUMERIC(20, 15),
	LATITUD_DESTINO NUMERIC(20, 15),
	LONGITUD_ORIGEN NUMERIC(20, 15),
	LONGITUD_DESTINO NUMERIC(20, 15),
	IMPUTACION BIT DEFAULT 0,
	DIFERENCIA_HORAS TIME,
	ID INT,
	FACTOR_AJUSTE NUMERIC(20, 15),
	PONDERADOR_CALIBRADO NUMERIC(20, 15),
	DIA_HABIL INT,
	DIA_NOHABIL INT,
	PICO_HABIL INT,
	PICO_NOHABIL INT,
	VALLE_NOHABIL INT,
	VALLE_HABIL INT,
	PI_K_I NUMERIC(20, 15),
	PI_K_II NUMERIC(20, 15),
	PI_K_III NUMERIC(20, 15),
	FE_TOTAL NUMERIC(20, 15),
	FACTOR_AJUSTE_TRANSMILENIO NUMERIC(20, 15),
	PONDERADOR_CALIBRADO_VIAJES NUMERIC(20, 15),
)
GO
CREATE TABLE VIAJES2
(
	ID_ENCUESTA INT,
	NUMERO_PERSONA NUMERIC(2, 0),
	NUMERO_VIAJE NUMERIC(2, 0),
	ID_MOTIVOVIAJE NUMERIC(2, 0),
	ID_MUNICIPIODESTINO NUMERIC(14, 0),
	TIEMPO_CAMINO INT,
	HORA_INICIO TIME,
	HORA_FIN TIME,
	ID_MEDIOPREDOMINANTE INT,
	ZAT_DESTINO INT,
	ZAT_ORIGEN INT,
	ID_MUNICIPIOORIGEN NUMERIC(14, 0),
	LATITUD_ORIGEN NUMERIC(20, 15),
	LATITUD_DESTINO NUMERIC(20, 15),
	LONGITUD_ORIGEN NUMERIC(20, 15),
	LONGITUD_DESTINO NUMERIC(20, 15),
	IMPUTACION BIT DEFAULT 0,
	DIFERENCIA_HORAS TIME,
	ID INT,
	FACTOR_AJUSTE NUMERIC(20, 15),
	PONDERADOR_CALIBRADO NUMERIC(20, 15),
	DIA_HABIL INT,
	DIA_NOHABIL INT,
	PICO_HABIL INT,
	PICO_NOHABIL INT,
	VALLE_NOHABIL INT,
	VALLE_HABIL INT,
	PI_K_I NUMERIC(20, 15),
	PI_K_II NUMERIC(20, 15),
	PI_K_III NUMERIC(20, 15),
	FE_TOTAL NUMERIC(20, 15),
	FACTOR_AJUSTE_TRANSMILENIO NUMERIC(20, 15),
	PONDERADOR_CALIBRADO_VIAJES NUMERIC(20, 15),
)
GO
CREATE TABLE VIAJES
(
	ID_ENCUESTA INT,
	NUMERO_PERSONA NUMERIC(2, 0),
	NUMERO_VIAJE NUMERIC(2, 0),
	ID_MOTIVOVIAJE NUMERIC(2, 0),
	ID_MUNICIPIODESTINO NUMERIC(14, 0),
	TIEMPO_CAMINO INT,
	HORA_INICIO TIME,
	HORA_FIN TIME,
	ID_MEDIOPREDOMINANTE INT,
	ZAT_DESTINO INT,
	ZAT_ORIGEN INT,
	ID_MUNICIPIOORIGEN NUMERIC(14, 0),
	LATITUD_ORIGEN NUMERIC(20, 15),
	LATITUD_DESTINO NUMERIC(20, 15),
	LONGITUD_ORIGEN NUMERIC(20, 15),
	LONGITUD_DESTINO NUMERIC(20, 15),
	IMPUTACION BIT DEFAULT 0,
	DIFERENCIA_HORAS TIME,
	ID INT,
	FACTOR_AJUSTE NUMERIC(20, 15),
	PONDERADOR_CALIBRADO NUMERIC(20, 15),
	DIA_HABIL INT,
	DIA_NOHABIL INT,
	PICO_HABIL INT,
	PICO_NOHABIL INT,
	VALLE_NOHABIL INT,
	VALLE_HABIL INT,
	PI_K_I NUMERIC(20, 15),
	PI_K_II NUMERIC(20, 15),
	PI_K_III NUMERIC(20, 15),
	FE_TOTAL NUMERIC(20, 15),
	FACTOR_AJUSTE_TRANSMILENIO NUMERIC(20, 15),
	PONDERADOR_CALIBRADO_VIAJES NUMERIC(20, 15),
	CONSTRAINT viajes_pk PRIMARY KEY CLUSTERED (ID_ENCUESTA, NUMERO_PERSONA, NUMERO_VIAJE, ID_MOTIVOVIAJE),
	CONSTRAINT fk_viajes_personas FOREIGN KEY (ID_ENCUESTA, NUMERO_PERSONA) REFERENCES dbo.PERSONAS(ID_ENCUESTA, NUMERO_PERSONA),
	CONSTRAINT fk_viajes_motivoviaje FOREIGN KEY (ID_MOTIVOVIAJE) REFERENCES dbo.MOTIVOVIAJE(ID_MOTIVOVIAJE),
	CONSTRAINT fk_viajes_municipio_destino FOREIGN KEY (ID_MUNICIPIODESTINO) REFERENCES dbo.MUNICIPIO(ID_MUNICIPIO),
	CONSTRAINT fk_viajes_municipio_origen FOREIGN KEY (ID_MUNICIPIOORIGEN) REFERENCES dbo.MUNICIPIO(ID_MUNICIPIO),
	CONSTRAINT fk_viajes_mediopredominante FOREIGN KEY (ID_MEDIOPREDOMINANTE) REFERENCES dbo.MEDIOPREDOMINANTE(ID_MEDIOPREDOMINANTE)
)
GO
CREATE INDEX idx_viajes ON dbo.VIAJES(ID_ENCUESTA, NUMERO_PERSONA)
GO
CREATE INDEX idx_viajes_0 ON dbo.VIAJES(ID_MOTIVOVIAJE)
GO
CREATE INDEX idx_viajes_1 ON dbo.VIAJES(ID_MUNICIPIODESTINO)
GO
CREATE INDEX idx_viajes_2 ON dbo.VIAJES(ID_MEDIOPREDOMINANTE)
GO
CREATE INDEX idx_viajes_3 ON dbo.VIAJES(ID_MUNICIPIOORIGEN)
GO

CREATE TABLE ETAPAS1
(
	ID_ENCUESTA INT NOT NULL,
	NUMERO_PERSONA NUMERIC(2, 0) NOT NULL,
	NUMERO_VIAJE NUMERIC(2, 0) NOT NULL,
	NUMERO_ETAPA NUMERIC(2, 0) NOT NULL,
	ID_MEDIOTRASPORTE NUMERIC(2, 0) NULL,
	ID_MINUCIPIO NUMERIC(2, 0) NULL,
	MINUTOS INTEGER NULL,
	CUADRAS INTEGER NULL,
	MINUTO_ESPERA INTEGER NULL,
	COSTO_PASAJE INTEGER NULL,
	PARADERO NVARCHAR(255) NULL,
	RUTA NVARCHAR(255) NULL,
	VEHICULO_HOGAR INTEGER NULL,
	ESTACION_VEHICULO NVARCHAR(255) NULL,
	CUANTIA_PAGO INTEGER NULL,
	MODALIDAD_PAGO INTEGER NULL,
	DESCENSO NVARCHAR(255) NULL,
	ID_MUNICIPIO_DESCENSO INTEGER NULL,
	IMPUTACION BIT DEFAULT 0 NULL,
	ID BIGINT NULL,
	PONDERADOR_CALIBRADO NUMERIC(20, 15) NULL,
	FACTOR_AJUSTE NUMERIC(20, 15) NULL,
	ETAPAS NUMERIC(20, 15) NULL,
	IDET NVARCHAR(12) NULL,
	PI_K_I NUMERIC(20, 15) NULL,
	PI_K_II NUMERIC(20, 15) NULL,
	PI_K_III NUMERIC(20, 15) NULL,
	FE_TOTAL NUMERIC(20, 15) NULL,
	FACTOR_AJUSTE_TRANSMILENIO NUMERIC(20, 15) NULL,
	PONDERADOR_CALIBRADO_VIAJES NUMERIC(20, 15) NULL,
	CONSTRAINT numero_etapa_chk1 CHECK (NUMERO_ETAPA > 0),
	CONSTRAINT numero_persona_chk1 CHECK (NUMERO_PERSONA > 0),
	CONSTRAINT numero_viaje_chk1 CHECK (NUMERO_VIAJE > 0)
)
GO
CREATE TABLE ETAPAS2
(
	ID_ENCUESTA INT NOT NULL,
	NUMERO_PERSONA NUMERIC(2, 0) NOT NULL,
	NUMERO_VIAJE NUMERIC(2, 0) NOT NULL,
	NUMERO_ETAPA NUMERIC(2, 0) NOT NULL,
	ID_MEDIOTRASPORTE NUMERIC(2, 0) NULL,
	ID_MINUCIPIO NUMERIC(2, 0) NULL,
	MINUTOS INTEGER NULL,
	CUADRAS INTEGER NULL,
	MINUTO_ESPERA INTEGER NULL,
	COSTO_PASAJE INTEGER NULL,
	PARADERO NVARCHAR(255) NULL,
	RUTA NVARCHAR(255) NULL,
	VEHICULO_HOGAR INTEGER NULL,
	ESTACION_VEHICULO NVARCHAR(255) NULL,
	CUANTIA_PAGO INTEGER NULL,
	MODALIDAD_PAGO INTEGER NULL,
	DESCENSO NVARCHAR(255) NULL,
	ID_MUNICIPIO_DESCENSO INTEGER NULL,
	IMPUTACION BIT DEFAULT 0 NULL,
	ID BIGINT NULL,
	PONDERADOR_CALIBRADO NUMERIC(20, 15) NULL,
	FACTOR_AJUSTE NUMERIC(20, 15) NULL,
	ETAPAS NUMERIC(20, 15) NULL,
	IDET NVARCHAR(12) NULL,
	PI_K_I NUMERIC(20, 15) NULL,
	PI_K_II NUMERIC(20, 15) NULL,
	PI_K_III NUMERIC(20, 15) NULL,
	FE_TOTAL NUMERIC(20, 15) NULL,
	FACTOR_AJUSTE_TRANSMILENIO NUMERIC(20, 15) NULL,
	PONDERADOR_CALIBRADO_VIAJES NUMERIC(20, 15) NULL,
	CONSTRAINT numero_etapa_chk2 CHECK (NUMERO_ETAPA > 0),
	CONSTRAINT numero_persona_chk2 CHECK (NUMERO_PERSONA > 0),
	CONSTRAINT numero_viaje_chk2 CHECK (NUMERO_VIAJE > 0)
)
GO
CREATE TABLE ETAPAS
(
	ID_ENCUESTA INT NOT NULL,
	NUMERO_PERSONA NUMERIC(2, 0) NOT NULL,
	NUMERO_VIAJE NUMERIC(2, 0) NOT NULL,
	NUMERO_ETAPA NUMERIC(2, 0) NOT NULL,
	ID_MEDIOTRASPORTE NUMERIC(2, 0) NULL,
	ID_MINUCIPIO NUMERIC(2, 0) NULL,
	MINUTOS INTEGER NULL,
	CUADRAS INTEGER NULL,
	MINUTO_ESPERA INTEGER NULL,
	COSTO_PASAJE INTEGER NULL,
	PARADERO NVARCHAR(255) NULL,
	RUTA NVARCHAR(255) NULL,
	VEHICULO_HOGAR INTEGER NULL,
	ESTACION_VEHICULO NVARCHAR(255) NULL,
	CUANTIA_PAGO INTEGER NULL,
	MODALIDAD_PAGO INTEGER NULL,
	DESCENSO NVARCHAR(255) NULL,
	ID_MUNICIPIO_DESCENSO INTEGER NULL,
	IMPUTACION BIT DEFAULT 0 NULL,
	ID BIGINT NULL,
	PONDERADOR_CALIBRADO NUMERIC(20, 15) NULL,
	FACTOR_AJUSTE NUMERIC(20, 15) NULL,
	ETAPAS NUMERIC(20, 15) NULL,
	IDET NVARCHAR(12) NULL,
	PI_K_I NUMERIC(20, 15) NULL,
	PI_K_II NUMERIC(20, 15) NULL,
	PI_K_III NUMERIC(20, 15) NULL,
	FE_TOTAL NUMERIC(20, 15) NULL,
	FACTOR_AJUSTE_TRANSMILENIO NUMERIC(20, 15) NULL,
	PONDERADOR_CALIBRADO_VIAJES NUMERIC(20, 15) NULL,
	CONSTRAINT id_etapas_pk PRIMARY KEY CLUSTERED (ID_ENCUESTA, NUMERO_PERSONA, NUMERO_VIAJE, NUMERO_ETAPA),
	CONSTRAINT numero_etapa_chk CHECK (NUMERO_ETAPA > 0),
	CONSTRAINT numero_persona_chk CHECK (NUMERO_PERSONA > 0),
	CONSTRAINT numero_viaje_chk CHECK (NUMERO_VIAJE > 0)
)
GO
CREATE INDEX idx_etapas ON dbo.ETAPAS(ID_ENCUESTA, NUMERO_PERSONA, NUMERO_VIAJE)
GO


CREATE TABLE VEHICULOS
(
	ID_ENCUESTA INT NOT NULL,
	ID_VEHICULO INT NOT NULL,
	ID_TIPOVEHICULO NUMERIC(2, 0) NULL,
	ID_TIPOCOMBUSTIBLE NUMERIC(2, 0) NULL,
	MUNICIPIO_MATRICULA NVARCHAR(64) NULL,
	PERTENECE_VEHICULO NUMERIC(2, 0) NULL,
	PERSONA_DUENOVEHICULO NUMERIC(2, 0) NULL,
	EXENTO_PICOYPLACA NUMERIC(2, 0) NULL,
	ID_EXENTOPP NUMERIC(2, 0) NULL,
	ID_LUGARPARQUEO NUMERIC(2, 0) NULL,
	VALOR_PARQUEO INT NULL,
	CONSTRAINT id_vehiculos PRIMARY KEY CLUSTERED (ID_ENCUESTA, ID_VEHICULO),
	CONSTRAINT fk_vehiculos_ENCUESTA FOREIGN KEY (ID_ENCUESTA) REFERENCES ENCUESTA(ID_ENCUESTA),
	CONSTRAINT fk_vehiculos_tipovehiculo FOREIGN KEY (ID_TIPOVEHICULO) REFERENCES TIPOVEHICULO(ID_TIPOVEHICULO),
	CONSTRAINT fk_vehiculos_tipocombustible FOREIGN KEY (ID_TIPOCOMBUSTIBLE) REFERENCES TIPOCOMBUSTIBLE(ID_TIPOCOMBUSTIBLE),
	CONSTRAINT fk_vehiculos_lugarparqueo FOREIGN KEY (ID_LUGARPARQUEO) REFERENCES LUGARPARQUEO(ID_LUGARPARQUEO),
	CONSTRAINT fk_vehiculos_exentopp FOREIGN KEY (ID_EXENTOPP) REFERENCES EXENTOPP(ID_EXENTOPP)
)
GO
CREATE INDEX idx_vehiculos ON dbo.VEHICULOS(ID_ENCUESTA)
GO
CREATE INDEX idx_vehiculos_0 ON dbo.VEHICULOS(ID_TIPOVEHICULO)
GO
CREATE INDEX idx_vehiculos_1 ON dbo.VEHICULOS(ID_TIPOCOMBUSTIBLE)
GO
CREATE INDEX idx_vehiculos_2 ON dbo.VEHICULOS(ID_LUGARPARQUEO)
GO
CREATE INDEX idx_vehiculos_3 ON dbo.VEHICULOS(ID_EXENTOPP)
GO


CREATE TABLE LOCALIDAD
(
	ID_LOCALIDAD NVARCHAR(2) NOT NULL,
	NOMBRE NVARCHAR(30) NULL,
	CONSTRAINT id_localidad PRIMARY KEY CLUSTERED (ID_LOCALIDAD)
)
GO


CREATE TABLE MANZANASMUESTRA
(
	COD14 NVARCHAR(14) NOT NULL,
)
GO
CREATE INDEX idx_manzanasmuestra ON dbo.MANZANASMUESTRA(COD14)


CREATE TABLE ZAT
(
	ZAT INT NOT NULL,
	ID_LOCALIDAD NVARCHAR(2) NULL,
	ID_MUNICIPIO INT NOT NULL,
	LATITUD NUMERIC(20, 15) NULL,
	LONGITUD NUMERIC(20, 15) NULL,
	CONSTRAINT zat_localidad_pk PRIMARY KEY CLUSTERED (ZAT, ID_MUNICIPIO),
	CONSTRAINT fk_zat_localidad FOREIGN KEY (ID_LOCALIDAD) REFERENCES LOCALIDAD(ID_LOCALIDAD)
)
GO
CREATE INDEX idx_zat ON dbo.ZAT(ID_LOCALIDAD)
GO


CREATE TABLE MANZANASTOTAL
(
	ID_MANZANASTOTAL NVARCHAR(14) NOT NULL,
	CODANE_DEPTO NVARCHAR(2) NULL,
	COD_MUNICIPIO NVARCHAR(3) NULL,
	CODANE NVARCHAR(5) NULL,
	ID_MUNICIPIO INTEGER NOT NULL,
	SECTOR INT NULL,
	SECCION INT NULL,
	MANZANA INT NULL,
	ZAT INT NOT NULL,
	MUESTRA INT NULL,
	LATITUD NUMERIC(20, 15) NULL,
	LONGITUD NUMERIC(20, 15) NULL,
	CONSTRAINT manzanastotal_pk PRIMARY KEY CLUSTERED (ID_MANZANASTOTAL),
	CONSTRAINT fk_manzanastotal_zat FOREIGN KEY (ZAT, ID_MUNICIPIO) REFERENCES dbo.ZAT(ZAT, ID_MUNICIPIO)
)
GO
CREATE INDEX idx_manzanastotal ON dbo.MANZANASTOTAL(ZAT, ID_MUNICIPIO)
GO


CREATE TABLE NOEFECTIVAS
(
	ID_ENCUESTA INT NOT NULL,
	CONTACTO INT NOT NULL,
	RESULTADO INT NULL,
	CONSTRAINT id_noefectivas_pk PRIMARY KEY CLUSTERED (ID_ENCUESTA, CONTACTO),
	CONSTRAINT fk_noefectivas_ENCUESTA FOREIGN KEY (ID_ENCUESTA) REFERENCES ENCUESTA(ID_ENCUESTA)
)
GO


--Insert Values


CREATE TABLE INTERN_EXTERN_NAMES (rn INT, Intern NVARCHAR(100), Extern NVARCHAR(100))
INSERT INTO INTERN_EXTERN_NAMES
VALUES
(1, 'ACTIVIDAD', 'ACTIVIDAD.csv'),
(2, 'ACTIVIDADECONOMICA', 'ACTIVIDADECONOMICA.csv'),
(3, 'AGRESIONFISICA', 'AGRESIONFISICA.csv'),
(4, 'AGRESIONSEXUAL', 'AGRESIONSEXUAL.csv'),
(5, 'BENEFICIOSITP', 'BENEFICIOSITP.csv'),
(6, 'CONTACTOS', 'CONTACTOS.csv'),
(7, 'CULTURA', 'CULTURA.csv'),
(8, 'CURSOLICENCIA', 'CURSOLICENCIA.csv'),
(9, 'DEPARTAMENTO', 'DEPARTAMENTO.csv'),
(10, 'DISPONIBILIDADVEHICULOS', 'DISPONIBILIDAD_VEHICULOS.csv'),
(11, 'ENCUESTA', 'ENCUESTAS_ANONIMIZADO.csv'),
(12, 'ETAPAS1', 'ETAPAS1.csv'),
(13, 'ETAPAS2', 'ETAPAS2.csv'),
(14, 'EXENTOPP', 'EXENTO_PP.csv'),
(15, 'LICENCIACONDUCCION', 'LICENCIACONDUCCION.csv'),
(16, 'LIMITACIONFISICA', 'LIMITACIONFISICA.csv'),
(17, 'LOCALIDAD', 'LOCALIDAD.csv'),
(18, 'LUGARAGRESION', 'LUGARAGRESION.csv'),
(19, 'LUGARPARQUEO', 'LUGARPARQUEO.csv'),
(20, 'MANZANASMUESTRA', 'MANZANAS_MUESTRA.csv'),
(21, 'MANZANASTOTAL', 'MANZANAS_TOTAL.csv'),
(22, 'MEDIOTRASPORTE', 'MEDIOTRASPORTE.csv'),
(23, 'MEDIOPREDOMINANTE', 'MEDIO_PREDOMINANTE.csv'),
(24, 'MOTIVONOVEHICULO', 'MOTIVONOVEHICULO.csv'),
(25, 'MOTIVOVIAJE', 'MOTIVOVIAJE.csv'),
(26, 'MUNICIPIO', 'MUNICIPIO.csv'),
(27, 'NIVELEDUCATIVO', 'NIVELEDUCATIVO.csv'),
(28, 'NOBICICLETA', 'NOBICICLETA.csv'),
(29, 'NOEFECTIVAS', 'NOEFECTIVAS.csv'),
(30, 'PARENTESCO', 'PARENTESCO.csv'),
(31, 'PERSONAS', 'PERSONAS_ANONIMIZADO.csv'),
(32, 'RANGOINGRESOS', 'RANGOINGRESOS.csv'),
(33, 'SEXO', 'SEXO.csv'),
(34, 'TIPOAGRESION', 'TIPOAGRESION.csv'),
(35, 'TIPOCOMBUSTIBLE', 'TIPOCOMBUSTIBLE.csv'),
(36, 'TIPOVEHICULO', 'TIPOVEHICULO.csv'),
(37, 'TIPOVIVIENDA', 'TIPOVIVIENDA.csv'),
(38, 'TRABAJOACTIVIDAD', 'TRABAJOACTIVIDAD.csv'),
(39, 'VEHICULOS', 'VEHICULOS.csv'),
(40, 'VIAJES1', 'VIAJES_ANONIMIZADOS1.csv'),
(41, 'VIAJES2', 'VIAJES_ANONIMIZADOS2.csv'),
(42, 'VIVIENDAPROPIA', 'VIVIENDAPROPIA.csv'),
(43, 'ZAT', 'ZAT_LOCALIDAD.csv')
GO

CREATE PROCEDURE OBT_INT (@rn INT, @result1 NVARCHAR(100) OUTPUT)
AS
	SELECT @result1 = Intern FROM INTERN_EXTERN_NAMES WHERE rn = @rn
GO

CREATE PROCEDURE OBT_EXT (@rn INT, @result2 NVARCHAR(100) OUTPUT)
AS
	SELECT @result2 = Extern FROM INTERN_EXTERN_NAMES WHERE rn = @rn
GO


DECLARE @device_directory NVARCHAR(500)
DECLARE @n INT
DECLARE @i INT = 1
DECLARE @query_directory NVARCHAR(200)
DECLARE @bulk_insert NVARCHAR(1000)
DECLARE @external_source NVARCHAR(100)
DECLARE @internal_source NVARCHAR(100)


SELECT @n = COUNT(*) FROM INTERN_EXTERN_NAMES
SELECT @device_directory = SUBSTRING([filename], 1, CHARINDEX(N'BogTrPoll_DataBase\Database\BogTrPoll.mdf', LOWER([filename])) - 1) + N'BogTrPoll_CSV\'
FROM MASTER.DBO.SYSALTFILES
WHERE [name] = 'BogTrPoll'


WHILE @i <= @n  
	BEGIN
		EXEC OBT_EXT @i, @external_source OUTPUT
		EXEC OBT_INT @i, @internal_source OUTPUT
		SET @query_directory = @device_directory + @external_source
		SET @bulk_insert = 'BULK INSERT ' + @internal_source + ' FROM ''' + @query_directory + '''WITH ( FIRSTROW = 2, FIELDTERMINATOR ='';'', ROWTERMINATOR =''\n'' )'
		EXEC(@bulk_insert)
		
		SET @i = 1 + @i
	END
GO


CREATE PROCEDURE UNITE_TABLES (@Tab1 NVARCHAR(20), @Tab2 NVARCHAR(20), @Out_tab NVARCHAR(20))
AS
EXEC('INSERT INTO ' + @Out_Tab + ' SELECT * FROM ' + @Tab1 + ' UNION SELECT * FROM ' + @Tab2)
GO


EXEC UNITE_TABLES @Tab1 = 'ETAPAS1', @Tab2 = 'ETAPAS2', @Out_tab = 'ETAPAS'
EXEC UNITE_TABLES @Tab1 = 'VIAJES1', @Tab2 = 'VIAJES2', @Out_tab = 'VIAJES'


DROP PROCEDURE OBT_INT
DROP PROCEDURE OBT_EXT
DROP TABLE ETAPAS1
DROP TABLE ETAPAS2
DROP TABLE VIAJES1
DROP TABLE VIAJES2
DROP TABLE INTERN_EXTERN_NAMES
