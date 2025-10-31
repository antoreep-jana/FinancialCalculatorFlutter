import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.person, color: Colors.blue),
              title: const Text("Edit Profile"),
              subtitle: const Text("Change your profile details"),
              onTap: () {
                // Navigate to the edit profile page or show a dialog
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.notifications, color: Colors.blue),
              title: const Text("Notifications"),
              subtitle: const Text("Manage notification preferences"),
              onTap: () {
                // Navigate to notifications settings
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.blue),
              title: const Text("Privacy Settings"),
              subtitle: const Text("Manage your privacy settings"),
              onTap: () {
                // Navigate to privacy settings
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.language, color: Colors.blue),
              title: const Text("Language"),
              subtitle: const Text("Change your language preference"),
              onTap: () {
                // Navigate to language settings
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
              title: const Text("Logout"),
              subtitle: const Text("Sign out of your account"),
              onTap: () {
                // Handle logout logic
              },
            ),
          ],
        ),
      ),
    );
  }
}