import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';

class UserName extends StatefulWidget {
  static String route = '/UserName';
  String user_name;
  UserName({Key? key, required this.user_name}) : super(key: key);
  @override
  username createState() => username();
}

class username extends State<UserName> {
  late TextEditingController _usernamefield;
  late String user_name;
  bool nextActive = false;

  @override
  void initState() {
    user_name = widget.user_name;

    super.initState();
    _usernamefield = TextEditingController();
    _usernamefield.addListener(() {
      setState(() {
        nextActive = DisableButton();
      });
    });

    _usernamefield.text = user_name;
  }

  bool DisableButton() {
    if (_usernamefield.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Widget IcoButton({
    required double width,
    required double size,
    required double left,
    required double top,
    required double right,
    required double bottom,
    required double height,
  }) {
    return Container(
      color: Colors.blueAccent,
      height: height,
      width: width,
      child: Padding(
        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
        child: IconButton(
          onPressed: null,
          icon: Icon(
            Icons.add_a_photo,
            color: Colors.white70,
            size: size,
          ),
        ),
      ),
    );
  }

  Widget Message(
      {required String message,
      required double fontSize,
      required Color colors}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35), // 35
      child: AutoSizeText(
        message,
        style: TextStyle(fontSize: fontSize, color: colors),
        maxLines: 2,
      ),
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
    required String message,
    required String message2,
    required double width,
    required TextEditingController controller,
    required double fontSizeMultiplier,
    required double font
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: SizedBox(
          width: width,
          child: TextFormField(
            style: TextStyle(fontSize: font),
            key: Key(user_name),
            enabled: true,
            controller: controller,
            keyboardType: TextInputType.text,
            maxLines: lines,
            decoration: InputDecoration(
              prefixText: '@',
              labelText: message,
              hintText: message2,
              hintStyle: textStyle(fontSizeMultiplier),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final List<double> fontSizeMultiplier = [1, 1, 1, 1];
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        fontSizeMultiplier[0] = 1;
      } else {
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
            title: SizedBox.fromSize(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Change username',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 0.0252 * fontSizeMultiplier[0] * screenHeight,
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          bottomNavigationBar: ButtonBar(

            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5000),
                child: SizedBox(
                  width: 75,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: nextActive
                        ? () {} : null,

                    child:  Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 0.0232 * fontSizeMultiplier[0] * screenHeight,
                      ),
                    ),
                ),
              ),
              )],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: Text('  Current',
                      style: TextStyle(fontSize: 0.0212 * fontSizeMultiplier[0] * screenHeight, color: Colors.grey)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 10),
                  child: Text('  ' + widget.user_name.toString(),
                      style: TextStyle(
                          fontSize: 0.0242 * fontSizeMultiplier[0] * screenHeight,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold)),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _usernamefield.clear();
                    });
                  },
                  child: textfieldController(
                    font: 0.0242 * fontSizeMultiplier[0] * screenHeight,
                      lines: 1,
                      fontSizeMultiplier:
                          0.0192 * fontSizeMultiplier[0] * screenHeight,
                      message: 'New',
                      message2: 'Name cannot be blank',
                      controller: _usernamefield,
                      width: screenWidth-20),
                ),
              ],
            ),
          ),
        ),
      );
      //);
    });
  }
}
