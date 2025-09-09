#--------------------------------------------------------
#  INEP/Daeb-Diretoria de Avaliação da Educação Básica 
#  Coordenação-Geral de Medidas da Educação Básica (CGMEB)			
#--------------------------------------------------------

#--------------------------------------------------------
#  PROGRAMA:                                                                                                      
#           INPUT_R_RESULTADOS_2024
#--------------------------------------------------------
#  DESCRI??O:
#           PROGRAMA PARA LEITURA DA BASE DE DADOS
#           RESULTADOS_2024
#--------------------------------------------------------

#------------------------------------------------------------------------
# Obs:                                                                                                                    
#     Para abrir os microdados é necessário salvar este programa e o arquivo                    
#     RESULTADOS_2024.csv no mesmo diretório.	                  
#------------------------------------------------------------------------

#------------------------------------------------------------------------
#                   ATENÇÃO              
#------------------------------------------------------------------------
# Este programa abre a base de dados com os rótulos das variáveis de	                    
# acordo com o dicionário de dados que compõem os microdados. 		  
#------------------------------------------------------------------------

#--------------------
# Instalação do pacote Data.Table
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

RESULTADOS_2024 <- data.table::fread(input='RESULTADOS_2024.csv',
                               integer64='character',
                               skip=0,  #Ler do inicio
                               nrow=-1, #Ler todos os registros
                               na.strings = "", 
                               showProgress = TRUE,
                               encoding = "Latin-1")

#---------------------------
# A script a seguir formata os rótulos das respostas
# Para formatar um item retire o caracter de comentário (#) no início na linha desejada 
#---------------------------

#RESULTADOS_2024$TP_DEPENDENCIA_ADM_ESC <- factor(RESULTADOS_2024$TP_DEPENDENCIA_ADM_ESC, levels = c(1,2,3,4),
#                                           labels=c('Federal',
#                                                    'Estadual',
#                                                    'Municipal',
#                                                    'Privada'))

#RESULTADOS_2024$TP_LOCALIZACAO_ESC <- factor(RESULTADOS_2024$TP_LOCALIZACAO_ESC, levels = c(1,2), labels=c('Urbana','Rural'))

#RESULTADOS_2024$TP_SIT_FUNC_ESC <- factor(RESULTADOS_2024$TP_SIT_FUNC_ESC, levels = c(1,2,3,4),
#                                    labels=c('Em atividade',
#                                             'Paralisada',
#                                             'Extinta',
#                                             'Escola extinta em anos anteriores'))

#RESULTADOS_2024$TP_PRESENCA_CN <- factor(RESULTADOS_2024$TP_PRESENCA_CN, levels = c(0,1,2),
#                                    labels=c('Faltou à prova',
#                                            'Presente na prova',
#                                            'Eliminado na prova'))

#RESULTADOS_2024$TP_PRESENCA_CH <- factor(RESULTADOS_2024$TP_PRESENCA_CH, levels = c(0,1,2),
#                                   labels=c('Faltou à prova',
#                                            'Presente na prova',
#                                            'Eliminado na prova'))

#RESULTADOS_2024$TP_PRESENCA_LC <- factor(RESULTADOS_2024$TP_PRESENCA_LC, levels = c(0,1,2),
#                                   labels=c('Faltou à prova',
#                                            'Presente na prova',
#                                            'Eliminado na prova'))

#RESULTADOS_2024$TP_PRESENCA_MT <- factor(RESULTADOS_2024$TP_PRESENCA_MT, levels = c(0,1,2),
#                                   labels=c('Faltou à prova',
#                                            'Presente na prova',
#                                            'Eliminado na prova'))

#RESULTADOS_2024$CO_PROVA_CN <- factor(RESULTADOS_2024$CO_PROVA_CN, 
#levels = c(1419,1420,1421,1422,1423,1424,1426,1427,1428,1373,1374,1375,1376,1377,1378,1380),
#labels = c('Azul','Amarela','Verde','Cinza','Verde - Ampliada','Verde - Superampliada','Laranja - Adaptada Ledor',
#           'Roxa - Videoprova - Libras','Roxa - Videoprova - Libras - Ampliada','Azul (Reaplicação)','Amarela (Reaplicação)',
#           'Cinza (Reaplicação)','Verde (Reaplicação)','Verde - Ampliada (Reaplicação)','Verde - Superampliada (Reaplicação)',
#           'Laranja - Adaptada Ledor (Reaplicação)'))

#RESULTADOS_2024$CO_PROVA_CH <- factor(RESULTADOS_2024$CO_PROVA_CH, 
#levels = c(1383,1384,1385,1386,1387,1388,1390,1391,1392,1393,1343,1344,1345,1346,1347,1348,1350),
#labels = c('Azul','Amarela','Branca','Verde','Verde - Ampliada','Verde - Superampliada','Laranja - Adaptada Ledor',
#           'Roxa - Videoprova - Libras','Roxa - Videoprova - Libras - Ampliada','Roxa - Videoprova - Libras - Superampliada',
#           'Azul (Reaplicação)','Amarela (Reaplicação)','Branca (Reaplicação)','Verde (Reaplicação)','Verde - Ampliada (Reaplicação)',
#           'Verde - Superampliada (Reaplicação)','Laranja - Adaptada Ledor (Reaplicação)'))

#RESULTADOS_2024$CO_PROVA_LC <- factor(RESULTADOS_2024$CO_PROVA_LC, 
#levels = c(1395,1396,1397,1398,1399,1400,1402,1403,1404,1405,1353,1354,1355,1356,1357,1358,1360),
#labels = c('Azul','Amarela','Verde','Branca','Verde - Ampliada','Verde - Superampliada','Laranja - Adaptada Ledor',
#           'Roxa - Videoprova - Libras','Roxa - Videoprova - Libras - Ampliada','Roxa - Videoprova - Libras - Superampliada',
#           'Azul (Reaplicação)','Amarela (Reaplicação)','Verde (Reaplicação)','Branca (Reaplicação)','Verde - Ampliada (Reaplicação)',
#           'Verde - Superampliada (Reaplicação)','Laranja - Adaptada Ledor (Reaplicação)'))

#RESULTADOS_2024$CO_PROVA_MT <- factor(RESULTADOS_2024$CO_PROVA_MT, 
#levels = c(1407,1408,1409,1410,1411,1412,1414,1415,1416,1363,1364,1365,1366,1367,1368,1370),
#labels = c('Azul','Amarela','Verde','Cinza','Verde - Ampliada','Verde - Superampliada','Laranja - Adaptada Ledor',
#           'Roxa - Videoprova - Libras','Roxa - Videoprova - Libras - Ampliada','Azul (Reaplicação)','Amarela (Reaplicação)',
#           'Verde (Reaplicação)','Cinza (Reaplicação)','Verde - Ampliada (Reaplicação)','Verde - Superampliada (Reaplicação)',
#           'Laranja - Adaptada Ledor (Reaplicação)'))

#RESULTADOS_2024$TP_LINGUA <- factor(RESULTADOS_2024$TP_LINGUA, levels = c(0,1),
#                                labels=c('Inglês','Espanhol'))

#RESULTADOS_2024$TP_STATUS_REDACAO <- factor(RESULTADOS_2024$TP_STATUS_REDACAO, levels = c(1,2,3,4,6,7,8,9),
#                                      labels=c('Sem problemas',
#                                               'Anulada','Cópia Texto Motivador',
#                                               'Em Branco','Fuga ao tema',
#                                               'Não atendimento ao tipo textual',
#                                               'Texto insuficiente',
#                                               'Parte desconectada'))