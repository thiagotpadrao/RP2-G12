#--------------------------------------------------------
#  INEP/Daeb-Diretoria de Avaliação da Educação Básica 
#  Coordenação-Geral de Medidas da Educação Básica (CGMEB)			
#--------------------------------------------------------

#--------------------------------------------------------
#  PROGRAMA:                                                                                                      
#           INPUT_R_ITENS_PROVA_2024
#--------------------------------------------------------
#  DESCRIçã?O:
#           PROGRAMA PARA LEITURA DOS ITENS
#           ITENS_PROVA_2024
#--------------------------------------------------------

#------------------------------------------------------------------------
# Obs:                                                                                                                    
#     Para abrir os microdados é necessário salvar o arquivo                    
#     ITENS_PROVA_2024.csv no diretório raiz. 
#     Ex. Windows C:\
#         Linux \home	                  
#------------------------------------------------------------------------

#------------------------------------------------------------------------
#                   ATENçãO             
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
# edit a função setwd() a seguir informando o local do arquivo.
#Ex. Windows setwd("C:/temp")
#    Linux   setwd("/home")
#--------------------
setwd("C:/")  

#------------------
# Carga dos microdados

itens_2024 <- data.table::fread(input='itens_prova_2024.csv',integer64='character', encoding = "Latin-1")

# A script a seguir formata os rótulos das variáveis
# Para formatar um item retire o caracter de comentário (#) no início na linha desejada 
#---------------------------

#itens_2024$SG_AREA <- factor(itens_2024$SG_AREA, levels = c('CH','CN','LC','MT'),  labels=c('Ciências Humanas','Ciências da Natureza','Linguagens e Códigos','Matemática'))
#itens_2024$TP_LINGUA <- factor(itens_2024$TP_LINGUA, levels = c(0,1),  labels=c('Inglês','Espanhol'))
#itens_2024$IN_ITEM_ADAPTADO <- factor(itens_2024$IN_ITEM_ADAPTADO, levels = c(1,0),  labels=c('Sim','Não'))
#itens_2024$IN_ITEM_ABAN <- factor(itens_2024$IN_ITEM_ABAN, levels = c(1,0),  labels=c('Sim','Não'))
