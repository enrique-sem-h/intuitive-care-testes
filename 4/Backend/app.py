from flask import Flask, jsonify
from flask_cors import CORS
import re
import pandas
import unicodedata


app = Flask(__name__)

app.config.from_object(__name__)

CORS(app)

def normalize(text):
    if not isinstance(text, str):
        return ''
    
    # Remove accents
    text = ''.join(
        c for c in unicodedata.normalize('NFD', text)
        if not unicodedata.combining(c)
    )
    
    # Remove special characters and spaces
    text = re.sub(r'[^a-zA-Z0-9]', '', text)
    
    return text.lower()

def getDataForTable():
    df = pandas.read_csv('data/Relatorio_cadop.csv', sep=';')
    return df.to_json(orient='records', force_ascii=False)

# Hello world route
@app.route('/', methods=['GET'])
def retrieveData():
    return getDataForTable()

@app.route('/search:<search>', methods=['GET'])
def getDataWithSearch(search):
    df = pandas.read_csv('data/Relatorio_cadop.csv', sep=';')
    search_normalized = normalize(search)

    def matches(row):
        return row.astype(str).apply(normalize).str.contains(search_normalized, na=False).any()

    result = df.apply(matches, axis=1)
    return df[result].to_json(orient='records', force_ascii=False)

if __name__ == "__main__":
    app.run(debug=True, port=5001)