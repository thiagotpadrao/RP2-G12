import pandas as pd
import numpy as np
import statsmodels.api as sm
import os
from sklearn.preprocessing import StandardScaler
from sklearn.impute import SimpleImputer
import joblib
from sklearn.linear_model import LinearRegression
from sklearn.ensemble import RandomForestRegressor
from sklearn.model_selection import GridSearchCV
from sklearn.model_selection import KFold
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score
from sklearn.model_selection import train_test_split
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
plt.style.use('default')

#======================#
# Leitura e filtragem  #
#======================#
def ler_e_filtrar_dados(caminho_arquivo, variaveis_socio, variavel_alvo):
    colunas_interesse = variaveis_socio + [variavel_alvo]

    # leitura do CSV dos microdados do ENEM
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

    print("Dimensões do dataset após tratamento:", dados.shape)
    print("\nAmostra dos dados tratados:")
    print(dados.head())

    dados.to_csv('projeto/dados/enem2023_filtrado.csv', index=False, sep=';')
    return dados

#==================================#
# Mapeamento variáveis categóricas #
#==================================#
def mapear_variaveis_categoricas(df):
    
    # mapeamentos
    var_tp_escola = 'TP_ESCOLA'

    var_educacao = ['Q001', 'Q002']
    map_educacao = {'A': 0, 'B': 1, 'C': 2, 'D': 3, 'E': 4, 'F': 5, 'G': 6, 'H': np.nan}

    var_ocupacao = ['Q003', 'Q004']
    map_ocupacao = {'A': 1, 'B': 2, 'C': 3, 'D': 4, 'E': 5, 'F': np.nan}

    var_count = 'Q005'

    var_renda = 'Q006'
    map_renda = {letter: idx for idx, letter in enumerate("ABCDEFGHIJKLMNOPQ")}

    var_freq_emp = 'Q007'
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
    if var_tp_escola in df_mapped.columns:
        df_mapped[var_tp_escola] = pd.to_numeric(df_mapped[var_tp_escola], errors="coerce")
    
    for col in var_educacao:
        if col in df_mapped.columns:
            df_mapped[col] = df_mapped[col].map(map_educacao)

    for col in var_ocupacao:
        if col in df_mapped.columns:
            df_mapped[col] = df_mapped[col].map(map_ocupacao)

    if var_count in df_mapped.columns:
        df_mapped[var_count] = pd.to_numeric(df_mapped[var_count], errors='coerce')

    if var_renda in df_mapped.columns:
        df_mapped[var_renda] = df_mapped[var_renda].map(map_renda)

    if var_freq_emp in df_mapped.columns:
        df_mapped[var_freq_emp] = df_mapped[var_freq_emp].map(map_freq_emp)

    for col in var_itens_casa:
        if col in df_mapped.columns:
            df_mapped[col] = df_mapped[col].map(map_itens_casa)

    for col in var_bin:
        if col in df_mapped.columns:
            df_mapped[col] = df_mapped[col].map(map_bin)

    print("\nContagem de valores não mapeados / ausentes por coluna (após mapeamento):")
    print(df_mapped.isna().sum())

    return df_mapped

#=======================================#
# Preparação dos dados para treinamento #
#=======================================#
def preparar_dados_para_modelagem(df, variaveis_socio, variavel_alvo):
    X = df[variaveis_socio].copy()
    y = pd.to_numeric(df[variavel_alvo], errors='coerce')

    # imputação para os valores "Não sei" -> NaN
    imputer = SimpleImputer(strategy='median')
    X_imputed = imputer.fit_transform(X)

    # normalização
    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X_imputed)

    X_proc = pd.DataFrame(X_scaled, columns=variaveis_socio, index=df.index)

    print("\nTamanhos de X e y processados:", X_proc.shape, y.shape)
    print("\nAmostra das variáveis processadas:")
    print(X_proc.head())
    joblib.dump(imputer, 'projeto/artefatos/imputer_median_socio.joblib')
    joblib.dump(scaler, 'projeto/artefatos/scaler_socio.joblib')
    X_proc.to_csv('projeto/dados/enem2023_socio_processado.csv', index=False, sep=';')
    y.to_csv('projeto/dados/enem2023_nota_mt.csv', index=False, header=True, sep=';')
    print("\nDados prontos!")

    return X_proc, y

