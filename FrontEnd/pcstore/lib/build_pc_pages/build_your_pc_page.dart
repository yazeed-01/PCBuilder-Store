import 'package:flutter/material.dart';

class BuildYourPCPage extends StatefulWidget {
  const BuildYourPCPage({Key? key}) : super(key: key);

  @override
  _BuildYourPCPageState createState() => _BuildYourPCPageState();
}

class _BuildYourPCPageState extends State<BuildYourPCPage> {
  int _currentStep = 0;
  double _budget = 1000;
  String _selectedUse = 'Gaming';
  Map<String, String> _selectedParts = {};

  final List<String> _pcUses = ['Gaming', 'Office Work', 'Video Editing', 'Programming', 'Graphic Design'];
  final List<String> _partCategories = ['CPU', 'Motherboard', 'RAM', 'GPU', 'Storage', 'Power Supply', 'Case', 'Cooling'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Build Your PC'),
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < _partCategories.length + 1) {
            setState(() {
              _currentStep += 1;
            });
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep -= 1;
            });
          }
        },
        steps: [
          Step(
            title: const Text('Set Your Budget and Use'),
            content: Column(
              children: [
                Slider(
                  value: _budget,
                  min: 500,
                  max: 5000,
                  divisions: 45,
                  label: '\$${_budget.round()}',
                  onChanged: (value) {
                    setState(() {
                      _budget = value;
                    });
                  },
                ),
                Text('Budget: \$${_budget.round()}'),
                const SizedBox(height: 20),
                DropdownButton<String>(
                  value: _selectedUse,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedUse = newValue;
                      });
                    }
                  },
                  items: _pcUses.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            isActive: _currentStep >= 0,
          ),
          ..._partCategories.map((part) => _buildPartStep(part)).toList(),
          Step(
            title: const Text('Review Your Build'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Budget: \$${_budget.round()}'),
                Text('Intended Use: $_selectedUse'),
                const SizedBox(height: 10),
                const Text('Selected Parts:', style: TextStyle(fontWeight: FontWeight.bold)),
                ..._selectedParts.entries.map((entry) => Text('${entry.key}: ${entry.value}')),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement functionality to save or order the build
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Your PC build has been saved!')),
                    );
                  },
                  child: const Text('Save Build'),
                ),
              ],
            ),
            isActive: _currentStep >= _partCategories.length + 1,
          ),
        ],
      ),
    );
  }

  Step _buildPartStep(String part) {
    return Step(
      title: Text('Select $part'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recommended $part based on your budget and use:'),
          const SizedBox(height: 10),
          _buildPartOptions(part),
        ],
      ),
      isActive: _currentStep >= _partCategories.indexOf(part) + 1,
    );
  }

  Widget _buildPartOptions(String part) {
    // This is a placeholder. In a real app, you'd fetch actual part recommendations.
    List<String> options = ['Option 1', 'Option 2', 'Option 3'];
    return Column(
      children: options.map((option) => RadioListTile<String>(
        title: Text('$part $option'),
        subtitle: Text('Description of $part $option'),
        value: option,
        groupValue: _selectedParts[part],
        onChanged: (String? value) {
          if (value != null) {
            setState(() {
              _selectedParts[part] = value;
            });
          }
        },
      )).toList(),
    );
  }
}

