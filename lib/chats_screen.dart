import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  // Variables to store current selections
  String _currentTheme = 'Dark';
  String _currentFontSize = 'Medium';

  // List of available font sizes
  final List<String> _fontSizes = ['Small', 'Medium', 'Large'];
  // List of available themes
  final List<String> _themes = ['Light', 'Dark'];

  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Theme'),
          content: SingleChildScrollView(
            child: ListBody(
              children: _themes.map((theme) {
                return RadioListTile<String>(
                  title: Text(theme),
                  value: theme,
                  groupValue: _currentTheme,
                  onChanged: (value) {
                    setState(() {
                      _currentTheme = value!;
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void _showFontSizeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Font Size'),
          content: SingleChildScrollView(
            child: ListBody(
              children: _fontSizes.map((size) {
                return RadioListTile<String>(
                  title: Text(size),
                  value: size,
                  groupValue: _currentFontSize,
                  onChanged: (value) {
                    setState(() {
                      _currentFontSize = value!;
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 4,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Display
          const Text(
            'Display',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('Theme'),
            subtitle: Text('Current: $_currentTheme'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: _showThemeDialog,
          ),
          ListTile(
            title: const Text('Wallpaper'),
            subtitle: const Text('Change wallpaper'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle wallpaper selection
            },
          ),
          const Divider(),
          // Chat settings
          const Text(
            'Chat settings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('Enter is send'),
            subtitle: const Text('Enter key will send your message'),
            trailing: Switch(
              value: true,
              onChanged: (bool value) {
                // Handle switch change
              },
            ),
          ),
          ListTile(
            title: const Text('Media visibility'),
            subtitle: const Text('Show newly downloaded media in your device\'s gallery'),
            trailing: Switch(
              value: true,
              onChanged: (bool value) {
                // Handle switch change
              },
            ),
          ),
          ListTile(
            title: const Text('Font size'),
            subtitle: Text('Current: $_currentFontSize'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: _showFontSizeDialog,
          ),
          const Divider(),
          // Archived chats
          const Text(
            'Archived chats',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('Keep chats archived'),
            subtitle: const Text('Archived chats will remain archived when you receive a new message'),
            trailing: Switch(
              value: true,
              onChanged: (bool value) {
                // Handle switch change
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Chat backup'),
            onTap: () {
              // Handle chat backup
            },
          ),
          ListTile(
            title: const Text('Transfer chats'),
            onTap: () {
              // Handle transfer chats
            },
          ),
          ListTile(
            title: const Text('Chat history'),
            onTap: () {
              // Handle chat history
            },
          ),
        ],
      ),
    );
  }
}
