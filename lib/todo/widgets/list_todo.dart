import 'package:drag_list/drag_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lists/auth/auth.controller.dart';
import 'package:lists/todo/todo.controller.dart';
import 'package:lists/todo/todo.model.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final AuthController authController = AuthController.to;
  TodoController c = Get.put<TodoController>(TodoController());
  List<Widget> _rows;

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      Widget row = _rows.removeAt(oldIndex);
      _rows.insert(newIndex, row);
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Obx(() {
      if (c.isLoadingTodos.value) {
        return Container(child: Center(child: CircularProgressIndicator()));
      }

      if (c.todos.length == 0) {
        return Center(child: Text('Nothing to do'));
      }

      _rows = buildItems(c.todos.value);
      return buildList(screenSize);
    });
  }

  List<Widget> buildItems(List<Todo> todos) {
    return todos
        .map<Widget>((todo) => buildListItem(todo.title, id: todo.id))
        .toList();
  }

  Widget buildList(screenSize) {
    return ReorderableListView(
      children: _rows,
      onReorder: _onReorder,
    );
  }

  Container buildContainer(List<Todo> todos, Size screenSize) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      height: screenSize.height * 0.8,
      child: DragList<String>(
        items: [],
        handleBuilder: (_) => AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          color: Colors.grey,
          progress: AlwaysStoppedAnimation(0.0),
        ),
        feedbackHandleBuilder: (_, transition) => AnimatedIcon(
          color: Colors.grey.withOpacity(0.1),
          icon: AnimatedIcons.menu_arrow,
          progress: transition,
        ),
        feedbackItemBuilder: (context, item, handle, transition) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.black87,
          ),
          height: 70.0,
          child: buildListItem(item.value, handle: handle),
        ),
        itemExtent: 64.0,
        padding: EdgeInsets.all(24),
        animDuration: Duration(milliseconds: 100),
        itemBuilder: (context, item, handle) {
          return buildListItem(item.value, handle: handle);
        },
      ),
    );
  }
}

Widget buildListItem(String text, {Widget handle, String id}) {
  print('id here /!!!!!!' + id);
  return Container(
    key: ValueKey(0),
    height: 72,
    child: Padding(
      padding: const EdgeInsets.all(0.0),
      child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          color: Colors.black54,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 14,
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.radio_button_unchecked),
                          onPressed: null),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            text.isNotEmpty
                                ? text
                                : 'Almost before we knew it, we had left the ground.',
                            style: GoogleFonts.muli(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '29th July',
                            style: GoogleFonts.muli(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.5),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: handle != null ? handle : Text(''),
                  flex: 1,
                )
              ],
            ),
          )),
    ),
  );
}