#==================#
# Regressão Linear #
#==================#
def regressao_linear(X_train, X_test, y_train, y_test, numero_folds, usar_cross_validation=False, salvar_modelo=True):
    print("\nTreinando modelo de Regressão Linear...")

    # realiza (ou não) o cross validation k-fold
    if usar_cross_validation:
        print("\nIniciando treinamento COM cross validation K-fold...")

        kf = KFold(n_splits=numero_folds, shuffle=True, random_state=42)
        maes, rmses, r2s = [], [], []
        fold = 1

        for train_idx, test_idx in kf.split(X_train):
            print(f"\n--- Fold {fold} ---")

            X_tr, X_te = X_train.iloc[train_idx], X_train.iloc[test_idx]
            y_tr, y_te = y_train.iloc[train_idx], y_train.iloc[test_idx]

            # inicialização treinamento e predição
            modelo = LinearRegression()
            modelo.fit(X_tr, y_tr)
            y_pred_fold = modelo.predict(X_te)

            # métricas
            mae = mean_absolute_error(y_te, y_pred_fold)
            rmse = np.sqrt(mean_squared_error(y_te, y_pred_fold))
            r2 = r2_score(y_te, y_pred_fold)

            print(f"MAE  : {mae:.3f}")
            print(f"RMSE : {rmse:.3f}")
            print(f"R²   : {r2:.3f}")

            maes.append(mae)
            rmses.append(rmse)
            r2s.append(r2)

            fold += 1

        print("\n=== Médias das métricas dos folds ===")
        print(f"MAE Médio: {np.mean(maes):.3f}")
        print(f"RMSE Médio: {np.mean(rmses):.3f}")
        print(f"R² Médio: {np.mean(r2s):.3f}")

    else:
        print("\nIniciando treinamento SEM cross validation K-fold...")

    # treinamento final com todo X train:

    # inicialização treinamento e predição
    modelo = LinearRegression()
    modelo.fit(X_train, y_train)
    y_pred = modelo.predict(X_test)

    # métricas
    mae = mean_absolute_error(y_test, y_pred)
    rmse = np.sqrt(mean_squared_error(y_test, y_pred))
    r2 = r2_score(y_test, y_pred)

    print("\n=== Resultados da Regressão Linear ===")
    print(f"MAE  (Erro Médio Absoluto): {mae:.3f}")
    print(f"RMSE (Raiz do Erro Quadrático Médio): {rmse:.3f}")
    print(f"R²   (Coeficiente de Determinação): {r2:.3f}")

    # plots:
     
    # scatter: previsão vs real
    plt.figure(figsize=(6, 6))
    plt.scatter(y_test, y_pred, s=2)
    plt.xlabel("Valores Reais")
    plt.ylabel("Previsões")
    plt.title("Regressão Linear - Previsões vs Reais")
    plt.grid(True)
    plt.savefig("projeto/estatisticas/regressao_linear/rl_scat_pred_vs_real.png", dpi=300)
    plt.close()

    # scatter: previsão vs resíduos
    residuos = y_test - y_pred
    plt.figure(figsize=(6, 6))
    plt.scatter(y_pred, residuos, s=2)
    plt.axhline(0, color="black")
    plt.xlabel("Previsões")
    plt.ylabel("Resíduos")
    plt.title("Regressão Linear - Resíduos vs Previsões")
    plt.grid(True)
    plt.savefig("projeto/estatisticas/regressao_linear/rl_scat_pred_vs_resi.png", dpi=300)
    plt.close()

    # histograma: resíduos
    plt.figure(figsize=(6, 6))
    plt.hist(residuos, bins=50)
    plt.xlabel("Erro")
    plt.ylabel("Frequência")
    plt.title("Regressão Linear - Distribuição dos Resíduos")
    plt.grid(True)
    plt.savefig("projeto/estatisticas/regressao_linear/rl_hist_resi.png", dpi=300)
    plt.close()

    if salvar_modelo:
        joblib.dump(modelo, 'projeto/modelos/regressao_linear.joblib')

    return modelo, y_pred

