import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart'; // Ensure you have this import
import 'package:contacts_service/contacts_service.dart'; // Import contacts service
import 'package:permission_handler/permission_handler.dart'; // Import permission handler
import 'message_screen.dart';
import 'profile_screen.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final List<Map<String, dynamic>> contacts = [
    {"name": "Jigo Junagadh", "status": "Online", "lastSeen": null},
    {"name": "Antonio Banderas", "status": "Online", "lastSeen": null},
    {"name": "Bessie Cooper", "status": null, "lastSeen": "Today at 8:40"},
    {"name": "Leslie Alexander", "status": null, "lastSeen": "Today at 8:40"},
    {"name": "Jacob Jones", "status": null, "lastSeen": "Today at 8:40"},
    {"name": "Leslie Alexander", "status": null, "lastSeen": "Today at 8:40"},
    {"name": "Floyd Miles", "status": null, "lastSeen": "Long time ago"},
  ];

  List<Map<String, dynamic>> filteredContacts = []; // List for filtered contacts
  final TextEditingController _searchController = TextEditingController(); // Text editing controller

  @override
  void initState() {
    super.initState();
    filteredContacts = contacts; // Initialize filtered contacts
    _searchController.addListener(_filterContacts); // Add listener to search controller
  }

  void _filterContacts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredContacts = contacts
          .where((contact) =>
              contact['name'].toLowerCase().contains(query))
          .toList();
    });
  }

  void _showInviteFriendsPopup() {
    // Create a shareable message
    final String message = 'Check out this cool app: <your_link_here>';
    Share.share(message); // Directly share the message without any popup
  }

  Future<void> _fetchContacts() async {
    // Request permission to access contacts
    final PermissionStatus permissionStatus = await Permission.contacts.request();

    if (permissionStatus.isGranted) {
      Iterable<Contact> contactList = await ContactsService.getContacts();
      // You can navigate to another screen to show the contacts or do something else
      // For demonstration, just show a popup with the contacts
      _showContactsDialog(contactList);
    } else {
      // Handle permission denied case
      _showErrorDialog("Permission denied to access contacts.");
    }
  }

  void _showContactsDialog(Iterable<Contact> contactList) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Your Contacts'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: contactList.length,
              itemBuilder: (context, index) {
                Contact contact = contactList.elementAt(index);
                return ListTile(
                  title: Text(contact.displayName ?? 'No name'),
                  onTap: () {
                    Share.share('Check out this cool app: <your_link_here> with ${contact.displayName}');
                    Navigator.pop(context); // Close the dialog after sharing
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose(); // Dispose of the controller
    super.dispose();
  }

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
          "Contacts",
          style: TextStyle(
            fontSize: 20, // Increased font size for visibility
            color: Colors.black,
            fontWeight: FontWeight.w600, // Slightly lighter font weight for a professional look
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search Contacts",
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),

          // Invite Friends Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: InkWell(
              onTap: _showInviteFriendsPopup, // Show the sharing popup directly
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black, // Black background
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // Changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0), // Padding inside the container
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person_add, color: Colors.white, size: 24), // White icon
                        const SizedBox(width: 8),
                        const Text(
                          "Invite friends",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white), // White text
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),

          // Contacts Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: InkWell(
              onTap: _fetchContacts, // Fetch contacts on tap
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black, // Black background
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // Changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0), // Padding inside the container
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.contacts, color: Colors.white, size: 24), // White icon
                        const SizedBox(width: 8),
                        const Text(
                          "Contacts",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white), // White text
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),
          const Divider(height: 1, color: Colors.grey),
          const SizedBox(height: 10),

          // Contacts List
          Expanded(
            child: filteredContacts.isNotEmpty
                ? ListView.builder(
                    itemCount: filteredContacts.length,
                    itemBuilder: (context, index) {
                      final contact = filteredContacts[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Text(
                              contact['name'][0],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            contact['name'],
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: contact['status'] != null
                              ? Text(
                                  contact['status'],
                                  style: const TextStyle(color: Colors.green),
                                )
                              : Text("Last seen ${contact['lastSeen']}"),
                          trailing: IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () {
                              // Add options or actions on each contact
                            },
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      "No contacts available",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MessageScreen()),
              );
              break;
            case 1:
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
              break;
          }
        },
        items: const [
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
