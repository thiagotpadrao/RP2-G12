/**************************************************************************/
/*  INEP/Daeb-Diretoria de Avaliação da Educação Básica              	  */      
/*                                   									  */	
/*  Coordenação-Geral de Medidas da Educação Básica(CGMEB)				  */
/*------------------------------------------------------------------------*/
/*  PROGRAMA:                                                             */
/*           INPUT_SAS_RESULTADOS_2024.sas                        	  	  */
/*------------------------------------------------------------------------*/
/*  DESCRICAO: PROGRAMA PARA LEITURA DA BASE DE RESULTADOS DO ENEM 2024   */    
/*                                                                        */
/**************************************************************************/
/**************************************************************************/
/* Obs:                                                                   */
/* 		                                                                  */
/* Para abrir a base de Resultados é necessário salvar este programa e o  */
/* arquivo RESULTADOS_2024.CSV no diretório C:\ do computador.			  */
/*															 			  */                                           
/* Ao terminar esses procedimentos execute o programa salvo utilizando    */
/* as variáveis de interesse.                                             */
/**************************************************************************/
/*				                  ATENÇÃO                                 */  
/**************************************************************************/
/* Este programa abre a base de dados com os rótulos das variáveis de	  */
/* acordo com o dicionário de dados que compõem os microdados. Para abrir */
/* os dados sem os rótulos basta importar diretamente no SAS.			  */
/* 																	      */ 																          
/**************************************************************************/

proc format;

	value TP_DEPENDENCIA_ADM_ESC
       1= 'Federal'
	   2= 'Estadual'
	   3= 'Municipal'
	   4= 'Privada';

	value TP_LOCALIZACAO_ESC
       1= 'Urbana'
	   2= 'Rural';

	value TP_SIT_FUNC_ESC
	   1='Em atividade'
	   2='Paralisada'
	   3='Extinta'
	   4='Escola extinta em anos anteriores';

	value TP_PRESENCA_CN
		0='Faltou à prova'
		1='Presente na prova'
		2='Eliminado na prova';

	value TP_PRESENCA_CH
		0='Faltou à prova'
		1='Presente na prova'
		2='Eliminado na prova';

	value TP_PRESENCA_LC
		0='Faltou à prova'
		1='Presente na prova'
		2='Eliminado na prova';

	value TP_PRESENCA_MT
		0='Faltou à prova'
		1='Presente na prova'
		2='Eliminado na prova';

    value CO_PROVA_CN
        1419= 'Azul'
        1420= 'Amarela'
        1421= 'Verde'
        1422= 'Cinza'
        1423= 'Verde - Ampliada'
        1424= 'Verde - Superampliada'
        1426= 'Laranja - Adaptada Ledor'
        1427= 'Roxa - Videoprova - Libras'
        1428= 'Roxa - Videoprova - Libras - Ampliada'
        1373= 'Azul (Reaplicação)'
        1374= 'Amarela (Reaplicação)'
        1375= 'Cinza (Reaplicação)'
        1376= 'Verde (Reaplicação)'
        1377= 'Verde - Ampliada (Reaplicação)'
        1378= 'Verde - Superampliada (Reaplicação)'
        1380= 'Laranja - Adaptada Ledor (Reaplicação)';

    value CO_PROVA_CH
        1383= 'Azul'
        1384= 'Amarela'
        1385= 'Branca'
        1386= 'Verde'
        1387= 'Verde - Ampliada'
        1388= 'Verde - Superampliada'
        1390= 'Laranja - Adaptada Ledor'
        1391= 'Roxa - Videoprova - Libras'
        1392= 'Roxa - Videoprova - Libras - Ampliada'
        1393= 'Roxa - Videoprova - Libras - Superampliada'
        1343= 'Azul (Reaplicação)'
        1344= 'Amarela (Reaplicação)'
        1345= 'Branca (Reaplicação)'
        1346= 'Verde (Reaplicação)'
        1347= 'Verde - Ampliada (Reaplicação)'
        1348= 'Verde - Superampliada (Reaplicação)'
        1350= 'Laranja - Adaptada Ledor (Reaplicação)';

    value CO_PROVA_LC
        1395= 'Azul'
        1396= 'Amarela'
        1397= 'Verde'
        1398= 'Branca'
        1399= 'Verde - Ampliada'
        1400= 'Verde - Superampliada'
        1402= 'Laranja - Adaptada Ledor'
        1403= 'Roxa - Videoprova - Libras'
        1404= 'Roxa - Videoprova - Libras - Ampliada'
        1405= 'Roxa - Videoprova - Libras - Superampliada'
        1353= 'Azul (Reaplicação)'
        1354= 'Amarela (Reaplicação)'
        1355= 'Verde (Reaplicação)'
        1356= 'Branca (Reaplicação)'
        1357= 'Verde - Ampliada (Reaplicação)'
        1358= 'Verde - Superampliada (Reaplicação)'
        1360= 'Laranja - Adaptada Ledor (Reaplicação)';

    value CO_PROVA_MT
        1407= 'Azul'
        1408= 'Amarela'
        1409= 'Verde'
        1410= 'Cinza'
        1411= 'Verde - Ampliada'
        1412= 'Verde - Superampliada'
        1414= 'Laranja - Adaptada Ledor'
        1415= 'Roxa - Videoprova - Libras'
        1416= 'Roxa - Videoprova - Libras - Ampliada'
        1363= 'Azul (Reaplicação)'
        1364= 'Amarela (Reaplicação)'
        1365= 'Verde (Reaplicação)'
        1366= 'Cinza (Reaplicação)'
        1367= 'Verde - Ampliada (Reaplicação)'
        1368= 'Verde - Superampliada (Reaplicação)'
        1370= 'Laranja - Adaptada Ledor (Reaplicação)';

	value TP_LINGUA
		0='Inglês'
		1='Espanhol';

	value TP_STATUS_REDACAO
		1='Sem problemas'
		2='Anulada'
		3='Cópia Texto Motivador'
        4='Em Branco'
		6='Fuga ao tema'
        7='Não atendimento ao tipo textual'
		8='Texto insuficiente'
        9='Parte desconectada';
