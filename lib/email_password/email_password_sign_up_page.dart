import 'package:flutter/material.dart';

class EmailPasswordSignUpPage extends StatefulWidget {
  const EmailPasswordSignUpPage({super.key});

  @override
  State<EmailPasswordSignUpPage> createState() => _EmailPasswordSignUpPageState();
}

class _EmailPasswordSignUpPageState extends State<EmailPasswordSignUpPage> {
  String uId = '';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(uId),
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              hintText: 'Enter email',
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              hintText: 'Enter email',
            ),
          ),
        ],
      ),
    );
  }
}
