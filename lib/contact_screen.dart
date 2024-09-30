import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'message_screen.dart'; // Import the MessageScreen for navigation
import 'profile_screen.dart'; // Import the ProfileScreen for navigation

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  // Sample data for contacts (replace with actual data or API integration)
  final List<Map<String, dynamic>> contacts = [
    {"name": "Jigo Junagadh", "status": "Online", "lastSeen": null},
    {"name": "Antonio Banderas", "status": "Online", "lastSeen": null},
    {"name": "Bessie Cooper", "status": null, "lastSeen": "Today at 8:40"},
    {"name": "Leslie Alexander", "status": null, "lastSeen": "Today at 8:40"},
    {"name": "Jacob Jones", "status": null, "lastSeen": "Today at 8:40"},
    {"name": "Leslie Alexander", "status": null, "lastSeen": "Today at 8:40"},
    {"name": "Floyd Miles", "status": null, "lastSeen": "Long time ago"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Contacts",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Action for search
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Add Invite and Find People Nearby Options
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.person_add, color: Colors.black),
                    SizedBox(width: 8),
                    Text(
                      "Invite friends",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.black),
                    SizedBox(width: 8),
                    Text(
                      "Find people nearby",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey),

          // List of Contacts
          Expanded(
            child: contacts.isNotEmpty
                ? ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(contact['name'][0]),
                          backgroundColor: const Color.fromARGB(255, 136, 136, 136),
                        ),
                        title: Text(
                          contact['name'],
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: contact['status'] != null
                            ? Text(
                                contact['status'],
                                style: TextStyle(color: Colors.green),
                              )
                            : Text("Last seen ${contact['lastSeen']}"),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "No contacts available",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open a new contact form or similar action
        },
        backgroundColor: Colors.black,
        child: Icon(CupertinoIcons.person_2_fill),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Make Contacts the selected tab
        onTap: (int index) {
          switch (index) {
            case 0:
              // Navigate to Messages screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MessageScreen()),
              );
              break;
            case 1:
              // Stay on Contacts screen
              break;
            case 2:
              // Navigate to Profile screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_text_fill),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_2_fill),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_fill),
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
