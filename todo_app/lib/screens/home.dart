import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../widgets/todo_item.dart';
import '../screens/drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();
  int checker = 0;

  @override
  void initState() {
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      endDrawer: const AppDrawer(),
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white70,
      body: Stack(
        children: [
          _centerContainer(),
          _bottomContainer(),
        ],
      )  
    );
  }

  Align _bottomContainer() {
    return Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              Expanded(
                child: _addTaskTextBox(),
              ),
              _addTaskButton(),
            ],
          ),
        );
  }

  Container _centerContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        children: [
          _searchbox(),
          _todoText(),
          _todoNotes(),
        ],
      ),  
    );
  }

  Expanded _todoNotes() {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [
          for (ToDo obj in _foundToDo.reversed)
            ToDoItem(
              todo: obj, 
              onToDoChange: _handleToDoChange,
              OnDeleteItem: _handleDelete,
            ),
        ],
      )
    );
  }

  //Switches Todo Item
  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  //Deletes Item
  void _handleDelete(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  // Adds None Empty New to-do
  void _addToDoItem(String toDo) {
    for (ToDo item in _foundToDo) {
      if (item.todoText?.toLowerCase() == toDo.toLowerCase()) {
        checker = 1;
      }
    }

    if (toDo.isNotEmpty && checker == 0) {
      setState(() {
        todoList.add(ToDo(id: DateTime.now().microsecondsSinceEpoch, todoText: toDo));
      });
      _todoController.clear();
    }

    checker = 0;
  }

  // Search Box Functionality
  void _runFilter(String enterKeyword) {
    List<ToDo> results = [];
    if (enterKeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList.where((item) => item.todoText!.toLowerCase().contains(enterKeyword.toLowerCase())).toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  // "TO DO: "
  Container _todoText() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 15, bottom: 15),
      child: const Text(
        'To-Do:',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Bottom Text Box
  Container _addTaskTextBox() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 0),
            blurRadius: 10.0,
            spreadRadius: 0.0,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _todoController,
        decoration: const InputDecoration(
          hintText: 'Add a new todo item',
          border: InputBorder.none,
        ),
      ),
    );
  }

  // Bottom Right Button
  Container _addTaskButton() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
        right: 20,
      ),
      child: ElevatedButton(
        onPressed: () {
          _addToDoItem(_todoController.text);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5F52EE),
          minimumSize: const Size(60, 60),
          elevation: 10,
        ),
        child: const Text(
          '+',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }

  //Search Box
  Container _searchbox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFF3A3A3A),
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Color(0xFF717171)),
        ),
      ),
    );
  }

  //Top Part of the App
  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/x.jpg'),
              )),
        ],
      ),
    );
  }
}
