import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'message_screen.dart'; // Import MessageScreen to enable navigation
import 'contact_screen.dart'; // Import ContactsScreen for navigation
import 'notification_screen.dart'; // Import NotificationScreen for navigation
import 'chats_screen.dart'; // Import ChatsScreen for navigation
import 'edit_profile_screen.dart'; // Import EditProfileScreen for editing profile

class ProfileScreen extends StatefulWidget {
  final String? name; // Optional name parameter

  const ProfileScreen({super.key, this.name}); // Constructor with name parameter

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _updatedName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4, // Added elevation for shadow effect
        leading: IconButton(
          icon: Image.asset('assets/images/loop_logo.png'), // Replacing back arrow with logo image
          onPressed: () {
            Navigator.pop(context); // Navigate back when pressed
          },
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontSize: 20, // Increased font size for visibility
            color: Colors.black,
            fontWeight: FontWeight.w600, // Slightly lighter font weight for a professional look
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // Profile Info
          ListTile(
            leading: CircleAvatar(
              radius: 30, // Size of the profile picture
              backgroundColor: Colors.grey,
              child: Text(
                (_updatedName != null ? _updatedName![0] : (widget.name != null ? widget.name![0] : 'AP')),
                style: const TextStyle(fontSize: 20),
              ), // Placeholder for profile avatar
            ),
            title: GestureDetector(
              onTap: () async {
                // Navigate to the Edit Profile Screen
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                      name: widget.name ?? 'Unknown', // Pass the current name to the edit screen
                    ),
                  ),
                );
                // Update the profile with the new name if provided
                if (result != null && result.containsKey('name')) {
                  setState(() {
                    _updatedName = result['name']; // Update the name
                  });
                }
              },
              child: Text(
                _updatedName ?? widget.name ?? 'Unknown', // Display updated name or fallback to the original name or "Unknown"
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            subtitle: const Text(
              'Online',
              style: TextStyle(
                color: Colors.green,
                fontSize: 14,
              ),
            ),
          ),
          const Divider(),

          // Settings Section Heading
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Settings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),

          // Settings options with updated styling
          ListTile(
            leading: const Icon(Icons.notifications, size: 24),
            title: const Text(
              'Notification',
              style: TextStyle(fontSize: 16),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            onTap: () {
              // Navigate to NotificationScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock, size: 24),
            title: const Text(
              'Privacy and security',
              style: TextStyle(fontSize: 16),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            onTap: () {
              // Handle Privacy and security tap here
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat, size: 24),
            title: const Text(
              'Chats',
              style: TextStyle(fontSize: 16),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            onTap: () {
              // Navigate to ChatsScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.storage, size: 24),
            title: const Text(
              'Storage and data',
              style: TextStyle(fontSize: 16),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            onTap: () {
              // Handle Storage and data tap here
            },
          ),

          const Divider(),

          // Help Section Heading
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Help',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),

          // Help options with updated styling
          ListTile(
            leading: const Icon(Icons.help, size: 24),
            title: const Text(
              'What\'s up FAQ',
              style: TextStyle(fontSize: 16),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            onTap: () {
              // Handle FAQ tap here
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip, size: 24),
            title: const Text(
              'Privacy policy',
              style: TextStyle(fontSize: 16),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            onTap: () {
              // Handle Privacy policy tap here
            },
          ),
          ListTile(
            leading: const Icon(Icons.question_answer, size: 24),
            title: const Text(
              'Ask a question',
              style: TextStyle(fontSize: 16),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            onTap: () {
              // Handle Ask a question tap here
            },
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
                MaterialPageRoute(builder: (context) => const MessageScreen()),
              );
              break;
            case 1:
              // Navigate to ContactsScreen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ContactScreen()),
              );
              break;
            case 2:
              // Stay on the current Profile screen, do nothing
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Icon(CupertinoIcons.chat_bubble_text_fill, size: 28),
            ),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Icon(CupertinoIcons.person_2_fill, size: 28),
            ),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 8.0),
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
