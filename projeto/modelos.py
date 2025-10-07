import pandas as pd

# ============================== #
# Leitura e tratamento dos dados #
# ============================== #

caminho_arquivo = 'microdados_enem_2023\DADOS\MICRODADOS_ENEM_2023.csv'

# variaveis de interesse
variaveis_socio = [
    'Q001', 'Q002', 'Q003', 'Q004', 'Q005',
    'Q006', 'Q007', 'Q008', 'Q009', 'Q010',
    'Q011', 'Q012', 'Q013', 'Q014', 'Q015',
    'Q016', 'Q017', 'Q018', 'Q019', 'Q020',
    'Q021', 'Q022', 'Q023', 'Q024', 'Q025'
]
variavel_alvo = 'NU_NOTA_MT'
colunas_interesse = variaveis_socio + [variavel_alvo]

# leitura do .csv
dados = pd.read_csv(
    caminho_arquivo,
    sep=';',
    encoding='latin1',
    usecols=lambda col: col in colunas_interesse,
    low_memory=False
)

# filtragem dos dados
dados = dados.dropna(subset=[variavel_alvo]) # remove registros sem nota de matemática
dados = dados.dropna(subset=variaveis_socio) # remove registros sem resposta aos questionaios socioeconomicos
dados.reset_index(drop=True, inplace=True) # reseta o índice após remoções
print("Dimensões do dataset após tratamento:", dados.shape)
print("\nPrévia dos dados tratados:")
print(dados.head())

# salvamento do banco de dados filtrado para debug
dados.to_csv('projeto/arquivos/enem2023_filtrado.csv', index=False, sep=';')
