import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Enter Email',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'Enter Password',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await Supabase.instance.client.auth.signUp(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                );

                setState(() {
                  uId = result.user?.id ?? '';
                });
              },
              child: const Text('Sign UP'),
            ),
          ],
        ),
      ),
    );
  }
}
