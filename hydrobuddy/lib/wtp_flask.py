from flask import Flask, request, jsonify
import requests
import base64

app = Flask(__name__)

# Consider using environment variables or an external configuration for this.
API_KEY = "BDGkSYXIHV7yWewKyWkwIden37L17TYyuRBeXMmPwpzAVhVkPf"
API_ENDPOINT = "https://plant.id/api/v3/identification"

@app.route('/identify', methods=['POST'])
def identify_plant():
    image_file = request.files.get('image')
    
    if not image_file:
        return jsonify({"error": "No image file provided."}), 400

    image_base64 = convert_image_to_base64(image_file)
    plant_name = get_plant_name_from_image(image_base64)
    
    if not plant_name:
        return jsonify({"error": "Failed to identify the plant."}), 500

    return jsonify({"plant_name": plant_name})


def get_plant_name_from_image(image_base64):
    headers = {
        "Api-Key": API_KEY,
        "Content-Type": "application/json"
    }
    
    data = {
        "images": [image_base64],
        # Include other optional parameters as needed
        # "similar_images": True,
        # "health": "all",  # If you want health assessment as well
    }
    
    try:
        response = requests.post(API_ENDPOINT, headers=headers, json=data)

        if response.status_code not in [200, 201]:
            print(f"API request failed with status code {response.status_code}: {response.text}")
            return None

        data = response.json()

        plant_suggestions = data["result"]["classification"]["suggestions"]
        top_suggestion = plant_suggestions[0]["name"]
        return top_suggestion

    except KeyError:
        print("Unexpected API response format.")
        return None
    except requests.RequestException as e:
        print(f"Network error: {e}")
        return None


def convert_image_to_base64(image_file):
    return base64.b64encode(image_file.read()).decode('utf-8')


if __name__ == '__main__':
    app.run(debug=True)
