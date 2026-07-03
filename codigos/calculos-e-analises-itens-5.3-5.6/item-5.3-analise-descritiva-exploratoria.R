# ==============================================================================
# PROJETO AVALIATIVO - EST 100 (ESTATÍSTICA DESCRITIVA E EXPLORATÓRIA)
# ITEM 5.3: ANÁLISE DESCRITIVA E EXPLORATÓRIA
# ==============================================================================

# 1. CARREGAR PACOTES NECESSÁRIOS
library(tidyverse)
library(e1071)  # Para cálculo da Assimetria (skewness)
library(knitr)  # Para formatação de tabelas limpas

# ==============================================================================
# [ITEM 5.3.1] CLASSIFICAÇÃO DAS VARIÁVEIS DO PROJETO
# ==============================================================================
# Base A:
#   - Mes: Qualitativa Ordinal (M1 a M12)
#   - Trimestre: Qualitativa Ordinal
#   - Preco_Brasil / Preco_MG: Quantitativa Contínua (Valores monetários)
# Base B:
#   - Ano: Quantitativa Discreta (tratada como fator temporal nas análises)
#   - Regiao: Qualitativa Nominal (Brasil e Sul)
#   - Produto: Qualitativa Nominal (6 categorias de origem animal)
#   - Valor_Producao_Mil_RS: Quantitativa Contínua (Valores monetários)

# ==============================================================================
# 2. CONSTRUÇÃO DAS BASES DE DADOS REAIS (DADOS INTEGRADOS)
# ==============================================================================

# --- BASE A: Preço do Leite (Reais por litro) - 12 Meses (2Q2025 a 1Q2026)
base_A <- tibble(
  Mes = factor(paste0("M", 1:12), levels = paste0("M", 1:12)),
  Trimestre = c(rep("2Q2025", 3), rep("3Q2025", 3), rep("4Q2025", 3), rep("1Q2026", 3)),
  Preco_Brasil = c(2.84, 2.75, 2.73, 2.67, 2.60, 2.52, 2.38, 2.20, 2.09, 2.11, 2.21, 2.47),
  Preco_MG     = c(2.92, 2.80, 2.77, 2.68, 2.62, 2.54, 2.42, 2.24, 2.09, 2.13, 2.23, 2.49)
)

# --- BASE B: Pesquisa da Pecuária Municipal - VALOR DA PRODUÇÃO (Mil Reais)
# Inclui os 6 materiais de origem animal para o Brasil e Região Sul (2021-2024)
base_B <- tibble(
  Ano = rep(c(2021, 2022, 2023, 2024), each = 12),
  Regiao = rep(rep(c("Brasil", "Sul"), each = 6), times = 4),
  Produto = rep(c("Leite", "Ovos de galinha", "Ovos de codorna", "Mel de abelha", "Casulos do bicho-da-seda", "Lã"), times = 8),
  Valor_Producao_Mil_RS = c(
    # --- ANO 2021 ---
    67987725, 21875425, 437016, 851354, 46156, 76874,     # Brasil
    23440751, 4321112, 60369, 322600, 39716, 76601,       # Sul
    # --- ANO 2022 ---
    79919856, 25947202, 449116, 982362, 47715, 83306,     # Brasil
    27905637, 5265925, 77801, 352200, 40623, 83044,       # Sul
    # --- ANO 2023 ---
    79999170, 30364242, 531097, 906893, 51236, 50757,     # Brasil
    27861964, 6212725, 101906, 334106, 43902, 50519,      # Sul
    # --- ANO 2024 ---
    87511969, 31862060, 600730, 1010040, 50021, 46289,    # Brasil
    30399229, 6773481, 102907, 358444, 44910, 46062       # Sul
  )
)

# ==============================================================================
# 3. DESENVOLVIMENTO DOS CÁLCULOS E TABELAS EXIGIDAS
# ==============================================================================

# Função automatizada para extrair as medidas de Posição, Dispersão, Sepatrizes e Assimetria
calcular_estatisticas <- function(valores) {
  tibble(
    Media         = mean(valores),
    Mediana       = median(valores),
    Minimo        = min(valores),
    Maximo        = max(valores),
    Variancia     = var(valores),
    Desvio_Padrao = sd(valores),
    CV_Percentual = (sd(valores) / mean(valores)) * 100,
    Q1            = quantile(valores, 0.25),
    Q3            = quantile(valores, 0.75),
    Assimetria    = skewness(valores)
  )
}

# --- [ITEMS 5.3.3 a 5.3.6] TABELA DE MEDIDAS DESCRITIVAS DA BASE A
resumo_base_A <- bind_rows(
  mutate(calcular_estatisticas(base_A$Preco_Brasil), Localidade = "Brasil"),
  mutate(calcular_estatisticas(base_A$Preco_MG), Localidade = "Minas Gerais")
) %>% select(Localidade, everything())

print("--- TABELA DE MEDIDAS DESCRITIVAS: BASE A (PREÇO DO LEITE) ---")
print(kable(resumo_base_A, digits = 3))


# --- [ITEMS 5.3.3 a 5.3.6] TABELA DE MEDIDAS DESCRITIVAS DA BASE B (TODOS OS PRODUTOS)
resumo_base_B <- base_B %>%
  group_by(Produto, Regiao) %>%
  summarise(
    Media         = mean(Valor_Producao_Mil_RS),
    Mediana       = median(Valor_Producao_Mil_RS),
    Minimo        = min(Valor_Producao_Mil_RS),
    Maximo        = max(Valor_Producao_Mil_RS),
    Variancia     = var(Valor_Producao_Mil_RS),
    Desvio_Padrao = sd(Valor_Producao_Mil_RS),
    CV_Percentual = (sd(Valor_Producao_Mil_RS) / mean(Valor_Producao_Mil_RS)) * 100,
    Q1            = quantile(Valor_Producao_Mil_RS, 0.25),
    Q3            = quantile(Valor_Producao_Mil_RS, 0.75),
    Assimetria    = skewness(Valor_Producao_Mil_RS),
    .groups       = 'drop'
  )

print("--- TABELA DE MEDIDAS DESCRITIVAS: BASE B (VALOR HISTÓRICO DA PRODUÇÃO) ---")
print(kable(resumo_base_B, digits = 2))


# --- [ITEM 5.3.2] TABELA DE FREQUÊNCIAS POR CLASSE (BASE A - BRASIL)
classes_preco <- cut(base_A$Preco_Brasil, 
                     breaks = c(2.00, 2.30, 2.60, 2.90), 
                     right = FALSE,
                     labels = c("[2.00, 2.30)", "[2.30, 2.60)", "[2.60, 2.90]"))

tabela_frequencia <- tibble(Classe = classes_preco) %>% 
  count(Classe, name = "Freq_Absoluta") %>% 
  mutate(Freq_Relativa_Percentual = (Freq_Absoluta / sum(Freq_Absoluta)) * 100)

print("--- TABELA DE FREQUÊNCIAS POR CLASSES: BASE A ---")
print(kable(tabela_frequencia, digits = 2))


# --- [ITEM 5.3.7] ANÁLISE BIVARIADA (COEFICIENTE DE CORRELAÇÃO DE PEARSON)
correlacao <- cor(base_A$Preco_Brasil, base_A$Preco_MG)
cat("\nCoeficiente de Correlação de Pearson (Brasil vs MG):", round(correlacao, 4), "\n\n")

