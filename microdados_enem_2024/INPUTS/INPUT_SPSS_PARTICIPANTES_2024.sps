/*****************************************************************************************************/
/*  INEP/Daeb-Diretoria de Avaliação da Educação Básica                                          */ 
/*                                   			                                    */
/*  Coordenação-Geral de Medidas da Educação Básica (CGMEB)		*/
/*----------------------------------------------------------------------------------------------------------------------------*/
/*  PROGRAMA:                                                                                                      */
/*           INPUT_SPSS_PARTICIPANTES_2024 		                                    */
/*----------------------------------------------------------------------------------------------------------------------------*/
/*DESCRICAO: PROGRAMA PARA LEITURA DA BASE DE DADOS		*/
/* PARTICIPANTES_2024     					*/
/*****************************************************************************************************/
/*****************************************************************************************************/
/* Obs:                                                                                                                    */
/* 		                                                                                          */
/* Para abrir a base de Participantes é necessário salvar este programa e o arquivo       */
/* PARTICIPANTES_2024.csv no diretório C:\ do computador.	                   */
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
  /FILE="C:\PARTICIPANTES_2024.csv" /*local do arquivo*/
  /DELCASE=LINE
  /DELIMITERS=";"
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /IMPORTCASE= ALL
  /VARIABLES=
  NU_INSCRICAO F21.0
  NU_ANO F4.0
  TP_FAIXA_ETARIA F2.0
  TP_SEXO A1
  TP_ESTADO_CIVIL F1.0
  TP_COR_RACA F1.0
  TP_NACIONALIDADE F2.0
  TP_ST_CONCLUSAO F1.0
  TP_ANO_CONCLUIU F2.0
  TP_ENSINO F1.0
  IN_TREINEIRO F1.0
  CO_MUNICIPIO_PROVA F7.0
  NO_MUNICIPIO_PROVA A27
  CO_UF_PROVA F2.0
  SG_UF_PROVA A10
  Q001 A1
  Q002 A1
  Q003 A1
  Q004 A1
  Q005 F2.0
  Q006 A1
  Q007 A1
  Q008 A1
  Q009 A1
  Q010 A1
  Q011 A1
  Q012 A1
  Q013 A1
  Q014 A1
  Q015 A1
  Q016 A1
  Q017 A1
  Q018 A1
  Q019 A1
  Q020 A1
  Q021 A1
  Q022 A1
  Q023 A1.

CACHE.
EXECUTE.
DATASET NAME PARTICIPANTES_2024 WINDOW=FRONT.

