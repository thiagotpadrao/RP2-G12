#--------------------------------------------------------
#  INEP/Daeb-Diretoria de Avaliação da Educação Básica 
#  Coordenação-Geral de Medidas da Educação Básica (CGMEB)			
#--------------------------------------------------------

#--------------------------------------------------------
#  PROGRAMA:                                                                                                      
#           INPUT_R_MICRODADOS_ENEM_2023
#--------------------------------------------------------
#  DESCRI??O:
#           PROGRAMA PARA LEITURA DA BASE DE DADOS
#           MICRODADOS_ENEM_2023
#--------------------------------------------------------

#------------------------------------------------------------------------
# Obs:                                                                                                                    
#     Para abrir os microdados é necessário salvar este programa e o arquivo                    
#     MICRODADOS_ENEM_2023.csv no mesmo diretório.	                  
#------------------------------------------------------------------------

#------------------------------------------------------------------------
#                   ATENÇÃO              
#------------------------------------------------------------------------
# Este programa abre a base de dados com os rótulos das variáveis de	                    
# acordo com o dicionário de dados que compõem os microdados. 		  
#------------------------------------------------------------------------

#--------------------
# Intalação do pacote Data.Table
# Se não estiver instalado
#--------------------
if(!require(data.table)){install.packages('data.table')}

#--------------------
# Caso deseje trocar o local do arquivo, 
# Edite a função setwd() a seguir informando o local do arquivo.
# Ex. Windows setwd("C:/temp")
#     Linux   setwd("/home")
#--------------------
setwd("C:/")  

#------------------
# Carga dos microdados

ENEM_2023 <- data.table::fread(input='microdados_ENEM_2023.csv',
                               integer64='character',
                               skip=0,  #Ler do inicio
                               nrow=-1, #Ler todos os registros
                               na.strings = "", 
                               showProgress = TRUE)

#---------------------------
# A script a seguir formata os r?tulos das respostas
# Para formatar um item retire o caracter de coment?rio (#) no in?cio na linha desejada 
#---------------------------

#ENEM_2023$TP_FAIXA_ETARIA <- factor(ENEM_2023$TP_FAIXA_ETARIA, 
#                                    levels = c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20), 
#                                    labels = c('Menor de 17 anos','17 anos','18 anos','19 anos','20 anos','21 anos','22 anos',
#                                               '23 anos','24 anos','25 anos','Entre 26 e 30 anos','Entre 31 e 35 anos','Entre 36 e 40 anos',
#                                               'Entre 41 e 45 anos','Entre 46 e 50 anos','Entre 51 e 55 anos','Entre 56 e 60 anos','Entre 61 e 65 anos',
#                                               'Entre 66 e 70 anos','Maior de 70 anos'))

#ENEM_2023$IN_TREINEIRO <- factor(ENEM_2023$IN_TREINEIRO, levels = c(1,0),  labels=c('Sim','N?o'))

#ENEM_2023$TP_DEPENDENCIA_ADM_ESC <- factor(ENEM_2023$TP_DEPENDENCIA_ADM_ESC, levels = c(1,2,3,4),
#                                           labels=c('Federal',
#                                                    'Estadual',
#                                                    'Municipal',
#                                                    'Privada'))

#ENEM_2023$TP_LOCALIZACAO_ESC <- factor(ENEM_2023$TP_LOCALIZACAO_ESC, levels = c(1,2), labels=c('Urbana','Rural'))

#ENEM_2023$TP_SIT_FUNC_ESC <- factor(ENEM_2023$TP_SIT_FUNC_ESC, levels = c(1,2,3,4),
#                                    labels=c('Em atividade',
#                                             'Paralisada',
#                                             'Extinta',
#                                             'Escola extinta em anos anteriores'))

#ENEM_2023$TP_SEXO <- factor(ENEM_2023$TP_SEXO, levels = c('M','F'), labels=c('Maculino','Feminino'))

