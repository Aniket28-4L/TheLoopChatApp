import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool useHighPriority = true;
  String notificationTone = "Default Tone";
  String conversationTone = "Default Tone";
  String vibrateOption = "Default";
  Color lightColor = Colors.white;

  // Helper method to display custom dialog with professional style
  Future<void> _showSelectionDialog({
    required String title,
    required List<String> options,
    required Function(String) onSelect,
    required String selectedValue,
  }) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600), // Refined font weight
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Softer rounded corners
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: options.map((option) {
              return ListTile(
                title: Text(
                  option,
                  style: TextStyle(
                    fontSize: 16,
                    color: option == selectedValue ? Colors.black : Colors.grey[600], // Professional text colors
                    fontWeight: option == selectedValue ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                trailing: option == selectedValue
                    ? const Icon(Icons.check, color: Colors.black) // Classy checkmark
                    : null,
                onTap: () {
                  onSelect(option);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _selectNotificationTone() {
    _showSelectionDialog(
      title: "Notification Tone",
      options: ['Default Tone', 'Tone 1', 'Tone 2'],
      onSelect: (value) {
        setState(() {
          notificationTone = value;
        });
      },
      selectedValue: notificationTone,
    );
  }

  void _selectConversationTone() {
    _showSelectionDialog(
      title: "Conversation Tone",
      options: ['Default Tone', 'Tone A', 'Tone B'],
      onSelect: (value) {
        setState(() {
          conversationTone = value;
        });
      },
      selectedValue: conversationTone,
    );
  }

  void _selectVibrateOption() {
    _showSelectionDialog(
      title: "Vibrate",
      options: ['Default', 'Silent', 'Vibrate On'],
      onSelect: (value) {
        setState(() {
          vibrateOption = value;
        });
      },
      selectedValue: vibrateOption,
    );
  }

  void _selectLightColor() {
    _showSelectionDialog(
      title: "Light Color",
      options: ['White', 'Black'],
      onSelect: (value) {
        setState(() {
          lightColor = value == 'White' ? Colors.white : Colors.black;
        });
      },
      selectedValue: lightColor == Colors.white ? 'White' : 'Black',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Notification Settings',
          style: TextStyle(
            fontSize: 18, // Professional, not too large
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              'Messages',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
          
          // Conversation Tones
          ListTile(
            title: const Text(
              'Conversation tones',
              style: TextStyle(fontSize: 16),
            ),
            subtitle: Text(conversationTone),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            onTap: _selectConversationTone,
          ),
          const Divider(),

          // Notification Tone
          ListTile(
            title: const Text(
              'Notification tone',
              style: TextStyle(fontSize: 16),
            ),
            subtitle: Text(notificationTone),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            onTap: _selectNotificationTone,
          ),
          const Divider(),

          // Vibrate
          ListTile(
            title: const Text(
              'Vibrate',
              style: TextStyle(fontSize: 16),
            ),
            subtitle: Text(vibrateOption),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            onTap: _selectVibrateOption,
          ),
          const Divider(),

          // Light Color
          ListTile(
            title: const Text(
              'Light',
              style: TextStyle(fontSize: 16),
            ),
            subtitle: Text(lightColor == Colors.white ? 'White' : 'Black'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            onTap: _selectLightColor,
          ),
          const Divider(),

          // High Priority Notifications
          ListTile(
            title: const Text(
              'Use high priority notifications',
              style: TextStyle(fontSize: 16),
            ),
            trailing: Switch(
              value: useHighPriority,
              onChanged: (bool value) {
                setState(() {
                  useHighPriority = value;
                });
              },
              activeColor: Colors.black,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }
}
