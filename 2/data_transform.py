# Teste #2: Transformação de dados

# O código deve executar:
# 1. Extraia os dados da tabela Rol de Procedimentos e Eventos em Saúde do PDF do Anexo I do teste 1 (todas as páginas)
# 2. Salve os dados em uma tabela estruturada, em formato csv.
# 3. Compacte o csv em um arquivo denominado "Teste_{seu_nome}.zip".
# 4. Substitua as abreviações das colunas OD e AMB pelas descrições completas, conforme a legenda no rodapé.

# As funções principais estão contidas na data_transform_manager

import os
import data_transform_manager as dtm

dtm.find_and_copy_zip_file('Anexos.zip')

data = dtm.extract_tables()

data_translated = dtm.translate_data(data)

dtm.save_csv(data[2][0][0], data_translated)

os.chdir('..')

dtm.replace_abreviations()

dtm.save_zip()