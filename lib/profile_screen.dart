import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'message_screen.dart';
import 'contact_screen.dart';
import 'notification_screen.dart';
import 'chats_screen.dart';
import 'edit_profile_screen.dart';
import 'sto_data_screen.dart'; // Import StorageDataScreen for navigation

class ProfileScreen extends StatefulWidget {
  final String? name;

  const ProfileScreen({super.key, this.name});

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
        elevation: 4,
        leading: IconButton(
          icon: Image.asset('assets/images/loop_logo.png'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // Profile Info
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey,
              child: Text(
                (_updatedName != null ? _updatedName![0] : (widget.name != null ? widget.name![0] : 'AP')),
                style: const TextStyle(fontSize: 20),
              ),
            ),
            title: GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                      name: widget.name ?? 'Unknown',
                    ),
                  ),
                );
                if (result != null && result.containsKey('name')) {
                  setState(() {
                    _updatedName = result['name'];
                  });
                }
              },
              child: Text(
                _updatedName ?? widget.name ?? 'Unknown',
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
              // Navigate to StorageDataScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StorageDataScreen()),
              );
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
        currentIndex: 2,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MessageScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ContactScreen()),
              );
              break;
            case 2:
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
