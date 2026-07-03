# Carregar pacotes necessários
library(ggplot2)
library(dplyr)

# 1. Montar a base de dados tratada (conforme item 5.2 do roteiro)
dados_taxas <- data.frame(
  Mes_Referencia = factor(c("25 Q2 M2", "25 Q2 M3", "25 Q3 M1", "25 Q3 M2", "25 Q3 M3", 
                            "25 Q4 M1", "25 Q4 M2", "25 Q4 M3", "26 Q1 M1", "26 Q1 M2", "26 Q1 M3"),
                          levels = c("25 Q2 M2", "25 Q2 M3", "25 Q3 M1", "25 Q3 M2", "25 Q3 M3", 
                                     "25 Q4 M1", "25 Q4 M2", "25 Q4 M3", "26 Q1 M1", "26 Q1 M2", "26 Q1 M3")),
  Taxa_Crescimento = c(-4.11, -1.07, -3.25, -2.24, -3.05, -4.72, -7.44, -6.70, 1.91, 4.69, 11.66)
)

# 2. Construir o gráfico customizado de alta qualidade
ggplot(dados_taxas, aes(x = Mes_Referencia, y = Taxa_Crescimento, group = 1)) +
  geom_line(color = "#2c3e50", size = 1) +
  geom_point(aes(color = Taxa_Crescimento > 0), size = 3, show.legend = FALSE) +
  scale_color_manual(values = c("TRUE" = "#27ae60", "FALSE" = "#c0392b")) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey50") +
  labs(
    title = "Taxa de Crescimento Mensal do Preço do Leite ao Produtor",
    subtitle = "Minas Gerais - Período: 2025 (M2/Q2) a 2026 (M3/Q1)",
    x = "Trimestre x Mês de Referência",
    y = "Taxa de Crescimento Mensal (%)",
    caption = "Fonte: Elaboração própria com dados da Pesquisa Trimestral do Leite (IBGE)."
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5, color = "grey30"),
    axis.text.x = element_text(angle = 45, vjust = 0.5)
  )