
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // For Cupertino icons
import 'profile_screen.dart'; // Import ProfileScreen

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  bool _isSearching = false;

  // Sample data for messages (replace with actual data or API integration)
  final List<Map<String, dynamic>> messages = [
    {"name": "Jigo Junagadh", "message": "You're welcome", "time": "9:23", "unread": 0},
    {"name": "Annette Black", "message": "Hello there?", "time": "8:45", "unread": 0},
    {"name": "Bessie Cooper", "message": "Thanks ray!", "time": "9:23", "unread": 2},
    {"name": "Darlene Robertson", "message": "Okay thank you robbert", "time": "6:00", "unread": 0},
    {"name": "Arlene McCoy", "message": "Okay thank you robbert", "time": "9:23", "unread": 2},
    {"name": "Kristin Watson", "message": "You're welcome", "time": "9:23", "unread": 0},
    {"name": "Albert Flores", "message": "You're welcome", "time": "9:23", "unread": 0},
    {"name": "Jane Cooper", "message": "You're welcome", "time": "9:23", "unread": 0},
     {"name": "Jigo Junagadh", "message": "You're welcome", "time": "9:23", "unread": 0},
    {"name": "Annette Black", "message": "Hello there?", "time": "8:45", "unread": 0},
    {"name": "Bessie Cooper", "message": "Thanks ray!", "time": "9:23", "unread": 2},
    {"name": "Darlene Robertson", "message": "Okay thank you robbert", "time": "6:00", "unread": 0},
    {"name": "Arlene McCoy", "message": "Okay thank you robbert", "time": "9:23", "unread": 2},
    {"name": "Kristin Watson", "message": "You're welcome", "time": "9:23", "unread": 0},
    {"name": "Albert Flores", "message": "You're welcome", "time": "9:23", "unread": 0},
    {"name": "Jane Cooper", "message": "You're welcome", "time": "9:23", "unread": 0}
  ];

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
    });
  }

  // Open a chat screen when clicking on a message
  void _openChat(String name) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(name: name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('assets/images/loop_logo.png'), // Custom loop icon
          onPressed: () {
            // Action for loop icon
          },
        ),
        title: _isSearching
            ? TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
                autofocus: true,
              )
            : Text(
                "Messages",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
        centerTitle: true, // Center the title
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(message['name'][0]),
              backgroundColor: const Color.fromARGB(255, 136, 136, 136),
            ),
            title: Text(
              message['name'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                
              ),
            ),
            subtitle: Text(message['message']),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(message['time']),
                if (message['unread'] > 0)
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message['unread'].toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
            onTap: () => _openChat(message['name']),
          );
        },
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                // Action for new message
              },
              backgroundColor: const Color.fromARGB(255, 234, 114, 255),
              child: Icon(Icons.flash_on, size: 24), // Thunder icon
            ),
          ),
          Positioned(
            bottom: 90, // Adjust as per the design
            right: 16,
            child: FloatingActionButton(
              mini: true,
              onPressed: () {
                // Action for new chat or pencil button
              },
              backgroundColor: Colors.black,
              child: Icon(Icons.edit, color: Colors.white, size: 20), // Pencil icon
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Default selected index
        onTap: (int index) {
          switch (index) {
            case 0:
              // When tapping "Messages" while on the profile screen, navigate back to messages
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MessageScreen()),
                (Route<dynamic> route) => false, // This ensures the current route is removed
              );
              break;
            case 1:
              // Navigate to Contacts screen (fill this in as needed)
              break;
            case 2:
              // Navigate to Profile screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()), // Directly navigate to ProfileScreen
              );
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0), // Adjust for correct positioning
              child: Icon(CupertinoIcons.chat_bubble_text_fill), // iOS-style chat icon
            ),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0), // Adjust for correct positioning
              child: Icon(CupertinoIcons.person_2_fill), // iOS-style contacts icon
            ),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0), // Adjust for correct positioning
              child: Icon(CupertinoIcons.person_fill), // iOS-style profile icon
            ),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.black,  // Active icon color
        unselectedItemColor: Colors.grey, // Inactive icon color
        showUnselectedLabels: true,
      ),
    );
  }
}

// Chat Screen Placeholder
class ChatScreen extends StatelessWidget {
  final String name;

  ChatScreen({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          "Chatting with $name (Automated Messages)",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
