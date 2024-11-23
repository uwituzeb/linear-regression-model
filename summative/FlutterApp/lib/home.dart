import 'package:flutter/material.dart';
import 'prediction_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _jobTitleController = TextEditingController();
final _genderController = TextEditingController();
final _ageController = TextEditingController();
final _perfEvalController = TextEditingController();
final _educationController = TextEditingController();
final _deptController = TextEditingController();
final _seniorityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: _formKey,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Predict your salary',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  
                ),
                const SizedBox(height: 8),
                const Text(
                  'Provide your background information to get a Salary insight',
                  style: TextStyle(color: Colors.grey),
                  
                ),
                const SizedBox(height: 32),
                _buildTextField('Enter Your Name'),
                const SizedBox(height: 16),
                _buildTextField('Enter Your Email'),
                const SizedBox(height: 16),
                _buildTextField('Age'),
                const SizedBox(height: 16),
                _buildTextField('Gender'),
                const SizedBox(height: 16),
                _buildTextField('Education Level (High School/College/Masters/PhD)'),
                const SizedBox(height: 16),
                _buildTextField('Job Title'),
                const SizedBox(height: 16),
                _buildTextField('Department'),
                const SizedBox(height: 16),
                _buildTextField('Seniority (Years)'),
                const SizedBox(height: 16),
                _buildTextField('Performance Evaluation (1-5)'),

                
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () async{
                    try{
                      final inputData = {
                        'job_title': _jobTitleController.text,
                        'gender': _genderController.text,
                        'age': int.parse(_ageController.text),
                        'dept': _deptController.text,
                        'education': _educationController.text,
                        'perf_eval':int.parse(_perfEvalController.text),
                        'seniority': int.parse(_seniorityController.text),
                      };
                      double prediction = await PredictionService.predictSuccessRate(inputData);
                      // showDialog(context: context, builder: (_) => AlertDialog(
                      //   title: Text("Prediction result"),
                      //   content: Text("Your success rate is ${prediction.toStringAsPercentage(accuracy: 2)}"),
                      //   actions: [
                      //     TextButton(
                      //       onPressed: () {
                      //         Navigator.pop(context);
                      //       },
                      //       child: Text('OK'),
                      //     ),
                      //   ]
                    }catch (error) {

                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006D6F),
                    foregroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Predict',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
                  ),
                ),
                

                
              ],
            ),
            ),
          ),
        ),),
      ),
    );
  }

  Widget _buildTextField(
    String hint, {
    TextEditingController? controller,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}