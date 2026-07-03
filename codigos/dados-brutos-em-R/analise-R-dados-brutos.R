# ==============================================================================
# DISCIPPLINA: EST 100 - ESTATÍSTICA DESCRITIVA E EXPLORATÓRIA
# PROJETO: ESTRUTURAÇÃO DAS BASES DE DADOS (PPM E PESQUISA TRIMESTRAL DO LEITE)
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. CONSTRUÇÃO DA BASE DE DADOS B (Pesquisa da Pecuária Municipal - 2021 a 2024)
# ------------------------------------------------------------------------------

base_dados_B <- data.frame(
  Localidade = rep(c("Brasil", "Sul"), each = 24),
  Ano = rep(rep(2021:2024, each = 6), 2),
  Produto = rep(c("Leite", "Ovos de galinha", "Ovos de codorna", 
                  "Mel de abelha", "Casulos do bicho-da-seda", "Lã"), 8),
  Unidade_Q = rep(c("Mil litros", "Mil dúzias", "Mil dúzias", 
                    "Quilogramas", "Quilogramas", "Quilogramas"), 8),
  
  # Quantidades extraídas da primeira tabela do arquivo html
  Quantidade = c(
    # --- BRASIL ---
    35183066, 4821802, 272213, 55678534, 2211145, 8298591, # 2021
    34554161, 4852117, 237524, 62494156, 1806675, 8884395, # 2022
    35248212, 4981477, 242939, 64164183, 1714665, 8547970, # 2023
    35743862, 5409429, 258752, 67313986, 1581481, 7471952, # 2024
    # --- SUL ---
    11977983, 1103482, 40490, 22204521, 1905116, 8254937, # 2021
    11665978, 1121029, 46930, 22693682, 1532744, 8846737, # 2022
    11862280, 1152220, 48895, 21837017, 1458782, 8513656, # 2023
    11949706, 1216590, 49563, 22180757, 1414087, 7441943  # 2024
  ),
  
  # Valores da produção extraídos da segunda tabela (em Mil Reais)
  Valor_Mil_Reais = c(
    # --- BRASIL ---
    67987725, 21875425, 437016, 851354, 46156, 76874, # 2021
    79919856, 25947202, 449116, 982362, 47715, 83306, # 2022
    79999170, 30364242, 531097, 906893, 51236, 50757, # 2023
    87511969, 31862060, 600730, 1010040, 50021, 46289, # 2024
    # --- SUL ---
    23440751, 4321112, 60369, 322600, 39716, 76601, # 2021
    27905637, 5265925, 77801, 352200, 40623, 83044, # 2022
    27861964, 6212725, 101906, 334106, 43902, 50519, # 2023
    30399229, 6773481, 102907, 358444, 44910, 46062  # 2024
  )
)

# CÁLCULO DO PREÇO UNITÁRIO (Pit = Vit / Qit) COM AJUSTE DE ESCALA
# Como o Valor está em Mil Reais:
# - Para Mil litros/Mil dúzias: os "Mil" se cancelam (divisão direta).
# - Para Quilogramas: multiplicamos por 1000 para converter o valor para Reais absolutos.
base_dados_B$Preco_Unitario <- with(base_dados_B, ifelse(
  Unidade_Q == "Quilogramas",
  (Valor_Mil_Reais / Quantidade) * 1000,
  Valor_Mil_Reais / Quantidade
))

# Arredondando para duas casas decimais para manter o padrão monetário
base_dados_B$Preco_Unitario <- round(base_dados_B$Preco_Unitario, 2)


# ------------------------------------------------------------------------------
# 2. CONSTRUÇÃO DA BASE DE DADOS EST100 (Pesquisa Trimestral do Leite - 2025/2026)
# ------------------------------------------------------------------------------

# Vetor com os meses cronológicos de referência temporal da pesquisa
meses_cronologicos <- c(
  "2025_Q2_M1", "2025_Q2_M2", "2025_Q2_M3",
  "2025_Q3_M1", "2025_Q3_M2", "2025_Q3_M3",
  "2025_Q4_M1", "2025_Q4_M2", "2025_Q4_M3",
  "2026_Q1_M1", "2026_Q1_M2", "2026_Q1_M3"
)

base_dados_leite_trimestral <- data.frame(
  Localidade = rep(c("Brasil", "Minas Gerais"), each = 36),
  Inspecao = "Federal",
  Variavel = rep(rep(c("Num_Informantes", "Num_Informantes_Preco", "Preco_Medio_RS_Litro"), each = 12), 2),
  Periodo = rep(meses_cronologicos, 6),
  
  Valor = c(
    # --- BRASIL ---
    # Número de informantes (Tabela 1)
    655, 655, 655, 652, 652, 652, 647, 647, 647, 636, 636, 636,
    # Número de informantes do preço (Tabela 2)
    626, 626, 625, 626, 625, 624, 621, 621, 618, 607, 606, 606,
    # Preço médio por litro (Tabela 3)
    2.84, 2.75, 2.73, 2.67, 2.60, 2.52, 2.38, 2.20, 2.09, 2.11, 2.21, 2.47,
    
    # --- MINAS GERAIS ---
    # Número de informantes (Tabela 1)
    292, 292, 292, 289, 289, 289, 287, 287, 287, 281, 281, 281,
    # Número de informantes do preço (Tabela 2)
    284, 284, 284, 284, 284, 284, 282, 282, 280, 274, 273, 273,
    # Preço médio por litro (Tabela 3)
    2.92, 2.80, 2.77, 2.68, 2.62, 2.54, 2.42, 2.24, 2.09, 2.13, 2.23, 2.49
  )
)


# ------------------------------------------------------------------------------
# 3. VISUALIZAÇÃO E VERIFICAÇÃO DAS TABELAS NO CONSOLE
# ------------------------------------------------------------------------------

# Visualizando as primeiras linhas da Base B com os Preços Unitários calculados
print("--- Primeiras linhas da Base de Dados B (PPM) ---")
print(head(base_dados_B, 12))

# Visualizando uma amostra da Base do Leite Trimestral
print("--- Amostra da Base de Dados da Pesquisa Trimestral do Leite ---")
print(base_dados_leite_trimestral[c(1, 13, 25, 37, 49, 61), ])