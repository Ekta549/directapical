import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore: unused_import
import 'userdetailscreen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    // Call your API here
    fetchDataFromApi();
  }

  Future<void> fetchDataFromApi() async {
    final response =
        await http.get(Uri.parse('https://randomuser.me/api/?results=10'));

    if (response.statusCode == 200) {
      setState(() {
        
        users = json.decode(response.body)['results'];
      });
    } else {
      // Handle error scenario
    }
  }

  void navigateToUserDetailScreen(dynamic user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetailScreen(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Rest API Call'),
        ),
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final name = user['name']['first'];
            final email = user['email'];
            final imageUrl = user['picture']['thumbnail'];
            return ListTile(
              onTap: () =>
                  navigateToUserDetailScreen(user), // Navigate to detail screen
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(imageUrl),
              ),
              title: Text(name),
              subtitle: Text(email),
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_page),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.recent_actors),
            label: 'Recent',
          )
        ]));
  }
}

class UserDetailScreen extends StatelessWidget {
  final dynamic user;

  const UserDetailScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = user['name']['first'];
    final email = user['email'];
    final phone = user['phone'];
    final dob = user['dob']['date'];
    

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user['picture']['large']),
              radius: 75, // Adjust the radius value as needed
            ),
            const SizedBox(height: 16),
            Text('Name: $name'),
            Text('Email: $email'),
            Text('Phone: $phone'),
            Text('Date of Birth: $dob'),
          ],
        ),
      ),
    );
  }
}