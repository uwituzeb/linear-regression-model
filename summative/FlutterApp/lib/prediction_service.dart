import 'dart:convert';
import 'package:http/http.dart' as http;

class PredictionInput {
  final String name;
  final String email;
  final String jobTitle;
  final String department;
  final String gender;
  final String education;
  final int age;
  final double perfEval;
  final int seniority;
  final double bonus;

  PredictionInput({
    required this.name,
    required this.email,
    required this.jobTitle,
    required this.department,
    required this.gender,
    required this.education,
    required this.age,
    required this.perfEval,
    required this.seniority,
    required this.bonus,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'job_title': jobTitle,
    'department': department,
    'gender': gender,
    'education': education,
    'age': age,
    'perf_eval': perfEval,
    'seniority': seniority,
    'bonus': bonus,
  };

}

class PredictionResponse {
  final String status;
  final PredictionData data;

  PredictionResponse({
    required this.status,
    required this.data,
  });

  factory PredictionResponse.fromJson(Map<String, dynamic> json) {
    return PredictionResponse(
      status: json['status'],
      data: PredictionData.fromJson(json['data']),
    );
  }
}

class PredictionData {
  final String name;
  final String email;
  final double predictedSalary;

  PredictionData({
    required this.name,
    required this.email,
    required this.predictedSalary,
  });

  factory PredictionData.fromJson(Map<String, dynamic> json) {
    return PredictionData(
      name: json['name'],
      email: json['email'],
      predictedSalary: json['predicted_salary'].toDouble(),
    );
  }
}

class PredictionService {
  static const String baseUrl = 'http://localhost:8000';

  static Future<PredictionResponse> predictSalary(PredictionInput input) async{
    final url = Uri.parse('$baseUrl/predict');

    try{
      final response = await http.post(
        url,
        body: json.encode(input.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final prediction = PredictionResponse.fromJson(json.decode(response.body));
        return prediction;
      } else {
        throw Exception('Failed to predict salary');
      }
    } catch (e) {
      throw Exception('Error making prediction: ${e.toString()}');
    }

    // if(res.statusCode == 200){
    //   final prediction = jsonDecode(res.body);
    //   return prediction['success_rate'];
    // } else {
    //   throw Exception('Failed to predict salary');
    // }
  }
}