import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculator());
}

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BMICalculatorScreen(),
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  bool isMale = true;
  double weight = 70;
  int age = 23;
  double height = 170; // Add a default value for height

  // Calculate BMI function
  double calculateBMI() {
    if (height <= 0) return 0; // Handle case where height is zero or negative
    return weight / ((height / 100) * (height / 100));
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Normal';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  @override
  Widget build(BuildContext context) {
    double bmi = calculateBMI();
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Gender selection row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GenderSelectionButton(
                  icon: Icons.male,
                  label: 'Male',
                  isSelected: isMale,
                  onTap: () {
                    setState(() {
                      isMale = true;
                    });
                  },
                ),
                SizedBox(width: 20),
                GenderSelectionButton(
                  icon: Icons.female,
                  label: 'Female',
                  isSelected: !isMale,
                  onTap: () {
                    setState(() {
                      isMale = false;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            
            // Weight input
            InputCard(
              label: 'Weight',
              value: weight,
              unit: 'kg',
              onIncrement: () {
                setState(() {
                  weight++;
                });
              },
              onDecrement: () {
                setState(() {
                  weight--;
                });
              },
            ),
            
            // Age input
            InputCard(
              label: 'Age',
              value: age.toDouble(),
              unit: 'years',
              onIncrement: () {
                setState(() {
                  age++;
                });
              },
              onDecrement: () {
                setState(() {
                  age--;
                });
              },
            ),
            
            // Height input
            TextField(
              decoration: InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  height = double.parse(value);
                });
              },
            ),
            
            SizedBox(height: 20),
            
            // BMI and Category Display
            Text(
              bmi.toStringAsFixed(1),
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Text(
              getBMICategory(bmi),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            Spacer(),
            
            ElevatedButton(
              onPressed: () {},
              child: Text("Let's Go"),
            ),
          ],
        ),
      ),
    );
  }
}

class GenderSelectionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  GenderSelectionButton({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
       decoration: BoxDecoration(
       color: isSelected ? Color(0xFF246AFE) : Colors.grey[200], // Use Color class for custom hex color
       borderRadius: BorderRadius.circular(10),
  ),

        child: Column(
          children: [
            Icon(icon, size: 50, color: isSelected ? Colors.white : Colors.grey),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputCard extends StatelessWidget {
  final String label;
  final double value;
  final String unit;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  InputCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(width: 20),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: onDecrement,
          ),
          Text(
            value.toString(),
            style: TextStyle(fontSize: 24),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: onIncrement,
          ),
          Text(unit),
        ],
      ),
    );
  }
}
