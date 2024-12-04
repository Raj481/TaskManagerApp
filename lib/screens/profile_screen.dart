import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Profile Picture
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://www.example.com/profile_image.jpg'), // You can use a local asset or a URL
              ),
              SizedBox(height: 16),
              // Username
              const Text(
                'Avinash Kumar', // Replace with actual user name
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              // User Email
              const Text(
                'iammravinashkumar@gmail.com', // Replace with actual user email
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              // Edit Profile Button
              ElevatedButton(
                onPressed: () {
                  // Add your onPressed code here
                  print('Edit Profile');
                },
                child: Text('Edit Profile'),
                style: ElevatedButton.styleFrom(
                  //primary: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 16),
              // Log Out Button
              ElevatedButton(
                onPressed: () {
                  // Add your log out functionality here
                  print('Log Out');
                },
                child: Text('Log Out'),
                style: ElevatedButton.styleFrom(
               //   primary: Colors.redAccent,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
