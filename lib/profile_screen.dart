import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'message_screen.dart'; // Import MessageScreen to enable navigation

class ProfileScreen extends StatefulWidget {
  final String? name; // Optional name parameter

  ProfileScreen({this.name}); // Constructor with name parameter

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'My Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: ListView(
        children: [
          // Profile Info
          ListTile(
            leading: CircleAvatar(
              radius: 30, // Size of the profile picture
              backgroundColor: Colors.grey,
              child: Text(widget.name != null ? widget.name![0] : 'AP', style: TextStyle(fontSize: 20)), // Placeholder for profile avatar
            ),
            title: Text(
              widget.name ?? 'Unknown', // Display user name or "Unknown"
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            subtitle: Text(
              'Online', 
              style: TextStyle(
                color: Colors.green,
                fontSize: 14,
              ),
            ),
          ),
          Divider(),

          // Settings Section Heading
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Settings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),

          // Settings options
          ListTile(
            leading: Icon(Icons.notifications, size: 24),
            title: Text(
              'Notification',
              style: TextStyle(fontSize: 16),
            ),
          ),
          ListTile(
            leading: Icon(Icons.lock, size: 24),
            title: Text(
              'Privacy and security',
              style: TextStyle(fontSize: 16),
            ),
          ),
          ListTile(
            leading: Icon(Icons.chat, size: 24),
            title: Text(
              'Chats',
              style: TextStyle(fontSize: 16),
            ),
          ),
          ListTile(
            leading: Icon(Icons.storage, size: 24),
            title: Text(
              'Storage and data',
              style: TextStyle(fontSize: 16),
            ),
          ),
          
          Divider(),

          // Help Section Heading
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Help',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),

          // Help options
          ListTile(
            leading: Icon(Icons.help, size: 24),
            title: Text(
              'What\'s up FAQ',
              style: TextStyle(fontSize: 16),
            ),
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip, size: 24),
            title: Text(
              'Privacy policy',
              style: TextStyle(fontSize: 16),
            ),
          ),
          ListTile(
            leading: Icon(Icons.question_answer, size: 24),
            title: Text(
              'Ask a question',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Set this to 2, as the profile tab is selected
        onTap: (int index) {
          switch (index) {
            case 0:
              // When "Messages" icon is tapped, navigate back to MessageScreen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MessageScreen()),
              );
              break;
            case 1:
              // Add Contacts navigation if required later
              break;
            case 2:
              // Stay on the current Profile screen, do nothing
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Icon(CupertinoIcons.chat_bubble_text_fill, size: 28),
            ),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Icon(CupertinoIcons.person_2_fill, size: 28),
            ),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Icon(CupertinoIcons.person_fill, size: 28),
            ),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}
