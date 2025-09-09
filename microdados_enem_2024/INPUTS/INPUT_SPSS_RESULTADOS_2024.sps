/*****************************************************************************************************/
/*  INEP/Daeb-Diretoria de Avaliação da Educação Básica                                          */ 
/*                                   			                                    */
/*  Coordenação-Geral de Medidas da Educação Básica (CGMEB)		*/
/*----------------------------------------------------------------------------------------------------------------------------*/
/*  PROGRAMA:                                                                                                      */
/*           INPUT_SPSS_RESULTADOS_2024                                                 	*/
/*----------------------------------------------------------------------------------------------------------------------------*/
/*DESCRICAO: PROGRAMA PARA LEITURA DA BASE DE DADOS		*/
/* RESULTADOS_2024     					*/
/*****************************************************************************************************/
/*****************************************************************************************************/
/* Obs:                                                                                                                    */
/* 		                                                                                          */
/* Para abrir a base de dados é necessário salvar este programa e o arquivo                 */
/* RESULTADOS_2024.csv no diretório C:\ do computador.	                   	*/
/*							 */ 
/*							 */
/* Para a leitura dos microdados é necessário a seleção do programa abaixo,               */
/* depois execute-o.						 */
/*							 */ 
/******************************************************************************************************/
/*                                                   ATENÇÃO                                                          */ 
/******************************************************************************************************/
/* Este programa abre a base de dados com os rótulos das variáveis de	                    */
/* acordo com o dicionário de dados que compõem os microdados. Para abrir                */
/* os dados sem os rótulos basta importar diretamente no SPSS.		  */
/* 							   */
/*******************************************************************************************************/

GET DATA
  /TYPE=TXT
  /FILE="C:\RESULTADOS_2024.csv" /*local do arquivo*/
  /DELCASE=LINE
  /DELIMITERS=";"
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /IMPORTCASE= ALL
  /VARIABLES=
  NU_SEQUENCIAL F21.0
  NU_ANO F4.0
  CO_ESCOLA F8.0
  CO_MUNICIPIO_ESC F7.0
  NO_MUNICIPIO_ESC A32
  CO_UF_ESC F2.0
  SG_UF_ESC A2
  TP_DEPENDENCIA_ADM_ESC F1.0
  TP_LOCALIZACAO_ESC F1.0
  TP_SIT_FUNC_ESC F1.0
  CO_MUNICIPIO_PROVA F7.0
  NO_MUNICIPIO_PROVA A27
  CO_UF_PROVA F2.0
  SG_UF_PROVA A10
  TP_PRESENCA_CN F1.0
  TP_PRESENCA_CH F1.0
  TP_PRESENCA_LC F1.0
  TP_PRESENCA_MT F1.0
  CO_PROVA_CN F4.0
  CO_PROVA_CH F4.0
  CO_PROVA_LC F4.0
  CO_PROVA_MT F4.0
  NU_NOTA_CN COMMA8.2
  NU_NOTA_CH COMMA8.2
  NU_NOTA_LC COMMA8.2
  NU_NOTA_MT COMMA8.2
  TX_RESPOSTAS_CN A45
  TX_RESPOSTAS_CH A45
  TX_RESPOSTAS_LC A50
  TX_RESPOSTAS_MT A45
  TP_LINGUA F1.0
  TX_GABARITO_CN A45
  TX_GABARITO_CH A45
  TX_GABARITO_LC A50
  TX_GABARITO_MT A45
  TP_STATUS_REDACAO F2.0
  NU_NOTA_COMP1 F3.0
  NU_NOTA_COMP2 F3.0
  NU_NOTA_COMP3 F3.0
  NU_NOTA_COMP4 F3.0
  NU_NOTA_COMP5 F3.0
  NU_NOTA_REDACAO F4.0.

CACHE.
EXECUTE.
DATASET NAME RESULTADOS_2024 WINDOW=FRONT.

