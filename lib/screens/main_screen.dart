import 'package:flutter/material.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_text_styles.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/widgets/search_widget.dart';
import 'package:todo/widgets/todo_item_widget.dart';

class MyMainScreen extends StatefulWidget {
  MyMainScreen({super.key});

  @override
  State<MyMainScreen> createState() => _MyMainScreenState();
}

class _MyMainScreenState extends State<MyMainScreen> {
  final todoList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  var todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todoList;
    super.initState();
  }

  void check(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void deleteToDoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void filterItens(String text) {
    List<ToDo> results = [];
    if (text.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) =>
              item.todoText!.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  void addToDoItem(String toDo) {
    setState(() {
      todoList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
      todoController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.peopleLight,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.people,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.menu,
              color: AppColors.peopleDark,
              size: 30,
            ),
            SizedBox(
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                    'https://secure.gravatar.com/avatar/131ea35cab81aa12674b2b3358734e21?s=160&d=mm&r=g'),
              ),
            )
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          children: [
            SearchInput(
              onChange: filterItens,
            ),
            Expanded(
              flex: 1,
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    child: const Text(
                      'All toDos',
                      style: AppTextStyles.titleStyle,
                    ),
                  ),
                  if (_foundToDo.isNotEmpty)
                    for (ToDo todoItem in _foundToDo.reversed)
                      ToDoItem(
                        todo: todoItem,
                        onDeleteItem: () {
                          deleteToDoItem(todoItem.id!);
                        },
                        onToDoChange: check,
                      )
                  else
                    const Center(
                      child: Text(
                        "Not have To Dos",
                        style: AppTextStyles.normalText,
                      ),
                    )
                ],
              ),
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                          bottom: 20,
                          right: 5,
                          left: 5,
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: todoController,
                          decoration: const InputDecoration(
                            hintText: 'A new To Do',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.red,
                      ),
                      margin: const EdgeInsets.only(right: 10, bottom: 15),
                      child: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          addToDoItem(todoController.text);
                        },
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
