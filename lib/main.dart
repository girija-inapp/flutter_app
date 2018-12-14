import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

final ThemeData _themeData = new ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.orange,
    accentColor: Colors.brown);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _themeData,
      home: new Screen1(
        todos: List.generate(
          20,
          (i) => Todo(
                'Todo $i',
                'A description of what needs to be done for Todo $i',
              ),
        ),
      ),
      routes: <String, WidgetBuilder>{
        '/screen1': (BuildContext context) => new Screen1(),
        '/screen2': (BuildContext context) => new Screen2()
      },
    );
  }
}

class Todo {
  final String title;
  final String description;
  Todo(this.title, this.description);
}

void button1(BuildContext context) {
  print("Button 1"); //1
  Navigator.of(context).pushNamed('/screen2'); //2
}

void button2(BuildContext context) {
  print("Button 2"); //3
  Navigator.of(context).pop(true); //4
}

class Screen1 extends StatelessWidget {
  final List<Todo> todos;
  Screen1({Key key, @required this.todos}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // 1
      appBar: new AppBar(
        //2
        title: new Text("Screen 1"),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => new Screen2(todo: todos[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  final Todo todo;
  // In the constructor, require a Todo
  Screen2({Key key, @required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Theme(
        data: _themeData.copyWith(
          primaryColor: Colors.teal
        ),
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text("Screen 2"),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('${todo.description}'),
          ),
        ));
  }
}
