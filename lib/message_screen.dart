import 'package:flutter/material.dart';
import 'contact_screen.dart'; // Import ContactScreen
import 'package:flutter/cupertino.dart'; // For Cupertino icons
import 'profile_screen.dart'; // Import ProfileScreen

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController(); // Controller for search field

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

  // List to hold filtered messages
  List<Map<String, dynamic>> filteredMessages = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterMessages); // Add listener to search controller
    filteredMessages = messages; // Initialize filteredMessages with all messages
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear(); // Clear the search field
        filteredMessages = messages; // Show all messages when search is closed
      } else {
        filteredMessages = messages; // Initialize filtered messages to all messages when searching
      }
    });
  }

  void _filterMessages() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredMessages = messages.where((message) {
        return message['name'].toLowerCase().contains(query) ||
               message['message'].toLowerCase().contains(query);
      }).toList();
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
        elevation: 4, // Add a slight elevation for shadow
        leading: IconButton(
          icon: Image.asset('assets/images/loop_logo.png'), // Custom loop icon
          onPressed: () {
            // Action for loop icon
          },
        ),
        title: const Text(
          "Messages",
          style: TextStyle(
            fontSize: 20, // Increased font size for better visibility
            color: Colors.black,
            fontWeight: FontWeight.w600, // Slightly lighter font weight for a professional look
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: _isSearching
                ? const Icon(Icons.arrow_back, color: Colors.black) // Back arrow when searching
                : const Icon(Icons.search, color: Colors.black), // Search icon
            onPressed: _toggleSearch, // Open/close the search
          ),
          const SizedBox(width: 8), // Add space between icons
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          if (_isSearching) 
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search messages...',
                  hintStyle: const TextStyle(color: Colors.grey), // Placeholder style
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                autofocus: true,
              ),
            ),
          // Message List
          Expanded(
            child: ListView.builder(
              itemCount: _isSearching ? filteredMessages.length : messages.length,
              itemBuilder: (context, index) {
                final message = _isSearching ? filteredMessages[index] : messages[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Text(
                        message['name'][0],
                        style: const TextStyle(color: Colors.white), // Change font color to white
                      ),
                    ),
                    title: Text(
                      message['name'],
                      style: const TextStyle(
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
                            margin: const EdgeInsets.only(top: 5),
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle, // Make it a perfect circular shape
                            ),
                            child: Text(
                              message['unread'].toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                      ],
                    ),
                    onTap: () => _openChat(message['name']),
                  ),
                );
              },
            ),
          ),
        ],
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
              child: const Icon(Icons.flash_on, size: 24), // Thunder icon
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Default selected index
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MessageScreen()),
                (Route<dynamic> route) => false,
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ContactScreen()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 8.0), // Adjust for correct positioning
              child: Icon(CupertinoIcons.chat_bubble_text_fill), // iOS-style chat icon
            ),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 8.0), // Adjust for correct positioning
              child: Icon(CupertinoIcons.person_2_fill), // iOS-style contacts icon
            ),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 8.0), // Adjust for correct positioning
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

  const ChatScreen({super.key, required this.name});

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
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
