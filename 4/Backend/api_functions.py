import re
import unicodedata
import pandas

# Recuperar todos os dados da tabela e retorna-los como json
def getDataForTable():
    df = pandas.read_csv('data/Relatorio_cadop.csv', sep=';')
    return df.to_json(orient='records', force_ascii=False)

# Normalizar texto da busca em um padrao
# Essa funcao foi criada para facilitar a busca textual dos dados na tabela
def normalize(text):
    # Removendo acentuacao
    text = ''.join(
        c for c in unicodedata.normalize('NFD', text)
        if not unicodedata.combining(c)
    )
    
    # Removendo espacos e caracteres especiais
    text = re.sub(r'[^a-zA-Z0-9]', '', text)
    
    #retornando busca filtrada em caracteres minusculos
    return text.lower()

# Fazer busca na tabela
def searchTable(search):
    df = pandas.read_csv('data/Relatorio_cadop.csv', sep=';')
    search_normalized = normalize(search)

    # Faz a busca na tabela e retorna true caso qualquer coluna da linha contenha o termo buscado.
    def matches(row):
        return row.astype(str).apply(normalize).str.contains(search_normalized, na=False).any()

    # aplica a funcao matches em todas as linhas
    result = df.apply(matches, axis=1)
    # Filtra o dataframe e retorna as linhas que contenham a busca em json
    return df[result].to_json(orient='records', force_ascii=False)