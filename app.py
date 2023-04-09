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
    json_file['popular_threat_classification'] = file.get('popular_threat_classification')

    if (json_file['popular_threat_classification']):
        new_dict = {"name": json_file["meaningful_name"],
            "md5": json_file["md5"],
            "sections": [],
            "imports": json_file["pe_info"]["import_list"],
            "votes": json_file["last_analysis_stats"],  
            "suggested_threat_label": json_file["popular_threat_classification"]['suggested_threat_label']}
    else:
        new_dict = {"name": json_file["meaningful_name"],
            "md5": json_file["md5"],
            "sections": [],
            "imports": json_file["pe_info"]["import_list"],
            "votes": json_file["last_analysis_stats"],  
            "suggested_threat_label": 'nope'}
        
    for i in json_file["pe_info"]["sections"]:
        new_dict["sections"].append({"name": i["name"],
                                    "entropy": i["entropy"],
                                    "raw_size": i["raw_size"],
                                    "virtual_size": i["virtual_size"]})

    client.close()
    # with open("myfile.json", "w") as f:
    #     # Writing data to a file
    #     f.write(jsonify(json_file))
    return jsonify(new_dict)
    # return Flask.jsonify(json_file)
