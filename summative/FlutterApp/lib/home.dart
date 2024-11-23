import 'package:flutter/material.dart';
import 'prediction_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _jobTitleController = TextEditingController();
  final _genderController = TextEditingController();
  final _ageController = TextEditingController();
  final _perfEvalController = TextEditingController();
  final _educationController = TextEditingController();
  final _deptController = TextEditingController();
  final _seniorityController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _bonusController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _jobTitleController.dispose();
    _genderController.dispose();
    _ageController.dispose();
    _perfEvalController.dispose();
    _educationController.dispose();
    _deptController.dispose();
    _seniorityController.dispose();
    _bonusController.dispose();
    super.dispose();
  }

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
                _buildTextField('Enter Your Name',
                controller: _nameController,
                validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                ),
                const SizedBox(height: 16),
                _buildTextField('Enter Your Email',
                controller: _emailController,
                validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                ),
                const SizedBox(height: 16),
                _buildTextField('Age',
                controller: _ageController,
                keyboardType: TextInputType.number,
                validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your age';
                        }
                        final age = int.tryParse(value);
                        if (age == null || age < 18 || age > 100) {
                          return 'Please enter a valid age between 18 and 100';
                        }
                        return null;
                      },
                ),
                const SizedBox(height: 16),
                _buildTextField('Gender',
                controller: _genderController,
                validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your gender';
                        }
                        return null;
                      },
                ),
                const SizedBox(height: 16),
                _buildTextField('Education Level (High School/College/Masters/PhD)',
                controller: _educationController,
                validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your education level';
                        }
                        return null;
                      },
                ),
                const SizedBox(height: 16),
                _buildTextField('Job Title',
                controller: _jobTitleController,
                validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your job title';
                        }
                        return null;
                      },
                ),
                const SizedBox(height: 16),
                _buildTextField('Department',
                controller: _deptController,
                validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your department';
                        }
                        return null;
                      },
                ),
                const SizedBox(height: 16),
                _buildTextField('Seniority (Years)',
                controller: _seniorityController,
                keyboardType: TextInputType.number,
                validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your seniority';
                        }
                        final seniority = int.tryParse(value);
                        if (seniority == null || seniority < 0) {
                          return 'Please enter a valid seniority value';
                        }
                        return null;
                      },),
                const SizedBox(height: 16),
                _buildTextField('Performance Evaluation (1-5)',
                controller: _perfEvalController,
                keyboardType: TextInputType.number,
                validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your performance evaluation';
                        }
                        final eval = double.tryParse(value);
                        if (eval == null || eval < 0 || eval > 5) {
                          return 'Please enter a valid evaluation between 0 and 5';
                        }
                        return null;
                      },),
                const SizedBox(height: 16),
                    _buildTextField(
                      'Bonus',
                      controller: _bonusController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your bonus amount';
                        }
                        final bonus = double.tryParse(value);
                        if (bonus == null || bonus < 0) {
                          return 'Please enter a valid bonus amount';
                        }
                        return null;
                      },
                    ),

                
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () async{
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    try{
                      final inputData = PredictionInput(
                              name: _nameController.text,
                              email: _emailController.text,
                              jobTitle: _jobTitleController.text,
                              department: _deptController.text,
                              gender: _genderController.text,
                              education: _educationController.text,
                              age: int.parse(_ageController.text),
                              perfEval: double.parse(_perfEvalController.text),
                              seniority: int.parse(_seniorityController.text),
                              bonus: double.parse(_bonusController.text),
                      );
                      final prediction = await PredictionService.predictSalary(inputData);

                      if (!mounted) return;
                      Navigator.pushNamed(
                              context, 
                              '/result',
                              arguments: prediction,
                            );
                    }catch (error) {
                      if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error: ${error.toString()}'),
                                backgroundColor: Colors.red,
                              ),
                            );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006D6F),
                    foregroundColor: Colors.white,
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
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}