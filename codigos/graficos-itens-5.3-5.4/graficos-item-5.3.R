# ==============================================================================
# PROJETO AVALIATIVO - EST 100
# CRIAÇÃO DE GRÁFICOS NARRATIVOS 
# ==============================================================================

# 1. CARREGAMENTO DOS PACOTES
if(!require(tidyverse)) install.packages("tidyverse")
library(tidyverse)

# 2. BASE DE DADOS INTEGRAL EXCLUSIVA 
base_ppm <- data.frame(
  Localidade = rep(c("Brasil", "Sul"), each = 24),
  Ano        = rep(rep(2021:2024, each = 6), times = 2),
  Produto    = rep(c("Leite", "Ovos de galinha", "Ovos de codorna", 
                     "Mel de abelha", "Casulos do bicho-da-seda", "Lã"), times = 8),
  Unidade_Q  = rep(c("Mil litros", "Mil dúzias", "Mil dúzias", 
                     "Quilogramas", "Quilogramas", "Quilogramas"), times = 8),
  Quantidade = c(
    35183066, 4821802, 272213, 55678534, 2211145, 8298591, # Brasil 2021
    34554161, 4852117, 237524, 62494156, 1806675, 8884395, # Brasil 2022
    35248212, 4981477, 242939, 64164183, 1714665, 8547970, # Brasil 2023
    35743862, 5409429, 258752, 67313986, 1581481, 7471952, # Brasil 2024
    11977983, 1103482, 40490, 22204521, 1905116, 8254937, # Sul 2021
    11665978, 1121029, 46930, 22693682, 1532744, 8846737, # Sul 2022
    11862280, 1152220, 48895, 21837017, 1458782, 8513656, # Sul 2023
    11949706, 1216590, 49563, 22180757, 1414087, 7441943  # Sul 2024
  ),
  Valor_Producao_Mil_RS = c(
    67987725, 21875425, 437016, 851354, 46156, 76874, # Brasil 2021
    79919856, 25947202, 449116, 982362, 47715, 83306, # Brasil 2022
    79999170, 30364242, 531097, 906893, 51236, 50757, # Brasil 2023
    87511969, 31862060, 600730, 1010040, 50021, 46289, # Brasil 2024
    23440751, 4321112, 60369, 322600, 39716, 76601, # Sul 2021
    27905637, 5265925, 77801, 352200, 40623, 83044, # Sul 2022
    27861964, 6212725, 101906, 334106, 43902, 50519, # Sul 2023
    30399229, 6773481, 102907, 358444, 44910, 46062  # Sul 2024
  ),
  Preco_Medio_Unitario = c(
    1.93, 4.54, 1.61, 15.29, 20.87, 9.26,
    2.31, 5.35, 1.89, 15.72, 26.41, 9.38,
    2.27, 6.10, 2.19, 14.13, 29.88, 5.94,
    2.45, 5.89, 2.32, 15.00, 31.63, 6.20,
    1.96, 3.92, 1.49, 14.53, 20.85, 9.28,
    2.39, 4.70, 1.66, 15.52, 26.50, 9.39,
    2.35, 5.39, 2.08, 15.30, 30.09, 5.93,
    2.54, 5.57, 2.08, 16.16, 31.76, 6.19
  )
)

# Configuração de um tema padrão limpo e focado no texto
tema_narrativo <- theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 11, color = "#1a1a1a"),
    plot.subtitle = element_text(size = 9, color = "#4d4d4d", face = "italic"),
    axis.title = element_text(size = 9, face = "bold"),
    legend.position = "bottom"
  )

# ==============================================================================
# GRÁFICO 1: DISTRIBUIÇÃO E COMPOSIÇÃO (Responde: Quem domina o setor?)
# ==============================================================================
dados_g1 <- base_ppm %>% 
  filter(Ano == 2024, Localidade == "Brasil") %>% 
  mutate(Participacao = (Valor_Producao_Mil_RS / sum(Valor_Producao_Mil_RS)) * 100)

g1 <- ggplot(dados_g1, aes(x = reorder(Produto, Participacao), y = Participacao, fill = Produto)) +
  geom_bar(stat = "identity", alpha = 0.85, width = 0.6) +
  coord_flip() +
  scale_fill_brewer(palette = "Set2") +
  labs(
    title = "Gráfico 1: Qual produto domina o valor do setor animal?",
    subtitle = "Resposta: O Leite concentra sozinho mais de 72% de todo o faturamento nacional em 2024.",
    x = "Produto Animal", y = "Participação no Faturamento Total (%)"
  ) +
  tema_narrativo + guides(fill = "none")

