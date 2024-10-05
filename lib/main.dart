import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

ThemeData myTheme() {
  // Define color variables for better readability
  const Color primaryColor = Color.fromRGBO(251, 111, 146, 1);
  const Color secondaryColor = Color.fromRGBO(255, 143, 171, 1);
  const Color backgroundColor = Color.fromRGBO(255, 229, 236, 1);
  const Color surfaceColor = Color.fromRGBO(255, 179, 198, 1);
  const Color textColorOnPrimary = Colors.black;

  return ThemeData(
    colorScheme: ColorScheme(
      primary: primaryColor, // Main App Bar Color
      secondary: secondaryColor, // Accent/Highlight color
      background: backgroundColor, // Background color
      surface: surfaceColor, // Button color
      error: Colors.red,
      onPrimary: textColorOnPrimary, // Text color on primary
      onSecondary: textColorOnPrimary, // Text color on secondary
      onBackground: textColorOnPrimary, // Text color on background
      onSurface: textColorOnPrimary, // Text color on surface
      onError: Colors.white,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: backgroundColor, // App background color
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 18), // Larger button text
        padding: const EdgeInsets.symmetric(
            vertical: 15, horizontal: 25), // Larger button padding
        backgroundColor: surfaceColor, // Default button background
      ),
    ),
    textTheme: const TextTheme(
      headlineMedium:
          TextStyle(fontSize: 36, color: Colors.black), // Larger display text
      bodyMedium: TextStyle(fontSize: 24), // General larger text
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor, // Primary color for the AppBar
      titleTextStyle: const TextStyle(
          fontSize: 24, color: textColorOnPrimary), // AppBar text style
    ),
    checkboxTheme: checkboxTheme: CheckboxThemeData(
  fillColor: MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.selected)) {
      return Colors.white; // Color when selected
    }
    return Colors.white; // Color when not selected
  }),
  checkColor: MaterialStateProperty.all(Colors.black),
  side: MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.selected)) {
      return const BorderSide(color: Colors.black, width: 2); // Consistent border when selected
    }
    return const BorderSide(color: Colors.black, width: 2); // Consistent border when not selected
  }),
),
    iconTheme: IconThemeData(
      color: secondaryColor, // Icon color (used for delete button)
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: secondaryColor),
      ),
      labelStyle: TextStyle(color: primaryColor),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: primaryColor),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: myTheme(),
      home: const MyHomePage(title: 'Flutter To-Do List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _toDoList = [];

  void _addToDoItem() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        _toDoList.add({
          'task': _controller.text,
          'completed': false,
        });
        _controller.clear();
      }
    });
  }

  void _toggleTaskCompleted(int index) {
    setState(() {
      _toDoList[index]['completed'] = !_toDoList[index]['completed'];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter a task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(
                    width: 10), // Spacing between TextField and button
                ElevatedButton(
                  onPressed: _addToDoItem,
                  child: const Text('Add Task'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _toDoList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      leading: Checkbox(
                        value: _toDoList[index]['completed'],
                        onChanged: (bool? value) {
                          _toggleTaskCompleted(index);
                        },
                      ),
                      title: Text(
                        _toDoList[index]['task'],
                        style: TextStyle(
                          decoration: _toDoList[index]['completed']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () => _deleteTask(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
