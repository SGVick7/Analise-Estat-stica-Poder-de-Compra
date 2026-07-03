# Analise-Estat-stica-Poder-de-Compra
Analise feita sobre a variação do preço de itens de origem animal

# Projeto Avaliativo - EST 100: Estatística Descritiva e Exploratória
**Tema:** Análise do Mercado de Leite e Produtos de Origem Animal no Brasil
**Disciplina:** EST 100 - Estatística Descritiva e Exploratória
**Instituição:** Universidade Federal de Viçosa (UFV) - Departamento de Estatística
**Professor:** Fernando de Souza Bastos

---

## 1. Descrição do Projeto
Este projeto tem como objetivo aplicar os conceitos de Estatística Descritiva e Exploratória utilizando dados reais do agronegócio brasileiro. A análise investiga a distribuição e a evolução temporal dos preços do leite cru no Brasil e em Minas Gerais (Base A), além de explorar o valor histórico da produção de diversos materiais de origem animal (Base B), contrastando o cenário nacional com a Região Sul. Os dados foram extraídos do Sistema IBGE de Recuperação Automática (SIDRA).

---

## 2. Estrutura de Diretórios
Para garantir a total reprodutibilidade exigida nos critérios de avaliação, o projeto encontra-se organizado da seguinte forma:

```text
projeto_grupo/
|-- README/                    # Instruções de reprodução e documentação (Este arquivo)
|   '-- README.md
|-- dados/
|   |-- brutos/                # Arquivos originais (.html / .csv) extraídos do IBGE
|   |   |--base-de-dados-A
|   |   '--base-de-dados-B
|   '-- tratados/              # Bases de dados limpas e estruturadas (geradas no script)
|       |--Dados-Tratados-Base-A
|       '--Dados-Tratados-Base-B
|-- codigos/
|   |--dados-brutos-em-R/
|   |  '--analise-R-dados-brutos
|   |--calculos-e-analises-itens-5.3-5.6/
|   |  |--item-5.3-analise-descritiva-exploratoria
|   |  '--item-5.6-indices-ponderados
|   |--graficos-itens-5.3-5.4/
|   |  |--grafico-item-5.4
|   |  '--graficos-item-5.3
|   |--.Rhistory
|   '--.RData
|-- relatorio/
|   |-- codigo-fonte/
|   |   |--relatorio.tex # Arquivo-fonte do relatório (LaTeX, Rmd ou qmd)
|   |   '--gráficos.png/
|   '-- relatorio.pdf          # Relatório final em PDF
'-- apresentacao/
    '-- slide-est100.pdf       # Slides utilizados na apresentação oral
```  
    
## 3. Pré-requisitos e Dependências
Para executar os códigos e reproduzir as tabelas, os cálculos descritivos e os 5 gráficos da secção 5.3.8, é necessário ter o R e o RStudio instalados, além dos seguintes pacotes:

tidyverse (Manipulação de dados e geração de gráficos avançados via ggplot2)

e1071 (Cálculo da medida de Assimetria / Skewness)

knitr (Formatação de tabelas limpas para o console/relatório)

## 4. Como Reproduzir a Análise
Siga o passo a passo abaixo para gerar todos os resultados do zero:

Faça o download/clone da pasta trabalho-EST-100 para o seu computador.

Abra o RStudio.

Defina a pasta trabalho-EST-100/ como o seu diretório de trabalho (Working Directory).

Navegue até a pasta codigos/ e abra as pastas que tem as análises exploratórias para analisar os resultados obtidos e, depois, abra a pasta dos gráficos para visualizar os gráficos produzidos pela equipe. 

Selecione todo o código (Ctrl + A) e execute (Ctrl + Enter).

Nota: O script está programado para instanciar as Bases A e B diretamente na memória para evitar erros de caminhos de ficheiros.

Resultados gerados:

As Tabelas Descritivas Completas (posição, dispersão, separatrizes, assimetria e correlação de Pearson) aparecerão no Console.

Os 5 Gráficos Distintos serão gerados na aba Plots na seguinte ordem:

Gráfico de Distribuição e Composição: Quem domina o setor?

Gráfico Comparativo entre regiões: Onde está a força produtiva?

Gráfico Temporal: Como esse mercado evoluiu ao longo dos anos?

Gráfico Bivariado: O preço alto compensa a falta de volume?

Gráfico de Taxas/Índices: Qual região expandiu seu principal motor mais rápido?

##5. Resolução de Problemas (Troubleshooting)
Erro comum no Windows: 'lib = "C:/Program Files/R/.../library"' is not writable
Caso enfrente este erro de permissão ao tentar instalar os pacotes, execute o bloco de código abaixo no console do R para forçar a instalação numa pasta local do utilizador:

R
projeto_est100_grupo<- "~/R_Pacotes"
dir.create(projeto_est100_grupo, showWarnings = FALSE)
.libPaths(c(projeto_est100_grupo, .libPaths()))
install.packages(c("tidyverse", "e1071", "knitr"), lib = projeto_est100_grupo)
Após a instalação, execute o ficheiro analise.R normalmente.

##6. Fonte de Dados e Ética
Os dados utilizados nesta análise são públicos, macroeconómicos e anonimizados, não contendo dados sensíveis de caráter pessoal:

Base A: Pesquisa Trimestral do Leite (IBGE/SIDRA - Tabela 1086).

Base B: Pesquisa da Pecuária Municipal (IBGE/SIDRA - Tabela 74).

##7. Declaração de Uso de Ferramentas de IA
Conforme permitido pelo roteiro da disciplina (Item 9), ferramentas de Inteligência Artificial foram utilizadas como apoio para:

Refinar a sintaxe na construção das camadas visuais dos gráficos no pacote ggplot2.

Revisar a ortografia e a formatação deste ficheiro README.

Verificação das fórmulas. 

A interpretação estatística dos resultados, a seleção das medidas e as conclusões redigidas no relatório final são de autoria intelectual e responsabilidade integral da equipe.
