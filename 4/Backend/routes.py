from flask import Flask, jsonify, render_template
from flask_cors import CORS
import api_functions as f

app = Flask(__name__)

app.config.from_object(__name__)

CORS(app)

# Rota inicial: Retorna a documentacao da API
@app.route('/', methods=['GET'])
def returnDocumentation():
    return render_template('documentation_page.html')

# Rota items: Retorna todos os itens da tabela como objetos em json
@app.route('/items', methods=['GET'])
def getData():
    return f.getDataForTable()

# Rota pesquisa: Retorna apenas os dados mais relevantes para a pesquisa feita
@app.route('/items/search:<search>', methods=['GET'])
def getDataForSearch(search):
    return f.searchTable(search)

# Inicializacao do app
if __name__ == "__main__":
    app.run(debug=True, port=5001)