#=======================================#
# Regressão Linear (usando statsmodels) #
#=======================================#
def regressao_statsmodels(X_train, X_test, y_train, y_test, numero_folds, usar_cross_validation=False, salvar_modelo=True):
    print("\nTreinando modelo de Regressão Linear (StatsModels)...")

    # realiza (ou não) o cross validation k-fold
    if usar_cross_validation:
        print("\nIniciando treinamento COM cross validation K-fold...")

        kf = KFold(n_splits=numero_folds, shuffle=True, random_state=42)
        maes, rmses, r2s = [], [], []
        fold = 1

        for train_idx, val_idx in kf.split(X_train):

            print(f"\n--- Fold {fold} ---")

            X_tr, X_te = X_train.iloc[train_idx], X_train.iloc[val_idx]
            y_tr, y_te = y_train.iloc[train_idx], y_train.iloc[val_idx]

            # inicialização treinamento e predição
            modelo = sm.OLS(y_tr, sm.add_constant(X_tr)).fit()
            y_pred_fold = modelo.predict(sm.add_constant(X_te))

            # métricas
            mae = mean_absolute_error(y_te, y_pred_fold)
            rmse = np.sqrt(mean_squared_error(y_te, y_pred_fold))
            r2 = r2_score(y_te, y_pred_fold)

            print(f"MAE  : {mae:.3f}")
            print(f"RMSE : {rmse:.3f}")
            print(f"R²   : {r2:.3f}")

            maes.append(mae)
            rmses.append(rmse)
            r2s.append(r2)

            fold += 1

        print("\n=== Médias das métricas dos folds ===")
        print(f"MAE Médio: {np.mean(maes):.3f}")
        print(f"RMSE Médio: {np.mean(rmses):.3f}")
        print(f"R² Médio: {np.mean(r2s):.3f}")

    else:
        print("\nIniciando treinamento SEM cross validation K-fold...")

    # treinamento final com todo X train:

    # inicialização treinamento e predição
    modelo = sm.OLS(y_train, sm.add_constant(X_train)).fit()
    y_pred = modelo.predict(sm.add_constant(X_test))

    # métricas
    mae = mean_absolute_error(y_test, y_pred)
    rmse = np.sqrt(mean_squared_error(y_test, y_pred))
    r2 = r2_score(y_test, y_pred)

    print("\n=== Resultados da Regressão Linear (StatsModels) ===")
    print(f"MAE (Erro Médio Absoluto): {mae:.3f}")
    print(f"RMSE (Raiz do Erro Quadrático Médio): {rmse:.3f}")
    print(f"R² (Coeficiente de Determinação): {r2:.3f}")
    print(modelo.summary())

    # plots:

    # qq plot: resíduos
    residuos = y_test - y_pred
    sm.qqplot(residuos, line='45')
    plt.title("StatsModels - QQ Plot dos Resíduos")
    plt.grid(True)
    plt.savefig("projeto/estatisticas/regressao_linear_statsmodels/rlsm_qqplot_resi.png", dpi=300)
    plt.close()

    if salvar_modelo:
        caminho_summary = "projeto/estatisticas/regressao_linear_statsmodels/rlsm_summary.txt"
        with open(caminho_summary, "w", encoding="utf-8") as f:
            f.write(str(modelo.summary()))

    return modelo, y_pred

