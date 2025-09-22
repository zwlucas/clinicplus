# ClinicPlus - Documentação Completa

## Visão Geral

ClinicPlus é um sistema completo de gerenciamento clínico desenvolvido em Delphi FireMonkey (FMX), projetado para facilitar a administração de clínicas médicas com interface moderna e intuitiva.

## Arquitetura do Sistema

### Tecnologias Utilizadas
- **Frontend**: Delphi FireMonkey (FMX)
- **Backend**: Servidor de API (detalhes na pasta backend/)
- **Banco de Dados**: MySQL
- **Conexão**: FireDAC
- **Binding**: Live Bindings

## Banco de Dados

### 1. Importe o banco de dados

Para o projeto funcionar corretamente, você deve primeiro importar os dados no seu banco de dados

- Acesse a pasta stuff
- Rode o script `clinicplus_comfoto.sql` no seu banco de dados para criar as tabelas e inserir os dados

**Exemplo de comando no MySQL:**

```sql
\. c:/clinicplus/stuff/clinicplus_comfoto.sql
```

## Backend

### 2. Iniciar o back-end

- Vá até a pasta backend
- Abra o arquivo de configuração e configure de acordo com suas configurações
- Inicie o back-end

## Frontend (Aplicação Principal)

### Estrutura da Interface

O formulário principal (`TClinicPlusForm`) possui os seguintes componentes:

#### Área Superior
- **TopRCT**: Container principal do topo
- **MenuBTN**: Botão para abrir/fechar menu lateral
- **Label1**: Título da aplicação
- **AtualizarBTN**: Botão para atualizar dados

#### Navegação
- **ButtonsRCT**: Container dos botões de navegação
- **MultiView1**: Menu lateral deslizante

#### Seções Principais
- **ScheduleLYT**: Layout para agendamentos
- **SchedulePTH**: Ícone de agendamentos
- **HomeLYT**: Layout da página inicial
- **HistoryLYT**: Layout do histórico
- **HistoryPTH**: Ícone do histórico
- **AnimeLYT**: Layout de animações
- **AnimeRCT**: Container de animações

### Funcionalidades

#### Sistema de Navegação
- Menu lateral com MultiView para navegação entre seções
- Botões visuais com ícones para diferentes funcionalidades
- Interface responsiva e moderna

#### Gerenciamento de Dados
- Integração com FireDAC para conexão com banco de dados
- Live Bindings para vinculação automática de dados
- Suporte a JSON para comunicação com API

### 3. Compilar o front-end

- Abra o projeto no RAD Studio
- Configure as conexões de banco de dados se necessário
- Execute o projeto

## Configuração e Instalação

### Pré-requisitos
- RAD Studio (Delphi) com suporte FireMonkey
- MySQL Server instalado
- Componentes FireDAC configurados

### Passos de Instalação

1. **Clone o repositório**
   ```bash
   git clone https://github.com/zwlucas/clinicplus
   cd clinicplus
   ```

2. **Configure o banco de dados**
   - Execute o script SQL na pasta stuff
   - Configure as strings de conexão no projeto

3. **Configure o backend**
   - Navegue até a pasta backend
   - Configure os parâmetros de conexão
   - Inicie o servidor

4. **Compile a aplicação**
   - Abra o projeto no RAD Studio
   - Configure as dependências
   - Compile e execute

## Estrutura de Dados

### Componentes FireDAC
- **FireDAC.Stan.Intf**: Interface padrão
- **FireDAC.Comp.Client**: Cliente de conexão
- **FireDAC.Comp.DataSet**: Datasets para manipulação de dados

### Binding de Dados
- **Data.Bind.Components**: Componentes de binding
- **Data.Bind.DBScope**: Escopo de dados do banco
- **Fmx.Bind.DBEngExt**: Extensões para binding FMX

## Manutenção e Desenvolvimento

### Estrutura do Código
- Interface limpa e separação de responsabilidades
- Uso de layouts para organização visual
- Componentes reutilizáveis

### Extensibilidade
- Arquitetura modular permite fácil adição de novas funcionalidades
- Sistema de binding facilita integração com novos dados
- Interface FMX permite deployment multiplataforma

## Troubleshooting

### Problemas Comuns
1. **Erro de conexão com banco**: Verifique as configurações FireDAC
2. **Backend não responde**: Confirme se o servidor está rodando
3. **Componentes não aparecem**: Verifique se todos os uses estão corretos

### Logs e Depuração
- Use o Output Pane do VS Code para verificar erros
- Teste as conexões de banco separadamente
- Verifique os endpoints da API

## Suporte

Para suporte técnico ou dúvidas sobre implementação, consulte:
- Documentação do RAD Studio
- Guias do FireDAC
- Documentação do FireMonkey