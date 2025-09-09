#--------------------------------------------------------
#  INEP/Daeb-Diretoria de Avaliação da Educação Básica 
#  Coordenação-Geral de Medidas da Educação Básica (CGMEB)			
#--------------------------------------------------------

#--------------------------------------------------------
#  PROGRAMA:                                                                                                      
#           INPUT_R_PARTICIPANTES_2024
#--------------------------------------------------------
#  DESCRI??O:
#           PROGRAMA PARA LEITURA DA BASE DE DADOS
#           PARTICIPANTES_2024
#--------------------------------------------------------

#------------------------------------------------------------------------
# Obs:                                                                                                                    
#     Para abrir a base de dados é necessário salvar este programa e o arquivo                    
#     PARTICIPANTES_2024.csv no mesmo diretório.	                  
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

PARTICIPANTES_2024 <- data.table::fread(input='PARTICIPANTES_2024.csv',
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

#PARTICIPANTES_2024$TP_FAIXA_ETARIA <- factor(PARTICIPANTES_2024$TP_FAIXA_ETARIA, 
#                                    levels = c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20), 
#                                    labels = c('Menor de 17 anos','17 anos','18 anos','19 anos','20 anos','21 anos','22 anos',
#                                               '23 anos','24 anos','25 anos','Entre 26 e 30 anos','Entre 31 e 35 anos','Entre 36 e 40 anos',
#                                               'Entre 41 e 45 anos','Entre 46 e 50 anos','Entre 51 e 55 anos','Entre 56 e 60 anos','Entre 61 e 65 anos',
#                                               'Entre 66 e 70 anos','Maior de 70 anos'))

#PARTICIPANTES_2024$IN_TREINEIRO <- factor(PARTICIPANTES_2024$IN_TREINEIRO, levels = c(0,1),  labels=c('Não','Sim'))

#PARTICIPANTES_2024$TP_SEXO <- factor(PARTICIPANTES_2024$TP_SEXO, levels = c('M','F'), labels=c('Masculino','Feminino'))

#PARTICIPANTES_2024$TP_ESTADO_CIVIL <- factor(PARTICIPANTES_2024$TP_ESTADO_CIVIL, levels = c(0,1,2,3,4),
#                                    labels=c('Não informado',
#                                             'Solteiro(a)',
#                                             'Casado(a)/Mora com um(a) companheiro(a)',
#                                             'Divorciado(a)/Desquitado(a)/Separado(a)',
#                                             'Viúvo(a)'))

#PARTICIPANTES_2024$TP_COR_RACA <- factor(PARTICIPANTES_2024$TP_COR_RACA, levels = c(0,1,2,3,4,5,6),
#                                labels=c('Não declarado',
#                                         'Branca','Preta',
#                                         'Parda','Amarela',
#                                         'Indígena',
#                                         'Não dispõe da informação'))

#PARTICIPANTES_2024$TP_NACIONALIDADE <- factor(PARTICIPANTES_2024$TP_NACIONALIDADE, levels = c(0,1,2,3,4),
#                                     labels=c('Não informado',
#                                              'Brasileiro(a)',
#                                              'Brasileiro(a) Naturalizado(a)',
#                                              'Estrangeiro(a)',
#                                              'Brasileiro(a) Nato(a), nascido(a) no exterior'))

#PARTICIPANTES_2024$TP_ST_CONCLUSAO <- factor(PARTICIPANTES_2024$TP_ST_CONCLUSAO, levels = c(1,2,3,4), 
#                                    labels=c('Já concluí o Ensino Médio',
#                                             'Estou cursando e concluirei o Ensino Médio em 2024',
#                                             'Estou cursando e concluirei o Ensino Médio após 2024',
#                                             'Não concluí e Não estou cursando o Ensino Médio'))

#PARTICIPANTES_2024$TP_ANO_CONCLUIU <- factor(PARTICIPANTES_2024$TP_ANO_CONCLUIU, levels = c(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18),
#                                    labels=c('Não informado','2023', '2022','2021','2020',
#                                             '2019','2018','2017','2016','2015','2014','2013',
#                                             '2012','2011','2010','2009','2008','2007',
#                                             'Antes de 2007'))

#PARTICIPANTES_2024$TP_ENSINO <- factor(PARTICIPANTES_2024$TP_ENSINO, levels = c(1,2),
#                              labels=c('Ensino Regular',
#                                       'Educação Especial - Modalidade Substitutiva'))

#PARTICIPANTES_2024$Q001 <- factor(PARTICIPANTES_2024$Q001, levels = c('A','B','C','D','E','F','G','H'),
#                         labels=c('Nunca estudou.',
#                                  'Não completou a 4ª série/5º ano do Ensino Fundamental.',
#                                  'Completou a 4ª série/5º ano, mas Não completou a 8ª série/9Âº ano do Ensino Fundamental.',
#                                  'Completou a 8ª série/9º ano do Ensino Fundamental, mas Não completou o Ensino Médio.',
#                                  'Completou o Ensino Médio, mas Não completou a Faculdade.',
#                                  'Completou a Faculdade, mas Não completou a Pós-graduação.',
#                                  'Completou a Pós-graduação.','Não sei.'))

#PARTICIPANTES_2024$Q002 <- factor(PARTICIPANTES_2024$Q002, levels = c('A','B','C','D','E','F','G','H'),
#                         labels=c('Nunca estudou.',
#                                  'Não completou a 4ª série/5º ano do Ensino Fundamental.',
#                                  'Completou a 4ª série/5º ano, mas Não completou a 8ª série/9Âº ano do Ensino Fundamental.',
#                                  'Completou a 8ª série/9º ano do Ensino Fundamental, mas Não completou o Ensino Médio.',
#                                  'Completou o Ensino Médio, mas Não completou a Faculdade.',
#                                  'Completou a Faculdade, mas Não completou a Pós-graduação.',
#                                  'Completou a Pós-graduação.','Não sei.'))

#PARTICIPANTES_2024$Q003 <- factor(PARTICIPANTES_2024$Q003, levels =  c('A','B','C','D','E','F'),
#                         labels=c('Grupo 1: Lavrador, agricultor sem empregados, bóia fria, criador de animais (gado, porcos, galinhas, ovelhas, cavalos etc.), apicultor, pescador, lenhador, seringueiro, extrativista.',
#                                  'Grupo 2: Diarista, empregado doméstico, cuidador de idosos, babá, cozinheiro (em casas particulares), motorista particular, jardineiro, faxineiro de empresas e prédios, vigilante, porteiro, carteiro, office-boy, vendedor, caixa, atendente de loja, auxiliar administrativo, recepcionista, servente de pedreiro, repositor de mercadoria.',
#                                  'Grupo 3: Padeiro, cozinheiro industrial ou em restaurantes, sapateiro, costureiro, joalheiro, torneiro mecÃ¢nico, operador de máquinas, soldador, operário de fábrica, trabalhador da mineração, pedreiro, pintor, eletricista, encanador, motorista, caminhoneiro, taxista.',
#                                  'Grupo 4: Professor (de ensino fundamental ou médio, idioma, música, artes etc.), técnico (de enfermagem, contabilidade, eletrÃ´nica etc.), policial, militar de baixa patente (soldado, cabo, sargento), corretor de imóveis, supervisor, gerente, mestre de obras, pastor, microempresário (proprietário de empresa com menos de 10 empregados), pequeno comerciante, pequeno proprietário de terras, trabalhador autÃ´nomo ou por conta própria.',
#                                  'Grupo 5: Médico, engenheiro, dentista, psicólogo, economista, advogado, juiz, promotor, defensor, delegado, tenente, capitÃ£o, coronel, professor universitário, diretor em empresas públicas ou privadas, polÃ­tico, proprietário de empresas com mais de 10 empregados.',
#                                  'Não sei.'))

#PARTICIPANTES_2024$Q004 <- factor(PARTICIPANTES_2024$Q004, levels =  c('A','B','C','D','E','F'),
#                         labels=c('Grupo 1: Lavradora, agricultora sem empregados, bóia fria, criadora de animais (gado, porcos, galinhas, ovelhas, cavalos etc.), apicultora, pescadora, lenhadora, seringueira, extrativista.',
#                                  'Grupo 2: Diarista, empregada doméstica, cuidadora de idosos, babá, cozinheira (em casas particulares), motorista particular, jardineira, faxineira de empresas e prédios, vigilante, porteira, carteira, office-boy, vendedora, caixa, atendente de loja, auxiliar administrativa, recepcionista, servente de pedreiro, repositora de mercadoria.',
#                                  'Grupo 3: Padeira, cozinheira industrial ou em restaurantes, sapateira, costureira, joalheira, torneira mecÃ¢nica, operadora de máquinas, soldadora, operária de fábrica, trabalhadora da mineração, pedreira, pintora, eletricista, encanadora, motorista, caminhoneira, taxista.',
#                                  'Grupo 4: Professora (de ensino fundamental ou médio, idioma, música, artes etc.), técnica (de enfermagem, contabilidade, eletrÃ´nica etc.), policial, militar de baixa patente (soldado, cabo, sargento), corretora de imóveis, supervisora, gerente, mestre de obras, pastora, microempresária (proprietária de empresa com menos de 10 empregados), pequena comerciante, pequena proprietária de terras, trabalhadora autÃ´noma ou por conta própria.',
#                                  'Grupo 5: Médica, engenheira, dentista, psicóloga, economista, advogada, juÃ­za, promotora, defensora, delegada, tenente, capitÃ£, coronel, professora universitária, diretora em empresas públicas ou privadas, polÃ­tica, proprietária de empresas com mais de 10 empregados.',
#                                  'Não sei.'))

#PARTICIPANTES_2024$Q005 <- factor(PARTICIPANTES_2024$Q005, levels = c(A,B), 
#                         labels=c('1, pois moro sozinho(a).','2','3','4','5','6','7','8','9','10',
#                                  '11','12','13','14','15','16','17','18','19','20'))

#PARTICIPANTES_2024$Q006 <- factor(PARTICIPANTES_2024$Q006,levels =  c('A','B'),
#                         labels=c('Não','Sim'))

#PARTICIPANTES_2024$Q007 <- factor(PARTICIPANTES_2024$Q007, levels = c('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q'),
#                         labels=c('Nenhuma Renda','Até R$ 1.412,00.','De R$ 1.412,01 até R$ 2.118,00.',
#                                  'De R$ 2.118,01 até R$ 2.824,00.','De R$ 2.824,01 até R$ 3.530,00.',
#                                  'De R$ 3.530,01 até R$ 4.236,00.','De R$ 4.236,01 até R$ 5.648,00.',
#                                  'De R$ 5.648,01 até R$ 7.060,00.','De R$ 7.060,01 até R$ 8.472,00.',
#                                  'De R$ 8.472,01 até R$ 9.884,00.','De R$ 9.884,01 até R$ 11.296,00.',
#                                  'De R$ 11.296,01 até R$ 12.708,00.','De R$ 12.708,01 até R$ 14.120,00.',
#                                  'De R$ 14.120,01 até R$ 16.944,00.','De R$ 16.944,01 até R$ 21.180,00.',
#                                  'De R$ 21.180,01 até R$ 28.240,00.','Acima de R$ 28.240,00.'))

#PARTICIPANTES_2024$Q008 <- factor(PARTICIPANTES_2024$Q008, levels = c('A','B','C','D'),
#                         labels=c('Não.',
#                                  'Sim, um ou dois dias por semana.',
#                                  'Sim, três ou quatro dias por semana.',
#                                  'SSim, pelo menos cinco dias por semana.'))

#PARTICIPANTES_2024$Q009 <- factor(PARTICIPANTES_2024$Q009, levels = c('A','B','C','D'),
#                         labels=c('Não.',
#                                  'Sim, um.',
#                                  'Sim, dois.',
#                                  'Sim, três ou mais.'))

#PARTICIPANTES_2024$Q010 <- factor(PARTICIPANTES_2024$Q010, levels = c('A','B','C','D'),
#                         labels=c('Não.',
#                                  'Sim, um.',
#                                  'Sim, dois.',
#                                  'Sim, três ou mais.'))

#PARTICIPANTES_2024$Q011 <- factor(PARTICIPANTES_2024$Q011, levels = c('A','B','C','D'),
#                         labels=c('Não.',
#                                  'Sim, um.',
#                                  'Sim, dois.',
#                                  'Sim, três ou mais.'))

#PARTICIPANTES_2024$Q012 <- factor(PARTICIPANTES_2024$Q012, levels = c('A','B','C','D'),
#                         labels=c('Não.',
#                                  'Sim, um.',
#                                  'Sim, dois.',
#                                  'Sim, três ou mais.'))

#PARTICIPANTES_2024$Q013 <- factor(PARTICIPANTES_2024$Q013, levels = c('A','B','C','D'),
#                         labels=c('Não.',
#                                  'Sim, um.',
#                                  'Sim, dois.',
#                                  'Sim, três ou mais.'))

#PARTICIPANTES_2024$Q014 <- factor(PARTICIPANTES_2024$Q014, levels = c('A','B'),
#                         labels=c('Não.',
#                                  'Sim'))

#PARTICIPANTES_2024$Q015 <- factor(PARTICIPANTES_2024$Q015, levels = c('A','B'),
#                         labels=c('Não.',
#                                  'Sim'))

#PARTICIPANTES_2024$Q016 <- factor(PARTICIPANTES_2024$Q016, levels = c('A','B'),
#                         labels=c('Não.',
#                                  'Sim'))

#PARTICIPANTES_2024$Q017 <- factor(PARTICIPANTES_2024$Q017, levels = c('A','B'),
#                         labels=c('Não.',
#                                  'Sim'))

#PARTICIPANTES_2024$Q018 <- factor(PARTICIPANTES_2024$Q018, levels = c('A','B','C','D'),
#                         labels=c('Não.',
#                                  'Sim, uma.',
#                                  'Sim, duas.',
#                                  'Sim, três ou mais.'))

#PARTICIPANTES_2024$Q019 <- factor(PARTICIPANTES_2024$Q019, levels = c('A','B'),
#                         labels=c('Não.',
#                                  'Sim'))

#PARTICIPANTES_2024$Q020 <- factor(PARTICIPANTES_2024$Q020, levels = c('A','B'),
#                         labels=c('Não.',
#                                  'Sim'))

#PARTICIPANTES_2024$Q021 <- factor(PARTICIPANTES_2024$Q021, levels = c('A','B','C','D','E'),
#                         labels=c('Não.',
#                                  'Sim, um.',
#                                  'Sim, dois.',
#                                  'Sim, três.',
#                                  'Sim, quatro ou mais.'))

#PARTICIPANTES_2024$Q022 <- factor(PARTICIPANTES_2024$Q022, levels = c('A','B','C','D','E'),
#                         labels=c('Não',
#                                  'Sim, um',
#                                  'Sim, dois',
#                                  'Sim, três ou mais',
#                                   'Sim, quatro ou mais'))

#PARTICIPANTES_2024$Q023 <- factor(PARTICIPANTES_2024$Q023, levels = c('A','B','C','D','E','F'),
#                         labels=c('Somente em escola pública.',
#                                  'Parte em escola pública e parte em escola privada sem bolsa de estudo integral.',
#                                  'Parte em escola pública e parte em escola privada com bolsa de estudo integral.',
#                                  'Somente em escola privada sem bolsa de estudo integral.',
#                                  'Somente em escola privada com bolsa de estudo integral.',
#                                  'Não frequentei escola de Ensino Médio.'))