VARIABLE LABELS
NU_INSCRICAO			"Número de inscrição"
NU_ANO	                  		"Ano do Enem"
IN_TREINEIRO 			 "Indica se o inscrito fez a prova com intuito de apenas treinar seus conhecimentos"
TP_FAIXA_ETARIA         		"Faixa Etária"
TP_SEXO	              			 "Sexo"
TP_NACIONALIDADE			"Nacionalidade"
TP_ST_CONCLUSAO			"Situação de conclusão do Ensino Médio"
TP_ANO_CONCLUIU			"Ano de Conclusão do Ensino Médio"
TP_ENSINO			"Tipo de instituição que concluiu ou concluirá o Ensino Médio"
TP_ESTADO_CIVIL			"Estado Civil"
TP_COR_RACA			"Cor/raça"
CO_MUNICIPIO_PROVA		"Código do município da aplicação da prova"
NO_MUNICIPIO_PROVA		"Nome do município da aplicação da prova"
CO_UF_PROVA			"Código da Unidade da Federação da aplicação da prova"
SG_UF_PROVA  			"Sigla da Unidade da Federação da aplicação da prova"
Q001				"Até que série seu pai, ou o homem responsável por você, estudou?"
Q002				"Até que série sua mãe, ou a mulher responsável por você, estudou?"
Q003				"A partir da apresentação de algumas ocupações divididas em grupos ordenados, indique o grupo que contempla a ocupação mais próxima da ocupação do seu pai ou do homem responsável por você.(cf. dic.)"
Q004				"A partir da apresentação de algumas ocupações divididas em grupos ordenados, indique o grupo que contempla a ocupação mais próxima da ocupação da sua mãe ou da mulher responsável por você.(cf. dic.)"
Q005				"Incluindo você, quantas pessoas moram atualmente em sua residência?"
Q006				"Você possui renda?"
Q007				"Qual é a renda mensal de sua família? (Considere a sua renda com a das pessoas que moram com você.)"
Q008				"Em sua casa, você ou a pessoa responsável pela sua família costuma contratar os serviços de um(a) empregado(a) doméstico(a)?"
Q009				"Em sua casa, existe banheiro?"
Q010				"Em sua casa, existe quarto para dormir?"
Q011				"Incluindo você, as pessoas com quem você mora têm carro?"
Q012				"Incluindo você, as pessoas com quem você mora têm motocicleta?"
Q013				"Em sua casa, existe geladeira?"
Q014				"Em sua casa, existe freezer independente (vertical ou horizontal)? (Não considere a segunda porta da geladeira.)"
Q015				"Em sua casa, existe máquina de lavar roupa? (Não considere o tanquinho.)"
Q016				"Em sua casa, existe micro-ondas?"
Q017				"Em sua casa, existe aspirador de pó?"
Q018				"Em sua casa, existe aparelho de TV?"
Q019				"Em sua casa, existe TV por assinatura?"
Q020				"Em sua casa, existe acesso à internet por rede wi-fi?"
Q021				"Em sua casa, existe computador/notebook?"
Q022				"Incluindo você, as pessoas com quem você mora têm telefone celular?"
Q023				"Em que tipo de escola você frequentou ou frequenta o Ensino Médio?".

VALUE LABELS
/TP_FAIXA_ETARIA
	1   	"Menor de 17 anos"
	2   	"17 anos"
	3   	"18 anos"
	4   	"19 anos"
	5   	"20 anos"
	6   	"21 anos"
	7   	"22 anos"
	8   	"23 anos"
	9   	"24 anos"
	10  	"25 anos"
	11  	"Entre 26 e 30 anos"
	12  	"Entre 31 e 35 anos"
	13  	"Entre 36 e 40 anos"
	14  	"Entre 41 e 45 anos"
	15  	"Entre 46 e 50 anos"
	16  	"Entre 51 e 55 anos"
	17  	"Entre 56 e 60 anos"
	18  	"Entre 61 e 65 anos"
	19  	"Entre 66 e 70 anos"
	20  	"Maior de 70 anos"
/IN_TREINEIRO
	0	"Não"
	1	"Sim"
/TP_SEXO
	"M"	"Masculino"
	"F"	"Feminino"
/TP_NACIONALIDADE
	0	"Não informado"
	1	"Brasileiro(a)"
	2	"Brasileiro(a) Naturalizado(a)"
	3	"Estrangeiro(a)"
	4	"Brasileiro(a) Nato(a), nascido(a) no exterior"
/TP_ST_CONCLUSAO
	1	"Já concluí o Ensino Médio"
	2	"Estou cursando e concluirei o Ensino Médio em 2024"
	3	"Estou cursando e concluirei o Ensino Médio após 2024"
	4	"Não concluí e não estou cursando o Ensino Médio"
/TP_ANO_CONCLUIU
	0	"Não informado"
	1	"2023"
	2	"2022"
	3	"2021"
	4	"2020"
	5	"2019"
	6	"2018"
	7	"2017"
	8	"2016"
	9	"2015"
	10	"2014"
	11	"2013"
	12	"2012"
	13	"2011"
	14	"2010"
	15	"2009"
	16	"2008"
	17	"2007"
	18	"Antes de 2007"
/TP_ENSINO
	1	"Ensino Regular"
	2	"Educação Especial - Modalidade Substitutiva"
/TP_ESTADO_CIVIL
	0	"Não informado"
	1	"Solteiro(a)"
	2	"Casado(a)/Mora com um(a) companheiro(a)"
	3	"Divorciado(a)/Desquitado(a)/Separado(a)"
	4	"Viúvo(a)"