VARIABLE LABELS
NU_SEQUENCIAL			"Número sequencial da linha de resultados"
NU_ANO	                  		"Ano do Enem"
CO_ESCOLA 			"Código da Escola de conclusão do ensino médio"
CO_MUNICIPIO_ESC 			"Código do município da escola"
NO_MUNICIPIO_ESC			"Nome do município da escola"
CO_UF_ESC			"Código da Unidade da Federação da escola"
SG_UF_ESC			"Sigla da Unidade da Federação da escola"
TP_DEPENDENCIA_ADM_ESC		"Dependência administrativa (Escola)"
TP_LOCALIZACAO_ESC		"Localização (Escola)"
TP_SIT_FUNC_ESC			"Situação de funcionamento (Escola)"
CO_MUNICIPIO_PROVA		"Código do município da aplicação da prova"
NO_MUNICIPIO_PROVA		"Nome do município da aplicação da prova"
CO_UF_PROVA			"Código da Unidade da Federação da aplicação da prova"
SG_UF_PROVA  			"Sigla da Unidade da Federação da aplicação da prova"
TP_PRESENCA_CN			"Presença na prova objetiva de Ciências da Natureza"
TP_PRESENCA_CH			"Presença na prova objetiva de Ciências Humanas"
TP_PRESENCA_LC			"Presença na prova objetiva de Linguagens e Códigos"
TP_PRESENCA_MT			"Presença na prova objetiva de Matemática"
CO_PROVA_CN			"Código do tipo de prova de Ciências da Natureza"
CO_PROVA_CH			"Código do tipo de prova de Ciências Humanas"
CO_PROVA_LC			"Código do tipo de prova de Linguagens e Códigos"
CO_PROVA_MT			"Código do tipo de prova de Matemática"
NU_NOTA_CN			"Nota da prova de Ciências da Natureza"
NU_NOTA_CH			"Nota da prova de Ciências Humanas"
NU_NOTA_LC			"Nota da prova de Linguagens e Códigos"
NU_NOTA_MT			"Nota da prova de Matemática"
TX_RESPOSTAS_CN			"Vetor com as respostas da parte objetiva da prova de Ciências da Natureza"
TX_RESPOSTAS_CH			"Vetor com as respostas da parte objetiva da prova de Ciências Humanas"
TX_RESPOSTAS_LC			"Vetor com as respostas da parte objetiva da prova de Linguagens e Códigos"
TX_RESPOSTAS_MT			"Vetor com as respostas da parte objetiva da prova de Matemática"
TP_LINGUA				"Tipo de Língua Estrangeira"
TX_GABARITO_CN			"Vetor com o gabarito da parte objetiva da prova de Ciências da Natureza"
TX_GABARITO_CH			"Vetor com o gabarito da parte objetiva da prova de Ciências Humanas"
TX_GABARITO_LC			"Vetor com o gabarito da parte objetiva da prova de Linguagens e Códigos"
TX_GABARITO_MT			"Vetor com o gabarito da parte objetiva da prova de Matemática"
TP_STATUS_REDACAO		"Situação da redação do participante"
NU_NOTA_COMP1			"Nota da competência 1"
NU_NOTA_COMP2			"Nota da competência 2"
NU_NOTA_COMP3			"Nota da competência 3"
NU_NOTA_COMP4			"Nota da competência 4"
NU_NOTA_COMP5			"Nota da competência 5"
NU_NOTA_REDACAO			"Nota da prova de redação".

VALUE LABELS
/TP_DEPENDENCIA_ADM_ESC
	1	"Federal"
	2	"Estadual"
	3	"Municipal"
	4	"Privada"
/TP_LOCALIZACAO_ESC
	1	"Urbana"
	2	"Rural"
/TP_SIT_FUNC_ESC
	1	"Em atividade"
	2	"Paralisada"
	3	"Extinta"
	4	"Escola extinta em anos anteriores"
/TP_PRESENCA_CN
	0	"Faltou à prova"
	1	"Presente na prova"
	2	"Eliminado na prova"
/TP_PRESENCA_CH
	0	"Faltou à prova"
	1	"Presente na prova"
	2	"Eliminado na prova"
