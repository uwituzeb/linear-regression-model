import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Predict your success rate',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  
                ),
                const SizedBox(height: 8),
                const Text(
                  'Fill out the fields below',
                  style: TextStyle(color: Colors.grey),
                  
                ),
                const SizedBox(height: 32),
                _buildTextField('Enter Your Name'),
                const SizedBox(height: 16),
                _buildTextField('Enter Your Email'),
                const SizedBox(height: 16),
                _buildTextField('Education Level (e.g., Bachelor’s, Master’s)'),
                const SizedBox(height: 16),
                _buildTextField('Years of Experience in Tech'),
                    const SizedBox(height: 16),
                    _buildTextField('Top Technical Skills (e.g., Python, Java)'),
                    const SizedBox(height: 16),
                    _buildTextField('Mentorship or Networking Involvement'),
                    const SizedBox(height: 16),
                    _buildTextField('Company Supportive Environment (e.g., Very Supportive)'),
                    const SizedBox(height: 32.0),
                
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
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