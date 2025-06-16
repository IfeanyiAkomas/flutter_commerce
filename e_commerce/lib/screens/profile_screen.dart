import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const MethodChannel _deviceChannel = MethodChannel('com.example.device/info');

  Map<String, dynamic> deviceInfo = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDeviceInfo();
  }

  Future<void> fetchDeviceInfo() async {
    try {
      final info = await _deviceChannel.invokeMethod<Map>('getDeviceInfo');
      setState(() {
        deviceInfo = Map<String, dynamic>.from(info ?? {});
        isLoading = false;
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to get device info: \${e.message}");
      setState(() {
        deviceInfo = {'Error': 'Failed to fetch device info'};
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Your Profile'),
        backgroundColor: Colors.blueAccent,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            _buildUserCard(),
            const SizedBox(height: 30),
            const Text(
              "📱 Device Info",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: deviceInfo.entries
                        .map((entry) => _buildInfoTile(entry.key, entry.value))
                        .toList(),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 32, color: Colors.blueAccent),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Hi there 👋", style: TextStyle(color: Colors.white, fontSize: 16)),
              SizedBox(height: 4),
              Text("Premium Shopper", style: TextStyle(color: Colors.white70, fontSize: 14)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildInfoTile(String label, dynamic value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          Flexible(
            child: Text(
              value.toString(),
              textAlign: TextAlign.end,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