#===============#
# Random Forest #
#===============#
def random_forest(X_train, X_test, y_train, y_test, tam_amostra, usar_gridsearch=False, usar_cross_validation=False, numero_folds=5, salvar_modelo=True):
    print("\nTreinando modelo de Random Forest...")

    # pegando uma amostra dos dados
    X_train_sample = X_train.sample(n=tam_amostra, random_state=42)
    y_train_sample = y_train.loc[X_train_sample.index]

    # escolhe o modelo base (com ou sem gridsearch)
    if not usar_gridsearch:
        print("Treinamento SEM GridSearch")
        modelo = RandomForestRegressor(
            n_estimators=300,        # numero de arvores na floresta
            max_depth=20,            # profundidade máxima das árvores
            min_samples_split=10,    # mínimo de amostras para dividir um nó
            min_samples_leaf=4,      # tamanho mínimo de cada folha
            max_features='sqrt',     # quantas features são consideradas por split
            bootstrap=True,          # usar amostragem bootstrap ou não
            random_state=42,         # semente para reprodução dos resultados
            n_jobs=2                 # quantidade de núcleos usados
        )
        modelo.fit(X_train_sample, y_train_sample)
    else:
        print("Treinamento COM GridSearch")
        modelo_base = RandomForestRegressor(random_state=42, n_jobs=2)
        grid = {
            "n_estimators": [150, 300],
            "max_depth": [10, 20, None],
            "min_samples_split": [2, 4],
            "min_samples_leaf": [1, 2],
            "max_features": ["sqrt", "log2"]
        }
        gridsearch = GridSearchCV(
            estimator=modelo_base,
            param_grid=grid,
            scoring="neg_mean_absolute_error",
            cv=3,
            verbose=1,
            n_jobs=2
        )
        gridsearch.fit(X_train_sample, y_train_sample)
        modelo = gridsearch.best_estimator_
        print("\nMelhores parâmetros encontrados:")
        print(gridsearch.best_params_, "\n")

    # realiza (ou não) o cross validation k-fold
    if usar_cross_validation:
        print("\nIniciando treinamento COM cross validation K-fold...")
       
        kf = KFold(n_splits=numero_folds, shuffle=True, random_state=42)
        maes, rmses, r2s = [], [], []
        fold = 1

        for train_idx, val_idx in kf.split(X_train_sample):
            print(f"\n--- Fold {fold} ---")

            X_tr, X_val = X_train_sample.iloc[train_idx], X_train_sample.iloc[val_idx]
            y_tr, y_val = y_train_sample.iloc[train_idx], y_train_sample.iloc[val_idx]

            # inicialização treinamento e predição
            modelo.fit(X_tr, y_tr)
            y_pred_val = modelo.predict(X_val)

            # métricas
            mae = mean_absolute_error(y_val, y_pred_val)
            rmse = np.sqrt(mean_squared_error(y_val, y_pred_val))
            r2 = r2_score(y_val, y_pred_val)

            print(f"MAE  : {mae:.3f}")
            print(f"RMSE : {rmse:.3f}")
            print(f"R²   : {r2:.3f}")

            maes.append(mae)
            rmses.append(rmse)
            r2s.append(r2)

            fold += 1

        print("\n=== Médias das métricas dos folds ===")
        print(f"MAE Médio: {np.mean(maes):.3f}")
        print(f"RMSE Médio: {np.mean(rmses):.3f}")
        print(f"R² Médio: {np.mean(r2s):.3f}")

        # treina o modelo final com todo o conjunto
        modelo.fit(X_train_sample, y_train_sample)

        # não faz plots nem métricas do X_test quando está em CV
        return modelo, None
    else:
        print("\nIniciando treinamento SEM cross validation K-fold...")

    # previsões
    y_pred = modelo.predict(X_test)

    # métricas
    mae = mean_absolute_error(y_test, y_pred)
    rmse = np.sqrt(mean_squared_error(y_test, y_pred))
    r2 = r2_score(y_test, y_pred)

    print("\n=== Resultados da Random Forest ===")
    print(f"MAE  (Erro Médio Absoluto): {mae:.3f}")
    print(f"RMSE (Raiz do Erro Quadrático Médio): {rmse:.3f}")
    print(f"R²   (Coeficiente de Determinação): {r2:.3f}")

    # plots:

    # scatter: previsões vs real
    plt.figure(figsize=(6, 6))
    plt.scatter(y_test, y_pred, s=2)
    plt.xlabel("Valores Reais")
    plt.ylabel("Previsões")
    plt.title("Random Forest - Previsões vs Reais")
    plt.grid(True)
    plt.savefig("projeto/estatisticas/random_forest/rf_scat_pred_vs_real.png", dpi=300)
    plt.close()

    # scatter: previsões vs resíduos
    residuos = y_test - y_pred
    plt.figure(figsize=(6, 6))
    plt.scatter(y_pred, residuos, s=2)
    plt.axhline(0, color="black")
    plt.xlabel("Previsões")
    plt.ylabel("Resíduos")
    plt.title("Random Forest - Resíduos vs Previsões")
    plt.grid(True)
    plt.savefig("projeto/estatisticas/random_forest/rf_scat_pred_vs_resi.png", dpi=300)
    plt.close()

    # histograma: resíduos
    plt.figure(figsize=(6, 6))
    plt.hist(residuos, bins=50)
    plt.xlabel("Erro")
    plt.ylabel("Frequência")
    plt.title("Random Forest - Distribuição dos Resíduos")
    plt.grid(True)
    plt.savefig("projeto/estatisticas/random_forest/rf_hist_resi.png", dpi=300)
    plt.close()

    # importancias das features (top15)
    importancias = pd.DataFrame({
        "Variável": X_train.columns,
        "Importância": modelo.feature_importances_
    }).sort_values(by="Importância", ascending=False)
    plt.figure(figsize=(10, 6))
    top15 = importancias.head(15)
    plt.barh(top15["Variável"], top15["Importância"])
    plt.xlabel("Importância")
    plt.title("Random Forest - Top 15 Variáveis Mais Importantes")
    plt.gca().invert_yaxis()
    plt.grid(True)
    plt.savefig("projeto/estatisticas/random_forest/rf_feature_importance.png", dpi=300)
    plt.close()

    if salvar_modelo:
        joblib.dump(modelo, 'projeto/modelos/random_forest.joblib')
        caminho_relatorio = "projeto/estatisticas/random_forest/rf_summary.txt"
        with open(caminho_relatorio, "w", encoding="utf-8") as f:
            f.write("=== Random Forest ===\n\n")
            f.write(f"MAE : {mae:.3f}\n")
            f.write(f"RMSE: {rmse:.3f}\n")
            f.write(f"R²  : {r2:.3f}\n\n")
            f.write("=== Hiperparâmetros do Modelo ===\n")
            f.write(str(modelo.get_params()) + "\n\n")
            f.write(f"--> GridSearch Executado: {usar_gridsearch}\n")
            f.write("=== Importância das Variáveis ===\n")
            f.write(importancias.to_string(index=False))
            f.write("\n")

    return modelo, y_pred