#ENEM_2023$TP_ESTADO_CIVIL <- factor(ENEM_2023$TP_ESTADO_CIVIL, levels = c(0,1,2,3,4),
#                                    labels=c('Não informado',
#                                             'Solteiro(a)',
#                                             'Casado(a)/Mora com um(a) companheiro(a)',
#                                             'Divorciado(a)/Desquitado(a)/Separado(a)',
#                                             'Viúvo(a)'))

#ENEM_2023$TP_COR_RACA <- factor(ENEM_2023$TP_COR_RACA, levels = c(0,1,2,3,4,5,6),
#                                labels=c('Não declarado',
#                                         'Branca','Preta',
#                                         'Parda','Amarela',
#                                         'Ind?gena',
#                                         'Não dispõe da informação'))

#ENEM_2023$TP_NACIONALIDADE <- factor(ENEM_2023$TP_NACIONALIDADE, levels = c(0,1,2,3,4),
#                                     labels=c('Não informado',
#                                              'Brasileiro(a)',
#                                              'Brasileiro(a) Naturalizado(a)',
#                                              'Estrangeiro(a)',
#                                              'Brasileiro(a) Nato(a), nascido(a) no exterior'))

#ENEM_2023$TP_ST_CONCLUSAO <- factor(ENEM_2023$TP_ST_CONCLUSAO, levels = c(1,2,3,4), 
#                                    labels=c('Já concluí o Ensino Médio',
#                                             'Estou cursando e concluirei o Ensino Médio em 2023',
#                                             'Estou cursando e concluirei o Ensino Médio após 2023',
#                                             'Não concluí e não estou cursando o Ensino Médio'))

#ENEM_2023$TP_ANO_CONCLUIU <- factor(ENEM_2023$TP_ANO_CONCLUIU, levels = c(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17),
#                                    labels=c('Não informado','2022', '2021','2020','2019',
#                                             '2018','2017','2016','2015','2014','2013',
#                                             '2012','2011','2010',
#                                             '2009','2008','2007',
#                                             'Anterior a 2007'))

#ENEM_2023$TP_ESCOLA <- factor(ENEM_2023$TP_ESCOLA, levels = c(1,2,3),
#                              labels=c('Não respondeu',
#                                       'Pública',
#                                       'Privada'))

#ENEM_2023$TP_ENSINO <- factor(ENEM_2023$TP_ENSINO, levels = c(1,2),
#                              labels=c('Ensino Regular',
#                                       'Educação Especial - Modalidade Substitutiva'))


#ENEM_2023$TP_PRESENCA_CN <- factor(ENEM_2023$TP_PRESENCA_CN, levels = c(0,1,2),
#                                    labels=c('Faltou à prova',
#                                            'Presente na prova',
#                                            'Eliminado na prova'))

#ENEM_2023$TP_PRESENCA_CH <- factor(ENEM_2023$TP_PRESENCA_CH, levels = c(0,1,2),
#                                   labels=c('Faltou à prova',
#                                            'Presente na prova',
#                                            'Eliminado na prova'))

#ENEM_2023$TP_PRESENCA_LC <- factor(ENEM_2023$TP_PRESENCA_LC, levels = c(0,1,2),
#                                   labels=c('Faltou à prova',
#                                            'Presente na prova',
#                                            'Eliminado na prova'))

#ENEM_2023$TP_PRESENCA_MT <- factor(ENEM_2023$TP_PRESENCA_MT, levels = c(0,1,2),
#                                   labels=c('Faltou à prova',
#                                            'Presente na prova',
#                                            'Eliminado na prova'))

#ENEM_2023$CO_PROVA_CN <- factor(ENEM_2023$CO_PROVA_CN, 
#levels = c(1221,1222,1223,1224,1225,1226,1227,1228,1229,1301,1302,1303,1304),
#labels = c('Azul','Amarela','Rosa','Cinza','Rosa - Ampliada','Rosa - Superampliada','Laranja - Braile',
#           'Laranja - Adaptada Ledor','Verde - Videoprova - Libras','Azul (Reaplicação)','Amarela (Reaplicação)',
#           'Cinza (Reaplicação)','Rosa (Reaplicação)'))