/TP_PRESENCA_LC
	0	"Faltou à prova"
	1	"Presente na prova"
	2	"Eliminado na prova"
/TP_PRESENCA_MT
	0	"Faltou à prova"
	1	"Presente na prova"
	2	"Eliminado na prova"
/CO_PROVA_CN
	1419	"Azul"
	1420	"Amarela"
	1421	"Verde"
	1422	"Cinza"
	1423	"Verde - Ampliada"
	1424	"Verde - Superampliada"
	1426	"Laranja - Adaptada Ledor"
	1427	"Roxa - Videoprova - Libras"
	1428	"Roxa - Videoprova - Libras - Ampliada"
	1373	"Azul (Reaplicação)"
	1374	"Amarela (Reaplicação)"
	1375	"Cinza (Reaplicação)"
	1376	"Verde (Reaplicação)"
	1377	"Verde - Ampliada (Reaplicação)"
	1378	"Verde - Superampliada (Reaplicação)"
	1380	"Laranja - Adaptada Ledor (Reaplicação)"
/CO_PROVA_CH
	1383	"Azul"
	1384	"Amarela"
	1385	"Branca"
	1386	"Verde"
	1387	"Verde - Ampliada"
	1388	"Verde - Superampliada"
	1390	"Laranja - Adaptada Ledor"
	1391	"Roxa - Videoprova - Libras"
	1392	"Roxa - Videoprova - Libras - Ampliada"
	1393	"Roxa - Videoprova - Libras - Superampliada"
	1343	"Azul (Reaplicação)"
	1344	"Amarela (Reaplicação)"
	1345	"Branca (Reaplicação)"
	1346	"Verde (Reaplicação)"
	1347	"Verde - Ampliada (Reaplicação)"
	1348	"Verde - Superampliada (Reaplicação)"
	1350	"Laranja - Adaptada Ledor (Reaplicação)"
/CO_PROVA_LC
	1395	"Azul"
	1396	"Amarela"
	1397	"Verde"
	1398	"Branca"
	1399	"Verde - Ampliada"
	1400	"Verde - Superampliada"
	1402	"Laranja - Adaptada Ledor"
	1403	"Roxa - Videoprova - Libras"
	1404	"Roxa - Videoprova - Libras - Ampliada"
	1405	"Roxa - Videoprova - Libras - Superampliada"
	1353	"Azul (Reaplicação)"
	1354	"Amarela (Reaplicação)"
	1355	"Verde (Reaplicação)"
	1356	"Branca (Reaplicação)"
	1357	"Verde - Ampliada (Reaplicação)"
	1358	"Verde - Superampliada (Reaplicação)"
	1360	"Laranja - Adaptada Ledor (Reaplicação)"
/CO_PROVA_MT
	1407	"Azul"
	1408	"Amarela"
	1409	"Verde"
	1410	"Cinza"
	1411	"Verde - Ampliada"
	1412	"Verde - Superampliada"
	1414	"Laranja - Adaptada Ledor"
	1415	"Roxa - Videoprova - Libras"
	1416	"Roxa - Videoprova - Libras - Ampliada"
	1363	"Azul (Reaplicação)"
	1364	"Amarela (Reaplicação)"
	1365	"Verde (Reaplicação)"
	1366	"Cinza (Reaplicação)"
	1367	"Verde - Ampliada (Reaplicação)"
	1368	"Verde - Superampliada (Reaplicação)"
	1370	"Laranja - Adaptada Ledor (Reaplicação)"
/TP_LINGUA
	0	"Inglês"
	1	"Espanhol"
/TP_STATUS_REDACAO
	1	"Sem problemas"
	2	"Anulada"
	3	"Cópia Texto Motivador"
	4	"Em Branco"
	6	"Fuga ao tema"
	7	"Não atendimento ao tipo textual"
	8	"Texto insuficiente"
	9	"Parte desconectada".
SAVE OUTFILE='C:\RESULTADOS_2024.sav'
  /COMPRESSED.