#======#
# Main #
#======#
if __name__ == "__main__":
    caminho_arquivo = 'microdados_enem_2023\DADOS\MICRODADOS_ENEM_2023.csv'
    variaveis_socio = [
        'TP_ESCOLA',
        'Q001', 'Q002', 'Q003', 'Q004', 'Q005',
        'Q006', 'Q007', 'Q008', 'Q009', 'Q010',
        'Q011', 'Q012', 'Q013', 'Q014', 'Q015',
        'Q016', 'Q017', 'Q018', 'Q019', 'Q020',
        'Q021', 'Q022', 'Q023', 'Q024', 'Q025'
    ]
    variavel_alvo = 'NU_NOTA_MT'

    # ================ configurações da execução do código ================
    # tratamento dos dados
    refazer_tratamento_dados = False
    
    # regressão linear
    treinar_regressao_linear = True
    rl_usar_cross_valid_kfold = True
    rl_num_folds = 10

    # regressão linear (com statsmodels)
    treinar_regressao_statsmodels = False
    rlsm_usar_cross_valid_kfold = True
    rlsm_num_folds = 10
    
    # random forest
    treinar_random_forest = False
    rf_tamanho_amostra= 100000
    rf_usar_grid_search = False
    rf_usar_cross_valid_kfold = True
    rf_num_folds = 10
    # =====================================================================

    # verificação dos arquivos de dados já existentes
    arquivos_existentes = all([
        os.path.exists('projeto/dados/enem2023_filtrado.csv'),
        os.path.exists('projeto/dados/enem2023_socio_processado.csv'),
        os.path.exists('projeto/dados/enem2023_nota_mt.csv')
    ])

    # tratamento dos dados
    if not arquivos_existentes or refazer_tratamento_dados:
        print("\nExecutando tratamento dos dados...")
        dados = ler_e_filtrar_dados(caminho_arquivo, variaveis_socio, variavel_alvo)
        df_mapped = mapear_variaveis_categoricas(dados)
        X_proc, y = preparar_dados_para_modelagem(df_mapped, variaveis_socio, variavel_alvo)
        print("\nTratamento dos dados concluído")
    else:
        print("\nObtendo dados...")
        X_proc = pd.read_csv('projeto/dados/enem2023_socio_processado.csv', sep=';')
        y = pd.read_csv('projeto/dados/enem2023_nota_mt.csv', sep=';')['NU_NOTA_MT']

    # treinamento dos modelos
    X_train, X_test, y_train, y_test = train_test_split( X_proc, y, test_size=0.2, random_state=42 )
    
    if treinar_regressao_linear:
        modelo_rl, y_pred_rl = regressao_linear(X_train, X_test, y_train, y_test, rl_num_folds, rl_usar_cross_valid_kfold)
    
    if treinar_random_forest:
        modelo_rf, y_pred_rf = random_forest(X_train, X_test, y_train, y_test, rf_tamanho_amostra, rf_usar_grid_search, rf_usar_cross_valid_kfold, rf_num_folds)

    if treinar_regressao_statsmodels:
        modelo_rl_sm, y_pred_rl_sm = regressao_statsmodels(X_train, X_test, y_train, y_test, rlsm_num_folds, rlsm_usar_cross_valid_kfold)