#ENEM_2023$CO_PROVA_CH <- factor(ENEM_2023$CO_PROVA_CH, 
#levels = c(1191,1192,1193,1194,1195,1196,1197,1198,1199,1271,1272,1273,1274),
#labels = c('Azul','Amarela','Branca','Rosa','Rosa - Ampliada','Rosa - Superampliada','Laranja - Braile',
#           'Laranja - Adaptada Ledor','Verde - Videoprova - Libras','Azul (Reaplicação)','Amarela (Reaplicação)',
#           'Branca (Reaplicação)','Rosa (Reaplicação)'))

#ENEM_2023$CO_PROVA_LC <- factor(ENEM_2023$CO_PROVA_LC, 
#levels = c(1201,1202,1203,1204,1205,1206,1207,1208,1209,1281,1282,1283,1284),
#labels = c('Azul','Amarela','Rosa','Branca','Rosa - Ampliada','Rosa - Superampliada','Laranja - Braile',
#           'Laranja - Adaptada Ledor','Verde - Videoprova - Libras','Azul (Reaplicação)','Amarela (Reaplicação)',
#           'Rosa (Reaplicação)','Branca (Reaplicação)'))

#ENEM_2023$CO_PROVA_MT <- factor(ENEM_2023$CO_PROVA_MT, 
#levels = c(1211,1212,1213,1214,1215,1216,1217,1218,1219,1291,1292,1293,1294),
#labels = c('Azul','Amarela','Rosa','Cinza','Rosa - Ampliada','Rosa - Superampliada','Laranja - Braile',
#           'Laranja - Adaptada Ledor','Verde - Videoprova - Libras','Azul (Reaplicação)','Amarela (Reaplicação)',
#           'Rosa (Reaplicação)','Cinza (Reaplicação)'))

#ENEM_2023$ TP_LINGUA <- factor(ENEM_2023$ TP_LINGUA, levels = c(0,1),
#                                labels=c('Ingl?s','Espanhol'))

#ENEM_2023$TP_STATUS_REDACAO <- factor(ENEM_2023$TP_STATUS_REDACAO, levels = c(1,2,3,4,5,6,7,8,9),
#                                      labels=c('Sem problemas',
#                                               'Anulada','C?pia Texto Motivador',
#                                               'Em Branco','Fere Direitos Humanos',
#                                               'Fuga ao tema',
#                                               'N?o atendimento ao tipo',
#                                               'Texto insuficiente',
#                                               'Parte desconectada'))

#ENEM_2023$Q001 <- factor(ENEM_2023$Q001, levels = c('A','B','C','D','E','F','G','H'),
#                         labels=c('Nunca estudou',
#                                  'N?o completou a 4? s?rie/5? ano do ensino fundamental',
#                                  'Completou a 4? s?rie/5? ano, mas n?o completou a 8? s?rie/9? ano do ensino fundamental',
#                                  'Completou a 8? s?rie/9? ano do ensino fundamental, mas n?o completou o Ensino M?dio',
#                                  'Completou o Ensino M?dio, mas n?o completou a Faculdade',
#                                  'Completou a Faculdade, mas n?o completou a P?s-gradua??o',
#                                  'Completou a P?s-gradua??o','N?o sei'))

#ENEM_2023$Q002 <- factor(ENEM_2023$Q002, levels = c('A','B','C','D','E','F','G','H'),
#                         labels=c('Nunca estudou',
#                                  'N?o completou a 4? s?rie/5? ano do ensino fundamental',
#                                  'Completou a 4? s?rie/5? ano, mas n?o completou a 8? s?rie/9? ano do ensino fundamental',
#                                  'Completou a 8? s?rie/9? ano do ensino fundamental, mas n?o completou o Ensino M?dio',
#                                  'Completou o Ensino M?dio, mas n?o completou a Faculdade',
#                                  'Completou a Faculdade, mas n?o completou a P?s-gradua??o',
#                                  'Completou a P?s-gradua??o','N?o sei'))

