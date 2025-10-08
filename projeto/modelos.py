import pandas as pd
import numpy as np
from sklearn.preprocessing import StandardScaler
import joblib

#=================================#
# Leitura e filtramento dos dados #
#=================================#

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
print("\nAmostra dos dados tratados:")
print(dados.head())

# salvamento do banco de dados filtrado para debug
dados.to_csv('projeto/arquivos/enem2023_filtrado.csv', index=False, sep=';')

#======================================#
# Mapeamento das variaveis categoricas #
#======================================#

# educacao: A (Nunca estudou) - G (Pos-graduacao); H = 'Nao sei' -> NaN
var_educacao = ['Q001', 'Q002']
map_educacao = {'A': 0, 'B': 1, 'C': 2, 'D': 3, 'E': 4, 'F': 5, 'G': 6, 'H': np.nan}

# ocupacao dos pais: Grupo 1 a 5 ; F = 'Nao sei' -> NaN
var_ocupacao = ['Q003', 'Q004']
map_ocupacao = {'A': 1, 'B': 2, 'C': 3, 'D': 4, 'E': 5, 'F': np.nan}

# contagem de pessoas em casa: strings de '1' a '20' -> numerica, nao categorica
var_count = ['Q005']

# renda em ordem crescente (A-0 = nenhuma renda, Q-16 = mais alta)
var_renda = ['Q006']
map_renda = {letter: idx for idx, letter in enumerate("ABCDEFGHIJKLMNOPQ")}

# frequencia de empregado(a) domestico(a)
var_freq_emp = ['Q007']
map_freq_emp = {'A': 0, 'B': 1, 'C': 2, 'D': 3}

# variaveis quant. itens em casa: "Nao", "um", "dois", "tres", "quatro ou mais"
var_itens_casa = [
    'Q008','Q009','Q010','Q011','Q012','Q013',
    'Q014','Q015','Q016','Q017','Q019','Q022','Q024'
]
map_itens_casa = {'A': 0, 'B': 1, 'C': 2, 'D': 3, 'E': 4}

# variaveis binarias: A = Nao; B = Sim;
var_bin = ['Q018','Q020','Q021','Q023','Q025']
map_bin = {'A': 0, 'B': 1}

df = dados.copy() # aplica mapeamentos

# normaliza strings: remove espaços e garante maiúsculas
for col in df.columns:
    if df[col].dtype == object:
        df[col] = df[col].astype(str).str.strip().str.upper().replace({'': np.nan, 'NAN': np.nan})

# educacao
for col in var_educacao:
    if col in df.columns:
        df[col] = df[col].map(map_educacao)

# ocupacao
for col in var_ocupacao:
    if col in df.columns:
        df[col] = df[col].map(map_ocupacao)

# contagem de pessoas
for col in var_count:
    if col in df.columns:
        df[col] = pd.to_numeric(df[col], errors='coerce')

# renda
for col in var_renda:
    if col in df.columns:
        df[col] = df[col].map(map_renda)

# freq. empreg. domest.
for col in var_freq_emp:
    if col in df.columns:
        df[col] = df[col].map(map_freq_emp)

# quant. itens em casa
for col in var_itens_casa:
    if col in df.columns:
        df[col] = df[col].map(map_itens_casa)

#binarias
for col in var_bin:
    if col in df.columns:
        df[col] = df[col].map(map_bin)

print("\nContagem de valores não mapeados / ausentes por coluna (após mapeamento):")
print(df[ colunas_interesse ].isna().sum())

#===========================#
# Preparacao para modelagem #
#===========================#

# separa variavel alvo das socioeconomicas
X = df[variaveis_socio].copy()
y = pd.to_numeric(df[variavel_alvo], errors='coerce')

# normalizacao dos dados: StandardScaler (media 0, variancia 1)
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)
X_proc = pd.DataFrame(X_scaled, columns=variaveis_socio, index=df.index)
print("\nTamanhos de X e y processados:", X_proc.shape, y.shape)
print("\nAmostra das variáveis processadas:")
print(X_proc.head())

joblib.dump(scaler, 'projeto/artefatos/scaler_socio.joblib')
X_proc.to_csv('projeto/arquivos/enem2023_socio_processado.csv', index=False, sep=';')
y.to_csv('projeto/arquivos/enem2023_nota_mt.csv', index=False, header=True, sep=';')

print("\nDados prontos!")