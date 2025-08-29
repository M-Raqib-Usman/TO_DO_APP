import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserProfileScreen extends StatefulWidget {
  final int userId;

  const UserProfileScreen({super.key, required this.userId});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = ApiService().fetchUser(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile', style: TextStyle(color: Color(0xFFF3EDE3))),
        backgroundColor: const Color(0xFF18442A),
      ),
      backgroundColor: const Color(0xFF45644A),
      body: FutureBuilder<User>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFF3EDE3)));
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Color(0xFFF3EDE3)),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF18442A),
                      foregroundColor: const Color(0xFFF3EDE3),
                    ),
                    onPressed: () {
                      setState(() {
                        futureUser = ApiService().fetchUser(widget.userId); // Retry
                      });
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'No user data found',
                style: TextStyle(color: Color(0xFFF3EDE3)),
              ),
            );
          }

          final user = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                ),
                const SizedBox(height: 16),
                Text(
                  user.name,
                  style: const TextStyle(
                    color: Color(0xFFF3EDE3),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Email: ${user.email}', style: const TextStyle(color: Color(0xFFF3EDE3))),
                Text('Phone: ${user.phone}', style: const TextStyle(color: Color(0xFFF3EDE3))),
                Text('Website: ${user.website}', style: const TextStyle(color: Color(0xFFF3EDE3))),
              ],
            ),
          );
        },
      ),
    );
  }
}