/TP_COR_RACA
	0	"Não declarado"
	1	"Branca"
	2	"Preta"
	3	"Parda"
	4	"Amarela"
	5	"Indígena"
	6	"Não dispõe da informação"
/Q001
	"A"	"Nunca estudou"
	"B"	"Não completou a 4ª série/5º ano do Ensino Fundamental"
	"C"	"Completou a 4ª série/5º ano, mas não completou a 8ª série/9º ano do Ensino Fundamental"
	"D"	"Completou a 8ª série/9º ano do Ensino Fundamental, mas não completou o Ensino Médio"
	"E"	"Completou o Ensino Médio, mas não completou a Faculdade"
	"F"	"Completou a Faculdade, mas não completou a Pós-graduação"
	"G"	"Completou a Pós-graduação"
	"H"	"Não sei"
/Q002
	"A"	"Nunca estudou"
	"B"	"Não completou a 4ª série/5º ano do Ensino Fundamental"
	"C"	"Completou a 4ª série/5º ano, mas não completou a 8ª série/9º ano do Ensino Fundamental"
	"D"	"Completou a 8ª série/9º ano do Ensino Fundamental, mas não completou o Ensino Médio"
	"E"	"Completou o Ensino Médio, mas não completou a Faculdade"
	"F"	"Completou a Faculdade, mas não completou a Pós-graduação"
	"G"	"Completou a Pós-graduação"
	"H"	"Não sei"
/Q003
	"A"	"Grupo 1: Lavrador, agricultor sem empregados, bóia fria, criador de animais (gado, porcos, galinhas, ovelhas, cavalos etc.), apicultor, pescador, lenhador, seringueiro, extrativista"
	"B"	"Grupo 2: Diarista, empregado doméstico, cuidador de idosos, babá, cozinheiro (em casas particulares), motorista particular, jardineiro, faxineiro de empresas e prédios, vigilante (cf. dic.)"
	"C"	"Grupo 3: Padeiro, cozinheiro industrial ou em restaurantes, sapateiro, costureiro, joalheiro, torneiro mecânico, operador de máquinas, soldador, operário de fábrica, trabalhador da (cf. dic.)"
	"D"	"Grupo 4: Professor (de ensino fundamental ou médio, idioma, música, artes etc.), técnico (de enfermagem, contabilidade, eletrônica etc.), policial, militar de baixa patente (cf. dic.)"
	"E"	"Grupo 5: Médico, engenheiro, dentista, psicólogo, economista, advogado, juiz, promotor, defensor, delegado, tenente, capitão, coronel, professor universitário, diretor em empresas (cf. dic.)"
	"F"	"Não sei"
/Q004
	"A"	"Grupo 1: Lavradora, agricultora sem empregados, bóia fria, criadora de animais (gado, porcos, galinhas, ovelhas, cavalos etc.), apicultora, pescadora, lenhadora, seringueira, extrativista"
	"B"	"Grupo 2: Diarista, empregada doméstica, cuidadora de idosos, babá, cozinheira (em casas particulares), motorista particular, jardineira, faxineira de empresas e prédios, vigilante (cf. dic.)"
	"C"	"Grupo 3: Padeira, cozinheira industrial ou em restaurantes, sapateira, costureira, joalheira, torneira mecânica, operadora de máquinas, soldadora, operária de fábrica, trabalhadora (cf. dic.)"
	"D"	"Grupo 4: Professora (de ensino fundamental ou médio, idioma, música, artes etc.), técnica (de enfermagem, contabilidade, eletrônica etc.), policial, militar de baixa patente (cf. dic.)"
	"E"	"Grupo 5: Médica, engenheira, dentista, psicóloga, economista, advogada, juíza, promotora, defensora, delegada, tenente, capitã, coronel, professora universitária, diretora em (cf. dic.)"
	"F"	"Não sei"
