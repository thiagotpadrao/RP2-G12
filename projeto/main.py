import pandas as pd
import numpy as np
from sklearn.preprocessing import StandardScaler
from sklearn.impute import SimpleImputer
import joblib
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score
from sklearn.model_selection import train_test_split

# ============================ #
# Função: Leitura e filtragem  #
# ============================ #
def ler_e_filtrar_dados(caminho_arquivo, variaveis_socio, variavel_alvo):
    colunas_interesse = variaveis_socio + [variavel_alvo]

    # leitura do CSV
    dados = pd.read_csv(
        caminho_arquivo,
        sep=';',
        encoding='latin1',
        usecols=lambda col: col in colunas_interesse,
        low_memory=False
    )

    # filtragem
    dados = dados.dropna(subset=[variavel_alvo])
    dados = dados.dropna(subset=variaveis_socio)
    dados.reset_index(drop=True, inplace=True)

    # debug
    print("Dimensões do dataset após tratamento:", dados.shape)
    print("\nAmostra dos dados tratados:")
    print(dados.head())

    # salvar para debug
    dados.to_csv('projeto/arquivos/enem2023_filtrado.csv', index=False, sep=';')
    return dados


# ======================================= #
# Função: Mapeamento variáveis categóricas #
# ======================================= #
def mapear_variaveis_categoricas(df):
    # mapeamentos
    var_educacao = ['Q001', 'Q002']
    map_educacao = {'A': 0, 'B': 1, 'C': 2, 'D': 3, 'E': 4, 'F': 5, 'G': 6, 'H': np.nan}

    var_ocupacao = ['Q003', 'Q004']
    map_ocupacao = {'A': 1, 'B': 2, 'C': 3, 'D': 4, 'E': 5, 'F': np.nan}

    var_count = ['Q005']

    var_renda = ['Q006']
    map_renda = {letter: idx for idx, letter in enumerate("ABCDEFGHIJKLMNOPQ")}

    var_freq_emp = ['Q007']
    map_freq_emp = {'A': 0, 'B': 1, 'C': 2, 'D': 3}

    var_itens_casa = [
        'Q008','Q009','Q010','Q011','Q012','Q013',
        'Q014','Q015','Q016','Q017','Q019','Q022','Q024'
    ]
    map_itens_casa = {'A': 0, 'B': 1, 'C': 2, 'D': 3, 'E': 4}

    var_bin = ['Q018','Q020','Q021','Q023','Q025']
    map_bin = {'A': 0, 'B': 1}

    # copia dataframe
    df_mapped = df.copy()

    # normaliza strings
    for col in df_mapped.columns:
        if df_mapped[col].dtype == object:
            df_mapped[col] = df_mapped[col].astype(str).str.strip().str.upper().replace({'': np.nan, 'NAN': np.nan})

    # aplica mapeamentos
    for col in var_educacao:
        if col in df_mapped.columns:
            df_mapped[col] = df_mapped[col].map(map_educacao)

    for col in var_ocupacao:
        if col in df_mapped.columns:
            df_mapped[col] = df_mapped[col].map(map_ocupacao)

    for col in var_count:
        if col in df_mapped.columns:
            df_mapped[col] = pd.to_numeric(df_mapped[col], errors='coerce')

    for col in var_renda:
        if col in df_mapped.columns:
            df_mapped[col] = df_mapped[col].map(map_renda)

    for col in var_freq_emp:
        if col in df_mapped.columns:
            df_mapped[col] = df_mapped[col].map(map_freq_emp)

    for col in var_itens_casa:
        if col in df_mapped.columns:
            df_mapped[col] = df_mapped[col].map(map_itens_casa)

    for col in var_bin:
        if col in df_mapped.columns:
            df_mapped[col] = df_mapped[col].map(map_bin)

    # debug
    print("\nContagem de valores não mapeados / ausentes por coluna (após mapeamento):")
    print(df_mapped.isna().sum())

    return df_mapped


# ============================ #
# Função: Preparação para ML   #
# ============================ #
def preparar_dados_para_modelagem(df, variaveis_socio, variavel_alvo):
    X = df[variaveis_socio].copy()
    y = pd.to_numeric(df[variavel_alvo], errors='coerce')

    # imputação de segurança
    imputer = SimpleImputer(strategy='median')
    X_imputed = imputer.fit_transform(X)

    # normalização
    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X_imputed)

    X_proc = pd.DataFrame(X_scaled, columns=variaveis_socio, index=df.index)

    print("\nTamanhos de X e y processados:", X_proc.shape, y.shape)
    print("\nAmostra das variáveis processadas:")
    print(X_proc.head())

    # salvar objetos e dados
    joblib.dump(imputer, 'projeto/artefatos/imputer_median_socio.joblib')
    joblib.dump(scaler, 'projeto/artefatos/scaler_socio.joblib')
    X_proc.to_csv('projeto/arquivos/enem2023_socio_processado.csv', index=False, sep=';')
    y.to_csv('projeto/arquivos/enem2023_nota_mt.csv', index=False, header=True, sep=';')

    print("\nDados prontos!")

    return X_proc, y

#===========================#
# Modelo: Regressão Linear  #
#===========================#
def treinar_regressao_linear(X_train, X_test, y_train, y_test, salvar_modelo=True):
    print("\nTreinando modelo de Regressão Linear...")

    # inicializa o modelo
    modelo = LinearRegression()

    # treinamento
    modelo.fit(X_train, y_train)

    # previsões
    y_pred = modelo.predict(X_test)

    # métricas
    mae = mean_absolute_error(y_test, y_pred)
    rmse = np.sqrt(mean_squared_error(y_test, y_pred))
    r2 = r2_score(y_test, y_pred)

    # resultados
    print("\n=== Resultados da Regressão Linear ===")
    print(f"MAE  (Erro Médio Absoluto): {mae:.3f}")
    print(f"RMSE (Raiz do Erro Quadrático Médio): {rmse:.3f}")
    print(f"R²   (Coeficiente de Determinação): {r2:.3f}")

    # salvamento do modelo treinado
    if salvar_modelo:
        joblib.dump(modelo, 'projeto/modelos/regressao_linear.joblib')
        print("\nModelo salvo em 'projeto/modelos/regressao_linear.joblib'.")

    return modelo, y_pred

# ======#
# Main  #
# ======#
if __name__ == "__main__":
    caminho_arquivo = 'microdados_enem_2023\DADOS\MICRODADOS_ENEM_2023.csv'
    variaveis_socio = [
        'Q001', 'Q002', 'Q003', 'Q004', 'Q005',
        'Q006', 'Q007', 'Q008', 'Q009', 'Q010',
        'Q011', 'Q012', 'Q013', 'Q014', 'Q015',
        'Q016', 'Q017', 'Q018', 'Q019', 'Q020',
        'Q021', 'Q022', 'Q023', 'Q024', 'Q025'
    ]
    variavel_alvo = 'NU_NOTA_MT'

    # execução das etapas
    dados = ler_e_filtrar_dados(caminho_arquivo, variaveis_socio, variavel_alvo)
    df_mapped = mapear_variaveis_categoricas(dados)
    X_proc, y = preparar_dados_para_modelagem(df_mapped, variaveis_socio, variavel_alvo)
    X_train, X_test, y_train, y_test = train_test_split( X_proc, y, test_size=0.2, random_state=42 )
    modelo_lr, y_pred_lr = treinar_regressao_linear(X_train, X_test, y_train, y_test)