#ENEM_2023$Q003 <- factor(ENEM_2023$Q003, levels =  c('A','B','C','D','E','F'),
#                         labels=c('Grupo 1 (Verificar a defini??o no dicion?rio de dados)',
#                                  'Grupo 2 (Verificar a defini??o no dicion?rio de dados)',
#                                  'Grupo 3 (Verificar a defini??o no dicion?rio de dados)',
#                                  'Grupo 4 (Verificar a defini??o no dicion?rio de dados)',
#                                  'Grupo 5 (Verificar a defini??o no dicion?rio de dados)',
#                                  'N?o Sei'))

#ENEM_2023$Q004 <- factor(ENEM_2023$Q004, levels =  c('A','B','C','D','E','F'),
#                         labels=c('Grupo 1 (Verificar a defini??o no dicion?rio de dados)',
#                                  'Grupo 2 (Verificar a defini??o no dicion?rio de dados)',
#                                  'Grupo 3 (Verificar a defini??o no dicion?rio de dados)',
#                                  'Grupo 4 (Verificar a defini??o no dicion?rio de dados)',
#                                  'Grupo 5 (Verificar a defini??o no dicion?rio de dados)',
#                                  'N?o Sei'))

#ENEM_2023$Q005 <- factor(ENEM_2023$Q005, levels = c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20), 
#                         labels=c('1','2','3','4','5','6','7','8','9','10',
#                                  '11','12','13','14','15','16','17','18','19','20'))

#ENEM_2023$Q006 <- factor(ENEM_2023$Q006,levels =  c('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q'),
#                         labels=c('Nenhuma Renda','At? R$ 1.320,00','De R$ 1.320,01 at? R$ 1.980,00.',
#                                  'De R$ 1.980,01 at? R$ 2.640,00.','De R$ 2.640,01 at? R$ 3.300,00.',
#                                  'De R$ 3.300,01 at? R$ 3.960,00.','De R$ 3.960,01 at? R$ 5.280,00.',
#                                  'De R$ 5.280,01 at? R$ 6.600,00.','De R$ 6.600,01 at? R$ 7.920,00.',
#                                  'De R$ 7.920,01 at? R$ 9240,00.','De R$ 9.240,01 at? R$ 10.560,00.',
#                                  'De R$ 10.560,01 at? R$ 11.880,00.','De R$ 11.880,01 at? R$ 13.200,00.',
#                                  'De R$ 13.200,01 at? R$ 15.840,00.','De R$ 15.840,01 at? R$19.800,00.',
#                                  'De R$ 19.800,01 at? R$ 26.400,00.','Acima de R$ 26.400,00.'))

#ENEM_2023$Q007 <- factor(ENEM_2023$Q007, levels = c('A','B','C','D'),
#                         labels=c('N?o','Sim, um ou dois dias por semana',
#                                  'Sim, tr?s ou quatro dias por semana',
#                                  'Sim, pelo menos cinco dias por semana'))

#ENEM_2023$Q008 <- factor(ENEM_2023$Q008, levels = c('A','B','C','D','E'),
#                         labels=c('N?o',
#                                  'Sim, um',
#                                  'Sim, dois',
#                                  'Sim, tr?s',
#                                  'Sim, quatro ou mais'))

#ENEM_2023$Q009 <- factor(ENEM_2023$Q009, levels = c('A','B','C','D','E'),
#                         labels=c('N?o',
#                                  'Sim, um',
#                                  'Sim, dois',
#                                  'Sim, tr?s',
#                                  'Sim, quatro ou mais'))