/Q005
	1	"1, pois moro sozinho(a)"
	2	"2"
	3	"3"
	4	"4"
	5	"5"
	6	"6"
	7	"7"
	8	"8"
	9	"9"
	10	"10"
	11	"11"
	12	"12"
	13	"13"
	14	"14"
	15	"15"
	16	"16"
	17	"17"
	18	"18"
	19	"19"
	20	"20"
/Q006
	"A"	"Não"
	"B"	"Sim"
/Q007
	"A"	"Nenhuma Renda"
	"B"	"Até R$ 1.412,00"
	"C"	"De R$ 1.412,01 até R$ 2.118,00"
	"D"	"De R$ 2.118,01 até R$ 2.824,00"
	"E"	"De R$ 2.824,01 até R$ 3.530,00"
	"F"	"De R$ 3.530,01 até R$ 4.236,00"
	"G"	"De R$ 4.236,01 até R$ 5.648,00"
	"H"	"De R$ 5.648,01 até R$ 7.060,00"
	"I"	"De R$ 7.060,01 até R$ 8.472,00"
	"J"	"De R$ 8.472,01 até R$ 9.884,00"
	"K"	"De R$ 9.884,01 até R$ 11.296,00"
	"L"	"De R$ 11.296,01 até R$ 12.708,00"
	"M"	"De R$ 12.708,01 até R$ 14.120,00"
	"N"	"De R$ 14.120,01 até R$ 16.944,00"
	"O"	"De R$ 16.944,01 até R$ 21.180,00"
	"P"	"De R$ 21.180,01 até R$ 28.240,00"
	"Q"	"Acima de R$ 28.240,00"
/Q008
	"A"	"Não"
	"B"	"Sim, um ou dois dias por semana"
	"C"	"Sim, três ou quatro dias por semana"
	"D"	"Sim, pelo menos cinco dias por semana"
/Q009
	"A"	"Não"
	"B"	"Sim, um"
	"C"	"Sim, dois"
	"D"	"Sim, três ou mais"
/Q010
	"A"	"Não"
	"B"	"Sim, um"
	"C"	"Sim, dois"
	"D"	"Sim, três ou mais"
/Q011
	"A"	"Não"
	"B"	"Sim, um"
	"C"	"Sim, dois"
	"D"	"Sim, três ou mais"
/Q012
	"A"	"Não"
	"B"	"Sim, um"
	"C"	"Sim, dois"
	"D"	"Sim, três ou mais"
/Q013
	"A"	"Não"
	"B"	"Sim, um"
	"C"	"Sim, dois"
	"D"	"Sim, três ou mais"
/Q014
	"A"	"Não"
	"B"	"Sim"
/Q015
	"A"	"Não"
	"B"	"Sim"
/Q016
	"A"	"Não"
	"B"	"Sim"
/Q017
	"A"	"Não"
	"B"	"Sim"
/Q018
	"A"	"Não"
	"B"	"Sim, uma"
	"C"	"Sim, duas"
	"D"	"Sim, três ou mais"
/Q019
	"A"	"Não"
	"B"	"Sim"
/Q020
	"A"	"Não"
	"B"	"Sim"
/Q021
	"A"	"Não"
	"B"	"Sim, um"
	"C"	"Sim, dois"
	"D"	"Sim, três"
	"E"	"Sim, quatro ou mais"
/Q022
	"A"	"Não"
	"B"	"Sim, um"
	"C"	"Sim, dois"
	"D"	"Sim, três ou mais"
	"E"	"Sim, quatro ou mais"
/Q023
	"A"	"Somente em escola pública"
	"B"	"Parte em escola pública e parte em escola privada sem bolsa de estudo integral"
	"C"	"Parte em escola pública e parte em escola privada com bolsa de estudo integral"
	"D"	"Somente em escola privada sem bolsa de estudo integral"
	"E"	"Somente em escola privada com bolsa de estudo integral"
	"F"	"Não frequentei escola de Ensino Médio".
SAVE OUTFILE='C:\PARTICIPANTES_2024.sav'
  /COMPRESSED.
