import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SearchPage2 extends StatefulWidget {
  static String route = '/SearchPage2';
  const SearchPage2({Key? key}) : super(key: key);
  @override
  searchpage2 createState() => searchpage2();
}

class searchpage2 extends State<SearchPage2> {
  late TextEditingController _usernamefield;

  @override
  void initState() {
    super.initState();
    _usernamefield = TextEditingController();
  }

  Widget Message(
      {required String message,
      required double fontSize,
      required Color colors}) {
    return AutoSizeText(
      message,
      style: TextStyle(
          fontSize: fontSize, color: colors, fontWeight: FontWeight.bold),
      maxLines: 2,
    );
  }

  TextStyle buttonStyle(double size) {
    return TextStyle(color: Colors.lightBlue, fontSize: size);
  }

  TextStyle textStyle(double size) {
    return TextStyle(color: Colors.black54, fontSize: size);
  }

  Widget textfieldController({
    required int lines,
    required double width,
    required TextEditingController controller,
    required double fontSizeMultiplier,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: SizedBox(
          width: width * 3 / 4,
          height: 34,
          child: TextFormField(
            enabled: true,
            controller: controller,
            keyboardType: TextInputType.text,
            maxLines: lines,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(5),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final List<double> sizedBoxHeightMultiplier = [1, 1, 1, 1];
    final List<double> fontSizeMultiplier = [1, 1, 1, 1];
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        sizedBoxHeightMultiplier[0] = 1;
        fontSizeMultiplier[0] = 1;
      } else {
        sizedBoxHeightMultiplier[0] = .1;
        fontSizeMultiplier[0] = 2;
      }

      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
              elevation: 0.25,
              leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.blue,
                  ),
                  onPressed: () => Navigator.pop(context, false)),
              backgroundColor: Colors.white,
              title: const TextField(

                decoration: InputDecoration(
                  hintText: '   Search Twitter',
                  hintStyle: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: InputBorder.none,
                ),
              )),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              alignment: Alignment.topCenter,
              width: screenWidth,
              height: screenHeight,
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 30, bottom: 20),
                child: Message(
                    message: 'Try searching for people, topics or keywords',
                    fontSize: 0.0181 * fontSizeMultiplier[0] * screenHeight,
                    colors: Colors.black54),
              ),
            ),
          ),
        ),
      );
      //);
    });
  }
}
