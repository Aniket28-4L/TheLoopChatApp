import 'package:flutter/material.dart';

class StorageDataScreen extends StatefulWidget {
  const StorageDataScreen({Key? key}) : super(key: key);

  @override
  _StorageDataScreenState createState() => _StorageDataScreenState();
}

class _StorageDataScreenState extends State<StorageDataScreen> {
  String proxyStatus = 'Off';
  String uploadQuality = 'Standard quality';
  String mobileDataDownload = 'Photos';
  String wifiDownload = 'All media';
  String roamingDownload = 'No media';

  // Helper method to display custom dialog for selections
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
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: options.map((option) {
              return ListTile(
                title: Text(
                  option,
                  style: TextStyle(
                    fontSize: 16,
                    color: option == selectedValue ? Colors.black : Colors.grey[600],
                    fontWeight: option == selectedValue ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                trailing: option == selectedValue
                    ? const Icon(Icons.check, color: Colors.black)
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

  // Handlers for each selection popup
  void _selectProxy() {
    _showSelectionDialog(
      title: 'Proxy',
      options: ['Off', 'Manual', 'Auto-config'],
      onSelect: (value) {
        setState(() {
          proxyStatus = value;
        });
      },
      selectedValue: proxyStatus,
    );
  }

  void _selectUploadQuality() {
    _showSelectionDialog(
      title: 'Media upload quality',
      options: ['Standard quality', 'High quality', 'Data saver'],
      onSelect: (value) {
        setState(() {
          uploadQuality = value;
        });
      },
      selectedValue: uploadQuality,
    );
  }

  void _selectMobileDataDownload() {
    _showSelectionDialog(
      title: 'When using mobile data',
      options: ['Photos', 'Audio', 'Videos', 'Documents'],
      onSelect: (value) {
        setState(() {
          mobileDataDownload = value;
        });
      },
      selectedValue: mobileDataDownload,
    );
  }

  void _selectWifiDownload() {
    _showSelectionDialog(
      title: 'When connected on Wi-Fi',
      options: ['All media', 'Photos', 'Audio', 'Videos', 'Documents'],
      onSelect: (value) {
        setState(() {
          wifiDownload = value;
        });
      },
      selectedValue: wifiDownload,
    );
  }

  void _selectRoamingDownload() {
    _showSelectionDialog(
      title: 'When roaming',
      options: ['No media', 'Photos', 'Audio', 'Videos', 'Documents'],
      onSelect: (value) {
        setState(() {
          roamingDownload = value;
        });
      },
      selectedValue: roamingDownload,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Storage and Data',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF1EFF6), // Updated app bar background color
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: const Color(0xFFFEF7FF), // Updated overall background color
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Manage storage
            ListTile(
              leading: const Icon(Icons.folder, color: Colors.black),
              title: Text(
                'Manage storage',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              subtitle: const Text(
                '12.1 GB',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                // Manage storage logic here
              },
            ),
            const Divider(color: Colors.grey),

            // Network usage
            ListTile(
              leading: const Icon(Icons.network_check, color: Colors.black),
              title: Text(
                'Network usage',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              subtitle: const Text(
                '288.7 MB sent • 1.7 GB received',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                // Network usage logic here
              },
            ),
            const Divider(color: Colors.grey),

            // Use less data for calls
            SwitchListTile(
              value: false,
              onChanged: (bool value) {
                // Data saving logic here
              },
              title: Text(
                'Use less data for calls',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              secondary: const Icon(Icons.data_saver_on, color: Colors.black),
              activeColor: const Color(0xFF4A148C), // Purple color for the active switch
              inactiveThumbColor: Colors.grey,
            ),
            const Divider(color: Colors.grey),

            // Proxy
            ListTile(
              leading: const Icon(Icons.vpn_key, color: Colors.black),
              title: Text(
                'Proxy',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              subtitle: Text(proxyStatus, style: const TextStyle(color: Colors.grey)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: _selectProxy,
            ),
            const Divider(color: Colors.grey),

            // Media upload quality
            ListTile(
              leading: const Icon(Icons.high_quality, color: Colors.black),
              title: Text(
                'Media upload quality',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              subtitle: Text(uploadQuality, style: const TextStyle(color: Colors.grey)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: _selectUploadQuality,
            ),
            const Divider(color: Colors.grey),

            // Media auto-download
            const Text(
              'Media auto-download',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),

            // Mobile data download
            ListTile(
              title: Text(
                'When using mobile data',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              subtitle: Text(mobileDataDownload, style: const TextStyle(color: Colors.grey)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: _selectMobileDataDownload,
            ),

            // Wi-Fi download
            ListTile(
              title: Text(
                'When connected on Wi-Fi',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              subtitle: Text(wifiDownload, style: const TextStyle(color: Colors.grey)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: _selectWifiDownload,
            ),

            // Roaming download
            ListTile(
              title: Text(
                'When roaming',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              subtitle: Text(roamingDownload, style: const TextStyle(color: Colors.grey)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: _selectRoamingDownload,
            ),
          ],
        ),
      ),
    );
  }
}
