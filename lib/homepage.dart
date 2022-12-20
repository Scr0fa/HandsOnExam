import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'update_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomeState();
}

class _HomeState extends State<Homepage> {
  List items = [];

  @override
  void initState() {
    super.initState();
    getTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit'),
        ),
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: ((context, index) {
              final item = items[index] as Map;
              return Card(
                child: ListTile(
                  leading: SizedBox(
                    height: 50,
                    child: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                  ),
                  title: Text(item['title']),
                  subtitle: Text(item['body']),
                  trailing: PopupMenuButton(
                      onSelected: (value) {
                        updateTodo(item);
                        if (value == 'edit') {
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                      ]),
                ),
              );
            })));
  }

  Future<void> getTodo() async {
    final url = 'https://jsonplaceholder.typicode.com/posts';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final json = convert.jsonDecode(response.body) as List;

    setState(() {
      items = json;
    });
  }

  Future<void> updateTodo(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => updatePage(todo: item, items: '',),
    );
    await Navigator.push(context, route);
    getTodo();
  }
}