print(g1)

# ==============================================================================
# GRÁFICO 2: COMPARATIVO ENTRE REGIÕES (Responde: Onde está a força produtiva?)
# ==============================================================================
g2 <- ggplot(base_ppm, aes(x = Localidade, y = Valor_Producao_Mil_RS/1000000, fill = Localidade)) +
  geom_boxplot(alpha = 0.7) +
  facet_wrap(~Produto, scales = "free_y") +
  scale_fill_manual(values = c("#0b559f", "#2ca25f")) +
  labs(
    title = "Gráfico 2: Como se comparam os mercados entre Brasil e Região Sul?",
    subtitle = "Resposta: O Leite e os Ovos operam em escala de milhões, com o Sul pesando fortemente no Leite.",
    x = "Região de Abrangência", y = "Faturamento da Produção (Milhões de R$)"
  ) +
  tema_narrativo

print(g2)

# ==============================================================================
# GRÁFICO 3: TEMPORAL (Responde: Como esse mercado evoluiu ao longo dos anos?)
# ==============================================================================
dados_g3 <- base_ppm %>% filter(Produto %in% c("Leite", "Ovos de galinha"))

g3 <- ggplot(dados_g3, aes(x = Ano, y = Valor_Producao_Mil_RS/1000000, color = Produto, group = Produto)) +
  geom_line(linewidth = 1.3) + geom_point(size = 3) +
  facet_wrap(~Localidade, scales = "free_y") +
  scale_color_manual(values = c("#d95f02", "#7570b3")) +
  labs(
    title = "Gráfico 3: Como evoluiu o faturamento dos líderes ano a ano?",
    subtitle = "Resposta: O Leite apresentou um salto de crescimento agressivo e contínuo de 2021 a 2024.",
    x = "Ano de Referência", y = "Valor de Produção (Milhões de R$)", color = "Líderes de Mercado"
  ) +
  scale_x_continuous(breaks = 2021:2024) +
  tema_narrativo

print(g3)

# ==============================================================================
# GRÁFICO 4: BIVARIADO (Responde: O preço alto compensa a falta de volume?)
# ==============================================================================
dados_g4 <- base_ppm %>% filter(Ano == 2024)

g4 <- ggplot(dados_g4, aes(x = Preco_Medio_Unitario, y = Valor_Producao_Mil_RS/1000000, label = Produto)) +
  geom_point(aes(color = Localidade), size = 4, alpha = 0.8) +
  geom_text(vjust = -0.8, size = 2.8, check_overlap = TRUE, fontface = "bold") +
  scale_color_manual(values = c("#e41a1c", "#377eb8")) +
  labs(
    title = "Gráfico 4: Relação Bivariada entre Preço Unitário e Retorno Financeiro Geral (2024)",
    subtitle = "Resposta: Não. Produtos caros (Casulo/Mel) faturam pouco; o Leite vence pelo volume massivo.",
    x = "Preço Médio Unitário do Produto (R$)", y = "Valor Total Gerado (Milhões de R$)"
  ) +
  tema_narrativo

print(g4)

# ==============================================================================
# GRÁFICO 5: TAXAS E ÍNDICES (Responde: Qual região expandiu seu principal motor mais rápido?)
# ==============================================================================
# Cálculo do número-índice de base fixa (2021 = 100) para o Valor do Leite
dados_g5 <- base_ppm %>%
  filter(Produto == "Leite") %>%
  group_by(Localidade) %>%
  arrange(Ano) %>%
  mutate(
    Valor_2021 = Valor_Producao_Mil_RS[Ano == 2021],
    Indice_Crescimento = (Valor_Producao_Mil_RS / Valor_2021) * 100
  )

g5 <- ggplot(dados_g5, aes(x = factor(Ano), y = Indice_Crescimento, fill = Localidade)) +
  geom_bar(stat = "identity", position = "dodge", alpha = 0.8, width = 0.6) +
  scale_fill_manual(values = c("#636363", "#fec44f")) +
  labs(
    title = "Gráfico 5: Taxa de Crescimento do Valor do Leite (Base Fixa 2021 = 100%)",
    subtitle = "Resposta: O Sul expandiu sua receita do Leite mais rápido (29.6%) do que a média do Brasil (28.7%).",
    x = "Ano de Avaliação", y = "Índice de Crescimento Econômico (%)"
  ) +
  coord_cartesian(ylim = c(90, 135)) +
  tema_narrativo

print(g5)

# ==============================================================================