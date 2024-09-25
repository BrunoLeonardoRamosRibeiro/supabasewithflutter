import 'package:flutter/material.dart';
import 'package:supabasewithflutter/main.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({super.key});

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create To-do'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Enter Title',
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Enter Description',
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await supabase.from('Todo').insert({
                  'title': titleController.text.trim(),
                  'description': descriptionController.text.trim(),
                }).select();

                print('------- RESULTADO -------');
                print(result.toString());
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