run;

DATA WORK.RESULTADOS_2024;
INFILE 'C:\RESULTADOS_2024.csv' /*local do arquivo*/
        LRECL=600
        FIRSTOBS=2
        DLM=';'
        MISSOVER
        DSD ;

    INPUT
        NU_SEQUENCIAL    : ?? BEST12.
        NU_ANO           : ?? BEST4.
        CO_ESCOLA     	 : ?? BEST8.
        CO_MUNICIPIO_ESC : ?? BEST7.
        NO_MUNICIPIO_ESC : $CHAR32.
        CO_UF_ESC        : ?? BEST2.
        SG_UF_ESC        : $CHAR2.
        TP_DEPENDENCIA_ADM_ESC : ?? BEST1.
        TP_LOCALIZACAO_ESC : ?? BEST1.
        TP_SIT_FUNC_ESC  : ?? BEST1.
        CO_MUNICIPIO_PROVA : ?? BEST7.
        NO_MUNICIPIO_PROVA : $CHAR30.
        CO_UF_PROVA      : ?? BEST2.
        SG_UF_PROVA      : $CHAR2.
        TP_PRESENCA_CN   : ?? BEST1.
        TP_PRESENCA_CH   : ?? BEST1.
        TP_PRESENCA_LC   : ?? BEST1.
        TP_PRESENCA_MT   : ?? BEST1.
        CO_PROVA_CN      : ?? BEST4.
        CO_PROVA_CH      : ?? BEST4.
        CO_PROVA_LC      : ?? BEST4.
        CO_PROVA_MT      : ?? BEST4.
        NU_NOTA_CN       : ?? COMMA5.
        NU_NOTA_CH       : ?? COMMA5.
        NU_NOTA_LC       : ?? COMMA5.
        NU_NOTA_MT       : ?? COMMA5.
        TX_RESPOSTAS_CN  : $CHAR45.
        TX_RESPOSTAS_CH  : $CHAR45.
        TX_RESPOSTAS_LC  : $CHAR45.
        TX_RESPOSTAS_MT  : $CHAR45.
        TP_LINGUA        : ?? BEST1.
        TX_GABARITO_CN   : $CHAR45.
        TX_GABARITO_CH   : $CHAR45.
        TX_GABARITO_LC   : $CHAR50.
        TX_GABARITO_MT   : $CHAR45.
        TP_STATUS_REDACAO : ?? BEST1.
        NU_NOTA_COMP1    : ?? BEST3.
        NU_NOTA_COMP2    : ?? BEST3.
        NU_NOTA_COMP3    : ?? BEST3.
        NU_NOTA_COMP4    : ?? BEST3.
        NU_NOTA_COMP5    : ?? BEST3.
        NU_NOTA_REDACAO  : ?? BEST4.;

