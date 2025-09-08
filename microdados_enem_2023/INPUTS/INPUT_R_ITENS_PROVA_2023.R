#--------------------------------------------------------
#  INEP/Daeb-Diretoria de Avalia??o da Educa??o B?sica 
#  Coordena??o-Geral de Medidas da Educa??o B?sica (CGMEB)			
#--------------------------------------------------------

#--------------------------------------------------------
#  PROGRAMA:                                                                                                      
#           INPUT_R_ITENS_PROVA_2023
#--------------------------------------------------------
#  DESCRI???O:
#           PROGRAMA PARA LEITURA DOS ITENS
#           ITENS_PROVA_2023
#--------------------------------------------------------

#------------------------------------------------------------------------
# Obs:                                                                                                                    
#     Para abrir os microdados ? necess?rio salvar o arquivo                    
#     ITENS_PROVA_2023.csv no diret?rio raiz. 
#     Ex. Windows C:\
#         Linux \home	                  
#------------------------------------------------------------------------

#------------------------------------------------------------------------
#                   ATEN??O             
#------------------------------------------------------------------------
# Este programa abre a base de dados com os r?tulos das vari?veis de	                    
# acordo com o dicion?rio de dados que comp?em os microdados. 		  
#------------------------------------------------------------------------

#--------------------
# Intala??o do pacote Data.Table
# Se n?o estiver instalado
#--------------------
if(!require(data.table)){install.packages('data.table')}

#--------------------
# Caso deseje trocar o local do arquivo, 
# edit a fun??o setwd() a seguir informando o local do arquivo.
#Ex. Windows setwd("C:/temp")
#    Linux   setwd("/home")
#--------------------
setwd("C:/")  

#------------------
# Carga dos microdados

itens_2023 <- data.table::fread(input='itens_prova_2023.csv',integer64='character')

# A script a seguir formata os r?tulos das vari?veis
# Para formatar um item retire o caracter de coment?rio (#) no in?cio na linha desejada 
#---------------------------

#itens_2023$SG_AREA <- factor(itens_2023$SG_AREA, levels = c('CH','CN','LC','MT'),  labels=c('Ci?ncias Humanas','Ci?ncias da Natureza','Linguagens e C?digos','Matem?tica'))
#itens_2023$TP_LINGUA <- factor(itens_2023$TP_LINGUA, levels = c(0,1),  labels=c('Ingl?s','Espanhol'))
#itens_2023$IN_ITEM_ADAPTADO <- factor(itens_2023$IN_ITEM_ADAPTADO, levels = c(1,0),  labels=c('Sim','N?o'))
#itens_2023$IN_ITEM_ABAN <- factor(itens_2023$IN_ITEM_ABAN, levels = c(1,0),  labels=c('Sim','N?o'))
