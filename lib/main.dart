import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const NearCashApp());
}

class NearCashApp extends StatelessWidget {
  const NearCashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NearCash Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const SplashScreen(),
    );
  }
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6A11CB),
              Color(0xFF2575FC),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(
              Icons.currency_exchange,
              size: 100,
              color: Colors.white,
            ),

            const SizedBox(height: 20),

            const Text(
              "NearCash",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Exchange cash easily nearby",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 40),

            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

 void login() {
  String phone = phoneController.text.trim();

  if (!RegExp(r'^[0-9]{10}$').hasMatch(phone)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Enter a valid 10-digit mobile number"),
      ),
    );
    return;
  }

  if (passwordController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Enter your password"),
      ),
    );
    return;
  }

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const MainNavigation(),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6A11CB),
              Color(0xFF2575FC),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  const Text(
                    "NearCash",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text("Exchange cash easily nearby"),

                  const SizedBox(height: 30),

                 TextField(
  controller: phoneController,
  keyboardType: TextInputType.number,
  maxLength: 10,
  autofillHints: const [AutofillHints.telephoneNumber],
  decoration: const InputDecoration(
    labelText: "Mobile Number",
    border: OutlineInputBorder(),
    counterText: "",
  ),
),

                  const SizedBox(height: 15),

                 TextField(
  controller: passwordController,
  obscureText: true,
  enableSuggestions: false,
  autocorrect: false,
  autofillHints: const [AutofillHints.password],
  decoration: const InputDecoration(
    labelText: "Password",
    border: OutlineInputBorder(),
  ),
),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: login,
                      child: const Text("Login"),
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Signup feature coming soon (demo)"),
                        ),
                      );
                    },
                    child: const Text("Create Account"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  List<Widget> get _screens => [
        HomeScreen(onRaiseRequest: () => _changeTab(1)),
        const RequestsScreen(),
        const ProfileScreen(),
        const SettingsScreen(),
      ];

  void _changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _changeTab,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.request_page_outlined),
            selectedIcon: Icon(Icons.request_page),
            label: "Requests",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: "Profile",
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onRaiseRequest});

  final VoidCallback onRaiseRequest;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Map<String, dynamic>> nearbyRequests = [
    {
      "name": "Chintu",
      "distance": "200 m",
      "request": "Needs ₹100 change (₹10 notes)",
      "time": "2 min ago",
      "accepted": false
    },
    {
      "name": "Devang",
      "distance": "500 m",
      "request": "Needs ₹50 change",
      "time": "5 min ago",
      "accepted": false
    },
    {
      "name": "Nandini",
      "distance": "50 m",
      "request": "Needs ₹200 change",
      "time": "Just now",
      "accepted": false
    },
  ];

  final List<Color> cardColors = [
    Colors.orange.shade100,
    Colors.green.shade100,
    Colors.blue.shade100,
  ];
  bool isWithinRange(String distance) {
    int meters = int.parse(distance.split(" ")[0]);
    return meters <= 1000;
  }

  void acceptRequest(int index) {
    setState(() {
      nearbyRequests[index]["accepted"] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NearCash"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const Text(
              "Nearby Requests (within 1 km)",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: nearbyRequests.length,
                itemBuilder: (context, index) {

                  final request = nearbyRequests[index];
                  if (!isWithinRange(request["distance"])) {
  return const SizedBox();
}

                  return Card(
                    color: cardColors[index],
                    margin: const EdgeInsets.only(bottom: 15),
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(request["name"]),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(request["request"]),
                          Text("Distance: ${request["distance"]}"),
                          Text(request["time"]),
                        ],
                      ),

                      trailing: request["accepted"]
                          ? ElevatedButton(
                              onPressed: () {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                      userName: request["name"],
                                    ),
                                  ),
                                );

                              },
                              child: const Text("Chat"),
                            )
                          : ElevatedButton(
                              onPressed: () => acceptRequest(index),
                              child: const Text("Accept"),
                            ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.onRaiseRequest,
                child: const Text("Raise Request"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  final TextEditingController amountController = TextEditingController();
  String denomination = "10";
  String? submittedRequest;

  void submitRequest() {
    setState(() {
      submittedRequest =
          "Request: ₹${amountController.text} change (₹$denomination notes)";
    });

    amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Raise Request")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount Needed",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField(
              value: denomination,
              decoration: const InputDecoration(
                labelText: "Denomination",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: "10", child: Text("₹10")),
                DropdownMenuItem(value: "20", child: Text("₹20")),
                DropdownMenuItem(value: "50", child: Text("₹50")),
                DropdownMenuItem(value: "100", child: Text("₹100")),
              ],
              onChanged: (value) {
                setState(() {
                  denomination = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: submitRequest,
              child: const Text("Submit Request"),
            ),

            const SizedBox(height: 30),

            if (submittedRequest != null)
              Card(
                elevation: 4,
                child: ListTile(
                  leading: const Icon(Icons.currency_exchange),
                  title: Text(submittedRequest!),
                  subtitle:
                      const Text("Visible to nearby users (demo within 1 km)"),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  String userName = "Guest User";

  File? profileImage;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        profileImage = File(image.path);
      });
    }
  }

  void showImageOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text("Take Photo"),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Choose from Gallery"),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  void saveName() {
    setState(() {
      userName = nameController.text;
    });

    nameController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Name Updated")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: showImageOptions,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.deepPurple.shade100,
                backgroundImage:
                    profileImage != null ? FileImage(profileImage!) : null,
                child: profileImage == null
                    ? const Icon(Icons.camera_alt, size: 40)
                    : null,
              ),
            ),

            const SizedBox(height: 10),
            const Text("Tap image to change profile photo"),

            const SizedBox(height: 20),

            Text(
              userName,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Enter new name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveName,
              child: const Text("Save Name"),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;
  bool notifications = true;

  void showInfo(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            )
          ],
        );
      },
    );
  }

  void logout() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Logged out (demo only)")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [

          SwitchListTile(
            title: const Text("Dark Mode"),
            subtitle: const Text("Enable dark theme"),
            value: darkMode,
            onChanged: (value) {
              setState(() {
                darkMode = value;
              });
            },
            secondary: const Icon(Icons.dark_mode),
          ),

          SwitchListTile(
            title: const Text("Notification Preferences"),
            subtitle: const Text("Enable or disable notifications"),
            value: notifications,
            onChanged: (value) {
              setState(() {
                notifications = value;
              });
            },
            secondary: const Icon(Icons.notifications),
          ),

          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text("Need Help?"),
            onTap: () {
              showInfo(
                "Help",
                "For help, contact support@nearcash.demo\nThis is a demo help page.",
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.description),
            title: const Text("Terms & Conditions"),
            onTap: () {
              showInfo(
                "Terms & Conditions",
                "This is a demo project. No real transactions occur.\nAll requests are simulated for demonstration.",
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About Us"),
            onTap: () {
              showInfo(
                "About NearCash",
                "NearCash is a demo app that helps nearby people exchange cash denominations quickly within a 1 km radius.",
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Log Out"),
            onTap: logout,
          ),
        ],
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {

  final String userName;

  const ChatScreen({super.key, required this.userName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final TextEditingController messageController = TextEditingController();

  List<String> messages = [];

  void sendMessage() {

    if (messageController.text.isEmpty) return;

    setState(() {
      messages.add(messageController.text);
    });

    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
      ),

      body: Column(
        children: [

          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {

                return ListTile(
                  title: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(messages[index]),
                    ),
                  ),
                );
              },
            ),
          ),




                   Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [

                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: "Type message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}