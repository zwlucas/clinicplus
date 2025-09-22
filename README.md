# ClinicPlus

Projeto de gerenciamento clínico desenvolvido em Delphi, com back-end e banco de dados

## Como rodar o projeto

### 1. Importe o banco de dados

Para o projeto funcionar corretamente, voc^deve primeiro importar os dados no seu banco de dados

- Acesse a pasta `stuff/`
- Rode o script `clinicplus_comfoto.sql` no seu banco de dados para criar as tabelas e inserir os dados

**Exemplo de comando no MySQL:**

```sql
\. c:/clinicplus/stuff/clinicplus_comfoto.sql
```

### 2. Iniciar o back-end

- Vá até a pasta `backend/`
- Abra o arquivo de configuração e configure de acordo com suas configurações
- Inicie o back-end

### 3. Compilar o front-end

- Abra o projeto no Rad Studio
- Execute o projeto