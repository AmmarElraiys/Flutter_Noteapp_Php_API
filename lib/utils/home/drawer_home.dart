import 'package:flutter/material.dart';
import 'package:notes_app_php/main.dart';

class DrawerHome extends StatefulWidget {
  const DrawerHome({super.key});

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  String? username = sharedPreferences!.getString('username');
  String? email = sharedPreferences!.getString('email');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.asset(
                      "assets/images/boy.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ListTile(
                    title: Text(username!),
                    subtitle: Text(email!),
                  ),
                ),
              ],
            ),
            const Divider(),
            const ListTile(title: Text("Home"), trailing: Icon(Icons.home)),
            const ListTile(
              title: Text("Language"),
              trailing: Icon(Icons.language),
            ),
            const ListTile(
              title: Text("Settings"),
              trailing: Icon(Icons.settings),
            ),
            ListTile(
              title: const Text("Sign Out"),
              trailing: const Icon(Icons.exit_to_app),
              onTap: () {
                // Sign out işlemleri burada yapılabilir
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text("Sign Out"),
                        content: const Text(
                          "Are you sure you want to sign out?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              sharedPreferences!.clear();
                              Navigator.of(
                                context,
                              ).pushNamedAndRemoveUntil("/", (route) => false);
                            },
                            child: const Text("Yes"),
                          ),
                        ],
                      ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
