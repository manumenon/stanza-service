import requests
import json
url = 'http://localhost:80/'

# Get information about the sentence from CoreNLP
text ="""Inc. is an American multinational technology company which focuses on e-commerce, cloud computing, digital streaming, and artificial intelligence. It is one of the Big Five companies in the U.S. information technology industry, along with Google, Apple, Meta, and Microsoft. Wikipedia"""
r = requests.post(url, data=text.encode('utf-8'), timeout=60)
print(r.json())
for item in r.json()["sentences"]:
     for i in item["entitymentions"]:
       print(i['text'],i['ner'])
