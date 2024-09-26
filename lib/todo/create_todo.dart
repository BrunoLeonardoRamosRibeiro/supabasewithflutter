import 'package:flutter/material.dart';
import 'package:supabasewithflutter/main.dart';

class CreateTodo extends StatefulWidget {
  final Map<String, dynamic>? todo;
  const CreateTodo({
    super.key,
    this.todo,
  });

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.todo != null) {
      titleController.text = widget.todo!['title'];
      descriptionController.text = widget.todo!['description'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo != null ? 'Update To-do' : 'Create To-do'),
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
                if (widget.todo != null) {
                  final result = await supabase.from('Todo').update({
                    'title': titleController.text.trim(),
                    'description': descriptionController.text.trim(),
                  }).match({
                    'id': widget.todo!['id'],
                  });

                  print('------- RESULTADO -------');
                  print(result.toString());

                  if (mounted) {
                    Navigator.pop(context, true);
                  }
                } else {
                  try {
                    final result = await supabase.from('Todo').insert({
                      'title': titleController.text.trim(),
                      'description': descriptionController.text.trim(),
                    }).select();

                    print('------- RESULTADO -------');
                    print(result.toString());
                    if (mounted) {
                      Navigator.pop(context, true);
                    }
                  } catch (e) {
                    print(e);
                  }
                }
              },
              child: Text(widget.todo != null ? 'Update' : 'Create'),
            ),
          ],
        ),
      ),
    );
  }
}
