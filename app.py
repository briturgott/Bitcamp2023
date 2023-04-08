from flask import Flask, jsonify, request
import vt

app = Flask(__name__)

@app.route("/analyze", methods=['POST'])
# @app.route("/")
def analyze_file():
    file_hash = request.json['file_hash']
    hash_path = "/files/" + file_hash
    # hash_path = "/files/c8994e2703410f8dfe19de5bf82994c0"
    json_file = {}

    with open('api_key.txt') as f:
        api_key = f.read().strip()

    client = vt.Client(api_key)
    file = client.get_object(hash_path)

    json_file['pe_info'] = file.pe_info 
    json_file['meaningful_name'] = file.meaningful_name
    json_file['last_analysis_stats'] = file.last_analysis_stats
    json_file['md5'] = file.md5

    client.close()
    # with open("myfile.json", "w") as f:
    #     # Writing data to a file
    #     f.write(jsonify(json_file))
    return jsonify(json_file)
    # return Flask.jsonify(json_file)