#ENEM_2023$Q010 <- factor(ENEM_2023$Q010, levels = c('A','B','C','D','E'),
#                         labels=c('N?o',
#                                  'Sim, um',
#                                  'Sim, dois',
#                                  'Sim, tr?s',
#                                  'Sim, quatro ou mais'))

#ENEM_2023$Q011 <- factor(ENEM_2023$Q011, levels = c('A','B','C','D','E'),
#                         labels=c('N?o',
#                                  'Sim, um',
#                                  'Sim, dois',
#                                  'Sim, tr?s',
#                                  'Sim, quatro ou mais'))

#ENEM_2023$Q012 <- factor(ENEM_2023$Q012, levels = c('A','B','C','D','E'),
#                         labels=c('N?o',
#                                  'Sim, um',
#                                  'Sim, dois',
#                                  'Sim, tr?s',
#                                  'Sim, quatro ou mais'))

#ENEM_2023$Q013 <- factor(ENEM_2023$Q013, levels = c('A','B','C','D','E'),
#                         labels=c('N?o',
#                                  'Sim, um',
#                                  'Sim, dois',
#                                  'Sim, tr?s',
#                                  'Sim, quatro ou mais'))

#ENEM_2023$Q014 <- factor(ENEM_2023$Q014, levels = c('A','B','C','D','E'),
#                         labels=c('N?o',
#                                  'Sim, um',
#                                  'Sim, dois',
#                                  'Sim, tr?s',
#                                  'Sim, quatro ou mais'))

#ENEM_2023$Q015 <- factor(ENEM_2023$Q015, levels = c('A','B','C','D','E'),
#                         labels=c('N?o',
#                                  'Sim, um',
#                                  'Sim, dois',
#                                  'Sim, tr?s',
#                                  'Sim, quatro ou mais'))

#ENEM_2023$Q016 <- factor(ENEM_2023$Q016, levels = c('A','B','C','D','E'),
#                         labels=c('N?o',
#                                  'Sim, um',
#                                  'Sim, dois',
#                                  'Sim, tr?s',
#                                  'Sim, quatro ou mais'))

#ENEM_2023$Q017 <- factor(ENEM_2023$Q017, levels = c('A','B','C','D','E'),
#                         labels=c('N?o',
#                                  'Sim, um',
#                                  'Sim, dois',
#                                  'Sim, tr?s',
#                                  'Sim, quatro ou mais'))

#ENEM_2023$Q018 <- factor(ENEM_2023$Q018, levels = c('A','B'), labels=c('N?o','Sim'))

#ENEM_2023$Q019 <- factor(ENEM_2023$Q019, levels = c('A','B','C','D','E'),
#                         labels=c('N?o',
#                                  'Sim, um',
#                                  'Sim, dois',
#                                  'Sim, tr?s',
#                                  'Sim, quatro ou mais'))

#ENEM_2023$Q020 <- factor(ENEM_2023$Q020, levels = c('A','B'), labels=c('N?o','Sim'))
#ENEM_2023$Q021 <- factor(ENEM_2023$Q021, levels = c('A','B'), labels=c('N?o','Sim'))

#ENEM_2023$Q022 <- factor(ENEM_2023$Q022, levels = c('A','B','C','D','E'),
#                         labels=c('N?o',
#                                  'Sim, um',
#                                  'Sim, dois',
#                                  'Sim, tr?s',
#                                  'Sim, quatro ou mais'))

#ENEM_2023$Q023 <- factor(ENEM_2023$Q023, levels = c('A','B'), labels=c('N?o','Sim'))

#ENEM_2023$Q024 <- factor(ENEM_2023$Q024, levels = c('A','B','C','D','E'),
#                         labels=c('N?o',
#                                  'Sim, um',
#                                  'Sim, dois',
#                                  'Sim, tr?s',
#                                  'Sim, quatro ou mais'))

#ENEM_2023$Q025 <- factor(ENEM_2023$Q025, levels = c('A','B'), labels=c('N?o','Sim'))
