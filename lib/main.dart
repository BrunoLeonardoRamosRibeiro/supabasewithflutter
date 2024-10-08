import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:supabasewithflutter/email_password/email_password_sign_up_page.dart';
// import 'package:supabasewithflutter/google_sign_in/google_sign_in.dart';
import 'package:supabasewithflutter/todo/todo_home_screen.dart';
import 'package:supabasewithflutter/upload_image/upload_image.dart';

final supabase = Supabase.instance.client;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://otdqqblztjoeojnjxrfr.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im90ZHFxYmx6dGpvZW9qbmp4cmZyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjcwODQ2NTEsImV4cCI6MjA0MjY2MDY1MX0.xbYSxEzjT2ePz8NTr2dJnJxuAzr5t7bPUy16fnxj0ys',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UploadImage(),
    );
  }
}
