from flask import Flask, request, jsonify
from flask_cors import CORS
from moderation import detect_moderation_labels_from_url
from vqa import predict

app = Flask(__name__)
CORS(app)

@app.route('/predict', methods=['POST'])
def predict_image():
    data = request.get_json()

    if 'url' in data:
        url = data['url']
        moderation_labels = detect_moderation_labels_from_url(url)
        if len(moderation_labels) > 0:
            return jsonify({
                'success': False,
                'message': 'Ảnh không phù hợp tiêu chuẩn',
                'url': url,
            })
        vqa_prediction = predict(url)
        if vqa_prediction[0]['score'] < 0.8 or vqa_prediction[0]['answer'] == 'no':
            return jsonify({
                'success': False,
                'message': 'Ảnh không đúng nhiệm vụ',
                'url': url,
            })
        return jsonify({
            'success': True,
            'message': 'Ảnh đúng nhiệm vụ',
            'url': url
        })
    else:
        return jsonify({
            'success': False,
            'message': 'Không tìm thấy url',
        })