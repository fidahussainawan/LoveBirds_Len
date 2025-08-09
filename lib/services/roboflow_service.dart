import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/bird_model.dart';
import '../utils/constants.dart';

class RoboflowService {
  static const String _baseUrl = 'https://detect.roboflow.com/lovebirds_lens/1';
  static const String _apiKey = AppConstants.roboflowApiKey;

  Future<List<BirdIdentification>> identifyBird(File imageFile) async {
    try {
      // Read image file as bytes
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      // Prepare the request
      final url = Uri.parse('$_baseUrl?api_key=$_apiKey');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: base64Image,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['predictions'] != null) {
          final List<dynamic> predictions = data['predictions'];
          return predictions
              .map((prediction) => BirdIdentification.fromJson(prediction))
              .where((bird) => bird.confidence > 0.3) // Filter by confidence threshold
              .toList()
            ..sort((a, b) => b.confidence.compareTo(a.confidence)); // Sort by confidence
        }
      } else {
        throw Exception('Failed to identify bird: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error identifying bird: $e');
    }

    return [];
  }

  Future<bool> testConnection() async {
    try {
      final url = Uri.parse('$_baseUrl?api_key=$_apiKey');
      final response = await http.get(url);
      return response.statusCode == 200 || response.statusCode == 405; // 405 is method not allowed but connection works
    } catch (e) {
      return false;
    }
  }
}