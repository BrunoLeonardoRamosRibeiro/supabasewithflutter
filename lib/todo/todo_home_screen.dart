import 'package:flutter/material.dart';
import 'package:supabasewithflutter/main.dart';
import 'package:supabasewithflutter/todo/create_todo.dart';

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({super.key});

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-do'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: supabase.from('Todo').select(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snap.hasError) {
            return const Center(
              child: Text('Ocorreu um ero!'),
            );
          } else if (snap.hasData && snap.data != null) {
            return ListView.builder(
              itemCount: snap.data?.length ?? 0,
              itemBuilder: (_, index) {
                final item = snap.data![index];

                return Card(
                  child: ListTile(
                    title: Text(item['title']),
                    subtitle: Text(item['description']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () async {
                              await supabase.from('Todo').delete().match({
                                'id': item['id'],
                              });
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('Sem dados retornados'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateTodo(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
