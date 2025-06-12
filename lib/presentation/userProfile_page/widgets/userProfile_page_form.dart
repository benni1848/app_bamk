import 'package:flutter/material.dart';

class UserprofileForm extends StatefulWidget {
  const UserprofileForm({super.key});

  @override
  State<UserprofileForm> createState() => _UserprofileFormState();
}

class _UserprofileFormState extends State<UserprofileForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.network("https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png"),
        ],
      )
    );
  }
}