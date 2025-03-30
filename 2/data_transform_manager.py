import os
import shutil
import pdfplumber
import csv
import pandas as pd
from zipfile import ZipFile

def find_and_copy_zip_file(filename, file='Anexo I.pdf'):
    # Setando o diretório atual para o local do script
    # Isso garante que o script funcione corretamente em qualquer IDE
    script_dir = os.path.dirname(os.path.abspath(__file__))
    os.chdir(script_dir)

    # Verifica se o arquivo já existe descompactado no diretório
    if not os.path.exists(filename.removesuffix('.zip')):
        # Se não existir, tenta voltar um diretório
        os.chdir('..')
        # Se não existir, volta mais um diretório
        if not os.path.exists(filename):
            os.chdir('1')
            if not os.path.exists(filename):
                raise FileNotFoundError(f'{filename} não foi encontrado. Por favor rode o primeiro script.')
            
        # Copia o arquivo para o diretório desse script
        shutil.copyfile(filename, f'../2/{filename}') if os.getcwd().endswith('1') else shutil.copyfile(filename, f'2/{filename}')

        # Descompacta o arquivo
        os.chdir(script_dir)
        with ZipFile(filename, 'r') as zip:
            zip.extract(file, filename.removesuffix('.zip'))
            os.remove(filename)
    os.chdir(filename.removesuffix('.zip'))

# Função para extrair todas as tabelas do arquivo pdf
def extract_tables(filename='Anexo I.pdf'):
    with pdfplumber.open(filename) as f:
        data = []
        print('Lendo dados e extraindo tabelas...')
        for page in f.pages:
            data.append(page.extract_tables())
        
    return data

# Função para transformar os dados em um array bidimensional
# *Quando rodamos a função extract_tables() os dados vêm por padrão como [pagina1[tabela1[linha1, linha2, ...], ...], ...]
def translate_data(data):
    data_translated = []
    print('Traduzindo tabelas em linhas')
    for page in data:
        for table in page:
            if table[0][0] == 'PROCEDIMENTO' and table[0][1] == 'RN\n(alteração)':
                data_translated.extend(table[1:])
    return data_translated

# função para salvar os dados em csv
def save_csv(header, data, dir = '../data.csv'):
    with open(dir, 'w', encoding='utf-8') as csv_file:
        writer = csv.writer(csv_file)
        writer.writerow(header)
        writer.writerows(data)

# Função que utiliza a biblioteca pandas para fazer a alteração das abreviações e salvar novamente o arquivo
def replace_abreviations(abbr={'OD' : 'Seg. Odontológica', 'AMB' : 'Seg. Ambulatorial'}):
    print("Substituindo abreviações...")
    df = pd.read_csv('data.csv')
    df = df.rename(columns=abbr)
    df = df.replace(abbr)
    df.to_csv('data.csv', index=False)

# Função para salvar a tabela em arquivo .zip, como definido nas instruções
def save_zip(zip_name='Teste_Enrique.zip', filename='data.csv'):
    print(f'salvando {filename} em {zip_name}')
    with ZipFile(zip_name, 'a') as zip:
        zip.write(filename)
        os.remove(filename)
        try:
            shutil.rmtree('Anexos')
        except OSError as e:
            print(f'Erro: {e.filename} - {e.strerror}.')
    print('Operação concluída com sucesso!')