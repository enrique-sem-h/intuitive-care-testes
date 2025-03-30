# Teste #1: Web scraping

# O código deve executar:
# 1. Acesso ao site do gov especificado nas instruções
# 2. Download dos anexos I e II em formato pdf
# 3. Compactação dos arquivos em um arquivo zip

# Importando as bibliotecas necessárias 
# Aqui eu decidi usar requests e BeautifulSoup por conta da simplicidade
import os
import requests
from zipfile import ZipFile
from bs4 import BeautifulSoup as BS

# Criando o request e fazendo o parsing com bs4
r = requests.get('https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos')
soup = BS(r.content, 'html.parser')

# Aqui procuramos os links que terminam com pdf e contém a palavra 'Anexo'
# Então baixamos os arquivos e por fim compactamos em um arquivo zip

for a in soup.find_all('a'):
    # Verifica se o link termina com 'pdf' e contém 'Anexo' 
    if a.get('href').endswith('pdf') and 'Anexo' in a.text:
        # Remove os pontos do nome do arquivo para evitar problemas
        filename = a.text.replace('.', '') + '.pdf'

        with ZipFile('Anexos.zip', 'a') as zip:
            pdf_url = a.get('href')
            response = requests.get(pdf_url)

            # Evita baixar o arquivo se já existir no zip
            if filename not in zip.namelist():
                # Salva o arquivo pdf temporariamente
                with open(filename, 'wb') as file:
                    file.write(response.content)
                    # Adiciona ao zip
                    zip.write(filename)
                    # Remove o arquivo temporário
                    os.remove(filename)
                    print(f'Arquivo {filename} baixado.')
            else:
                print(f'Arquivo {filename} já existe.')
