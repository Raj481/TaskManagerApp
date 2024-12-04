import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            subtitle: const Text('Manage notification preferences'),
            onTap: () {
              // Handle Notifications Setting
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications tapped')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Privacy'),
            subtitle: const Text('Manage privacy settings'),
            onTap: () {
              // Handle Privacy Setting
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Privacy tapped')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            subtitle: const Text('Change app language'),
            onTap: () {
              // Handle Language Setting
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Language tapped')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help & Support'),
            subtitle: const Text('Get help or contact support'),
            onTap: () {
              // Handle Help & Support Setting
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Help & Support tapped')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Log Out', style: TextStyle(color: Colors.red)),
            onTap: () {
              // Handle Log Out
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Log Out tapped')),
              );
            },
          ),
        ],
      ),
    );
  }
}