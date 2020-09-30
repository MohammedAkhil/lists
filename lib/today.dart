import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lists/controller.dart';
import 'package:lists/todo/widgets/list_todo.dart';
import 'package:lists/widgets/responsive.dart';

class Today extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    final Controller c = Get.put(Controller());

    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(0.0),
          child: buildFloatingRow(c, screenSize, context),
        ),
        body: Obx(() => Stack(
              children: [
                Container(
                  decoration: buildBackground(c.background.value),
                  height: screenSize.height,
                  width: screenSize.width,
                  child: Center(
                    child: Container(
                      height: screenSize.height,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(32.0, 24, 8, 40),
                            child: buildHeaderText(),
                          ),
                          TodoList()
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 24,
                  right: 24,
                  child: buildFloatingActionButton(c),
                ),
              ],
            )));
  }

  Text buildHeaderText() {
    return Text(
      getToday(),
      style: GoogleFonts.muli(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 3,
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton(Controller c) {
    return FloatingActionButton(
      mini: true,
      backgroundColor: Colors.black45,
      tooltip: 'Change Background',
      onPressed: null,
      child: IconButton(
        icon: Icon(Icons.image),
        onPressed: () => c.changeBackground(),
      ),
    );
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
            child: TextField(
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.add_circle),
                    filled: true,
                    fillColor: Colors.black45,
                    hoverColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(16.0),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.only(
                        left: 24, bottom: 18, top: 16, right: 15),
                    hintText: 'Add your Task here',
                    hintStyle: GoogleFonts.muli())),
          ),
          height: 64,
          width: getFloatingWidth(context, screenSize),
          margin: EdgeInsets.only(left: 24, top: 4),
        )
      ],
    );
  }

  getWidth(context, Size screenSize) {
    if (ResponsiveWidget.isLargeScreen(context)) {
      return screenSize.width * 0.5;
    }

    if (ResponsiveWidget.isMediumScreen(context)) {
      return screenSize.width * 0.8;
    }

    return screenSize.width;
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

  BoxDecoration buildBackground(String background) {
    return BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        colorFilter: new ColorFilter.mode(
            Colors.black.withOpacity(0.5), BlendMode.softLight),
        image: AssetImage(
          background,
        ),
      ),
    );
  }

  String getToday() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('d EEEE, MMMM');
    final String formatted = formatter.format(now).toUpperCase();
    return formatted;
  }
}