ATTRIB TP_DEPENDENCIA_ADM_ESC  FORMAT=TP_DEPENDENCIA_ADM_ESC.;
ATTRIB TP_LOCALIZACAO_ESC 	   FORMAT=TP_LOCALIZACAO_ESC.;
ATTRIB TP_SIT_FUNC_ESC 		   FORMAT=TP_SIT_FUNC_ESC.;
ATTRIB TP_PRESENCA_CN 		   FORMAT=TP_PRESENCA_CN.;
ATTRIB TP_PRESENCA_CH 		   FORMAT=TP_PRESENCA_CH.;
ATTRIB TP_PRESENCA_LC 		   FORMAT=TP_PRESENCA_LC.;
ATTRIB TP_PRESENCA_MT 		   FORMAT=TP_PRESENCA_MT.;
ATTRIB CO_PROVA_CN 			   FORMAT=CO_PROVA_CN.;
ATTRIB CO_PROVA_CH 			   FORMAT=CO_PROVA_CH.;
ATTRIB CO_PROVA_LC 			   FORMAT=CO_PROVA_LC.;
ATTRIB CO_PROVA_MT 		       FORMAT=CO_PROVA_MT.;
ATTRIB TP_LINGUA 			   FORMAT=TP_LINGUA.;
ATTRIB TP_STATUS_REDACAO 	   FORMAT=TP_STATUS_REDACAO.;

LABEL

NU_SEQUENCIAL = 'Número sequencial da linha de resultados'
NU_ANO = 'Ano do Enem'
CO_ESCOLA = 'Código da Escola de conclusão do ensino médio'
CO_MUNICIPIO_ESC = 'Código do município da escola'
NO_MUNICIPIO_ESC = 'Nome do município da escola'
CO_UF_ESC = 'Código da Unidade da Federação da escola'
SG_UF_ESC = 'Sigla da Unidade da Federação da escola'
TP_DEPENDENCIA_ADM_ESC = 'Dependência administrativa (Escola)'
TP_LOCALIZACAO_ESC = 'Localização (Escola)'
TP_SIT_FUNC_ESC = 'Situação de funcionamento (Escola)'
CO_MUNICIPIO_PROVA = 'Código do município da aplicação da prova'
NO_MUNICIPIO_PROVA = 'Nome do município da aplicação da prova'
CO_UF_PROVA = 'Código da Unidade da Federação da aplicação da prova'
SG_UF_PROVA = 'Sigla da Unidade da Federação da aplicação da prova'
TP_PRESENCA_CN = 'Presença na prova objetiva de Ciências da Natureza'
TP_PRESENCA_CH = 'Presença na prova objetiva de Ciências Humanas'
TP_PRESENCA_LC = 'Presença na prova objetiva de Linguagens e Códigos'
TP_PRESENCA_MT = 'Presença na prova objetiva de Matemática'
NU_NOTA_CN = 'Nota da prova de Ciências da Natureza'
NU_NOTA_CH = 'Nota da prova de Ciências Humanas'
NU_NOTA_LC = 'Nota da prova de Linguagens e Códigos'
NU_NOTA_MT = 'Nota da prova de Matemática'
TX_RESPOSTAS_CN = 'Vetor com as respostas da parte objetiva da prova de Ciências da Natureza'
TX_RESPOSTAS_CH = 'Vetor com as respostas da parte objetiva da prova de Ciências Humanas'
TX_RESPOSTAS_LC = 'Vetor com as respostas da parte objetiva da prova de Linguagens e Códigos'
TX_RESPOSTAS_MT = 'Vetor com as respostas da parte objetiva da prova de Matemática'
CO_PROVA_CN = 'Código do tipo de prova de Ciências da Natureza'
CO_PROVA_CH = 'Código do tipo de prova de Ciências Humanas'
CO_PROVA_LC = 'Código do tipo de prova de Linguagens e Códigos'
CO_PROVA_MT = 'Código do tipo de prova de Matemática'
TP_LINGUA = 'Tipo de Língua Estrangeira'
TX_GABARITO_CN = 'Vetor com o gabarito da parte objetiva da prova de Ciências da Natureza'
TX_GABARITO_CH = 'Vetor com o gabarito da parte objetiva da prova de Ciências Humanas'
TX_GABARITO_LC = 'Vetor com o gabarito da parte objetiva da prova de Linguagens e Códigos'
TX_GABARITO_MT = 'Vetor com o gabarito da parte objetiva da prova de Matemática'
TP_STATUS_REDACAO = 'Situação da redação do participante'
NU_NOTA_COMP1 = 'Nota da competência 1'
NU_NOTA_COMP2 = 'Nota da competência 2'
NU_NOTA_COMP3 = 'Nota da competência 3'
NU_NOTA_COMP4 = 'Nota da competência 4'
NU_NOTA_COMP5 = 'Nota da competência 5'
NU_NOTA_REDACAO = 'Nota da prova de redação';

IF NU_SEQUENCIAL = . THEN DELETE;

RUN;