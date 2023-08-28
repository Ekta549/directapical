import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_api/userdetailscreen.dart';

abstract class UserDetailScreen extends StatelessWidget {
   final dynamic user;

  const UserDetailScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract user details from the user map
    // ignore: prefer_typing_uninitialized_variables
    var user;
    final name = user['name']['first'];

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user['picture']['large']),
            ),
            const Text('Name: jpoh'),
            const Text('Email: jdnriw@gmail.com'),
            const Text('Phone: 23174879210'),
            const Text('Date of Birth: 11/22/1231'),
          ],
        ),
      ),
    );
  }
}
