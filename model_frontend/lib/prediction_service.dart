import 'dart:convert';
import 'package:http/http.dart' as http;

class PredictionService {
  static Future<double> predictSuccessRate(Map<String, dynamic> inputData) async{
    final url = Uri.parse('http://localhost:8000/predict');

    final res = await http.post(url, body: json.encode(inputData));

    if(res.statusCode == 200){
      final prediction = jsonDecode(res.body);
      return prediction['success_rate'];
    } else {
      throw Exception('Failed to predict success rate');
    }
  }
}