import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> colorCards = [
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
    ];

    List<Map<String, dynamic>> data = [
      {
        "title": "Task 1: Todo List App (CRUD)",
        "description": "A simple todo list app with CRUD functionality",
        "color": colorCards[0],
      },
      {
        "title": "Task 2: Autentikasi dengan API dan Token",
        "description": "Implement authentication with API and token",
        "color": colorCards[1],
      },
      {
        "title": "Task 3: Ambil Data dari Public API",
        "description":
            "Fetch data from API https://jsonplaceholder.typicode.com/posts",
        "color": colorCards[2],
      },
      {
        "title": "Task 4: Responsive UI dan Navigasi",
        "description": "Create a responsive UI with navigation",
        "color": colorCards[3],
      },
      {
        "title": "Task 5: Debugging dan Code Review",
        "description": "Debugging and code review of the previous tasks",
        "color": colorCards[4],
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kalanara Group - Flutter Test"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          for (dynamic item in data)
            InkWell(
              onTap: () {
                if (data.indexOf(item) == 0) {
                  Navigator.pushNamed(context, '/todo');
                } else if (data.indexOf(item) == 1) {
                  Navigator.pushNamed(context, '/login_auth');
                } else if (data.indexOf(item) == 2) {
                  Navigator.pushNamed(context, '/post');
                } else if (data.indexOf(item) == 3) {
                  Navigator.pushNamed(context, '/home_product');
                } else if (data.indexOf(item) == 4) {
                  Navigator.pushNamed(context, '/home_debug');
                } else {
                  // Handle other tasks
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Task ${data.indexOf(item) + 1} clicked"),
                    ),
                  );
                }
              },
              borderRadius: BorderRadius.circular(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: item["color"], width: 1.0),
                ),
                child: ListTile(
                  title: Text(item["title"]),
                  subtitle: Text(item["description"]),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
