from flask import Flask, request, jsonify
import requests
import base64
import openai

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

    # Get OpenAI response for the plant
    plant_info = generate_response(plant_name)

    return jsonify({"plant_name": plant_name, "plant_info": plant_info})


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

def generate_response(prompt):
    # Format the input as per the desired conversation format
    openai.api_key = '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'
    conversation = [
        {'role': 'system', 'content': """You are Hydrobuddy. You will return a paragraph of how to hydroponically grow this plant:"""},
        {'role': 'user', 'content': prompt},
    ]
    
    # Convert the conversation to a string  
    conversation_str = ''.join([f'{item["role"]}: {item["content"]}\n' for item in conversation])

    response = openai.ChatCompletion.create(
      model="gpt-3.5-turbo",
      messages=conversation,
      temperature=1,
      max_tokens=1000,
      top_p=1,
      frequency_penalty=0,
      presence_penalty=0
    )
    
    generated_text = response['choices'][0]['message']['content']
    return generated_text  # Return the generated text

if __name__ == '__main__':
    app.run(debug=True)
