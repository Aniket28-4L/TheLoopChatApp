
import 'package:flutter/material.dart';
import 'message_screen.dart';  // Import the message screen

class CreateNameScreen extends StatefulWidget {
  @override
  _CreateNameScreenState createState() => _CreateNameScreenState();
}

class _CreateNameScreenState extends State<CreateNameScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _warningMessage = '';

  // Function to validate the name input
  void validateName(String value) {
    final validCharacters = RegExp(r'^[a-zA-Z0-9_]*$');
    if (!validCharacters.hasMatch(value)) {
      setState(() {
        _warningMessage = 'Special characters are not allowed, except for underscores.';
      });
    } else {
      setState(() {
        _warningMessage = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Create your name',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Get more people to know your name',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: 'Name',
              ),
              keyboardType: TextInputType.name,
              onChanged: (value) {
                validateName(value);
              },
            ),
            SizedBox(height: 10),
            if (_warningMessage.isNotEmpty)
              Text(
                _warningMessage,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_warningMessage.isEmpty && _nameController.text.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MessageScreen(),  // Navigate to MessageScreen
                      ),
                    );
                  } else {
                    setState(() {
                      _warningMessage = 'Please correct the name before proceeding.';
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
                child: Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
