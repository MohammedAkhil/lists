import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lists/controller.dart';
import 'package:get/get.dart';
import 'package:lists/widgets/responsive.dart';
import 'package:lists/widgets/top_bar_contents.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Controller c = Get.put(Controller());
  double _scrollPosition = 0;
  ScrollController _scrollController;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              backgroundColor: Colors.blueGrey[900].withOpacity(_opacity),
              elevation: 0,
              title: Text(
                'EXPLORE',
                style: GoogleFonts.montserrat(
                  color: Colors.blueGrey[100],
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ),
            )
          : PreferredSize(
              preferredSize: Size(screenSize.width, 1000),
              child: TopBarContents(_opacity),
            ),
      body: SingleChildScrollView(
          controller: _scrollController,
          physics: ClampingScrollPhysics(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Stack(children: [
              Container(
                child: SizedBox(
                  height: screenSize.height * 0.4,
                  width: screenSize.width,
                  child: Image.asset(
                    'assets/images/cover.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(32)),
                    height: screenSize.height * 0.6,
                    width: ResponsiveWidget.isLargeScreen(context)
                        ? screenSize.width * 0.5
                        : screenSize.width * 0.9,
                    margin: EdgeInsets.fromLTRB(
                        32, screenSize.height * 0.3, 32, 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Today's Tasks",
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: ListView(
                            children: [Text('a'), Text('b')],
                          ),
                        ),
                      ],
                    )),
              )
            ])
          ])),
      floatingActionButton: FloatingActionButton(
        onPressed: c.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
