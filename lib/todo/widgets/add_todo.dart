import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lists/controller.dart';
import 'package:lists/todo/todo.controller.dart';
import 'package:lists/todo/todo.model.dart';
import 'package:lists/widgets/responsive.dart';

class AddTodo extends StatefulWidget {
  AddTodo({Key key}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final TextEditingController titleController = TextEditingController();
  final Controller c = Get.put(Controller());

  Todo todo;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return buildFloatingRow(c, screenSize, context);
  }

  Row buildFloatingRow(Controller c, Size screenSize, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
          ),
          child: Center(
            child: buildTextField(),
          ),
          height: 64,
          width: getFloatingWidth(context, screenSize),
          margin: EdgeInsets.only(left: 24, top: 4),
        ),
        Obx(
          () => TodoController.to.isAddingTodo.value
              ? Container(
                  child: Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.green,
                  )),
                )
              : Container(),
        )
      ],
    );
  }

  Widget buildTextField() {
    return TextField(
        autofocus: true,
        controller: titleController,
        onEditingComplete: () => print('hasjdfhjsdhfk'),
        onSubmitted: _handleSubmit,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black45,
            hoverColor: Colors.black,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(16.0),
              ),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                EdgeInsets.only(left: 24, bottom: 18, top: 16, right: 15),
            hintText: 'Add your Task here',
            hintStyle: GoogleFonts.muli()));
  }

  void _handleSubmit(val) {
    if (titleController.text != "") {
      if (todo != null) {
        todo.title = titleController.text;
        TodoController.to.updateTodo(todo);
        titleController.clear();
      } else {
        TodoController.to.addTodo(titleController.text);
        titleController.clear();
      }
    }
  }

  getFloatingWidth(context, Size screenSize) {
    if (ResponsiveWidget.isLargeScreen(context)) {
      return screenSize.width * 0.5;
    }

    if (ResponsiveWidget.isMediumScreen(context)) {
      return screenSize.width * 0.7;
    }

    return screenSize.width * 0.8;
  }
}
