import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:auto_size_text/auto_size_text.dart';

Widget IcoButton(
{required double width,
  required double size,
  required double left,
  required double top,
  required double right,
  required double bottom,
  required double height,
}){
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

Widget textfieldController(
    {required String message,
      required String message2,
      required double width,
      required TextEditingController controller}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
    child: SizedBox(
        width: width,
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: message,
            hintText: message2,),
        )),
  );
}
Widget textfield(
    {required String message,
      required double width,
    required int lines}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
    child: SizedBox(
        width: width,
        child: TextFormField(
          maxLines: lines,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: message),
        )),
  );
}

class EditProfile extends StatefulWidget {
  static String route = '/EditProfile';

  const EditProfile({Key? key}) : super(key: key);
  editprofile createState() => editprofile();
}

class editprofile extends State<EditProfile> {
  late TextEditingController _namefield, _datefield;
  bool nextActive = false;

  @override
  void initState() {
    super.initState();
    _namefield = TextEditingController();
    _namefield.addListener(() {
      setState(() {
        nextActive = DisableButton();
      });
    });

    _datefield = TextEditingController();
    _datefield.addListener(() {});

  }

  bool DisableButton() {
    if (_namefield.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final List<double> sizedBoxHeightMultiplier = [1, 1, 1, 1];
    final List<double> imageMultiplier = [1, 1];
    double borderRadiusMultiplier = 1;
    final List<double> fontSizeMultiplier = [1, 1, 1, 1];
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        sizedBoxHeightMultiplier[0] = 1;
        sizedBoxHeightMultiplier[1] = 1;
        sizedBoxHeightMultiplier[2] = 1;
        imageMultiplier[0] = 1;
        imageMultiplier[1] = 1;
        borderRadiusMultiplier = 1;
        fontSizeMultiplier[0] = 1;
        fontSizeMultiplier[1] = 1;
        fontSizeMultiplier[2] = 1;
        fontSizeMultiplier[3] = 1;
      } else {
        sizedBoxHeightMultiplier[0] = .1;
        sizedBoxHeightMultiplier[1] = .33;
        sizedBoxHeightMultiplier[2] = 1;
        sizedBoxHeightMultiplier[3] = 1.8;
        imageMultiplier[0] = 1.8;
        imageMultiplier[1] = 1.8;
        borderRadiusMultiplier = 1.4;
        fontSizeMultiplier[0] = 2;
        fontSizeMultiplier[1] = 2;
        fontSizeMultiplier[2] = 2;
        fontSizeMultiplier[3] = 2;
      }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
                onSurface: Colors.grey, // Disable color
              ),
              onPressed: nextActive?() {}:null,
              child: Text('Save',style: TextStyle(fontSize:0.0192 * fontSizeMultiplier[0] * screenHeight,
                fontWeight: FontWeight.bold,
              ),),
            ),
          ],
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context, false)),
          backgroundColor: Colors.white,
          title: SizedBox.fromSize(
            child: Align(
              alignment: Alignment.centerLeft,
    child: Text(
              'Edit Profile',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 0.0232 * fontSizeMultiplier[0]* screenHeight,
              ),
            ),
          ),
        ),),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                height: 600,
                width: 0,
              ),
              Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IcoButton(width: screenWidth, size: 35, left: 0, top: 0, right: 0, bottom: 0,height: screenHeight*0.16)

                ],
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, screenHeight*0.16-53,0, 0),
                child: Container(
                  //      color: Colors.white,
                  padding:const EdgeInsets.all(8),
                  child: const CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
          Padding(padding: EdgeInsets.fromLTRB(5, screenHeight*0.16-48,0, 0),

                child:  Container(
                  padding: EdgeInsets.all(8),
                  child: CircleAvatar(
                    radius: 40,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 5, 10),
                      child:IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.add_a_photo,
                      color: Colors.white70,
                      size: screenHeight* 0.04* imageMultiplier[0]
                      ,
                    ),
                  ),
                ),
              ),),
              ),
              Positioned(
                top: screenHeight*0.16+40,
                child: Column(
                  children: <Widget>[

                    textfieldController(message: 'Name', message2: 'Name cannot be blank', controller: _namefield, width: screenWidth - 50),


                    textfield(message: 'Bio', width: screenWidth - 50,lines:3),
                    textfield(message: ('Location'), width: screenWidth - 50,lines:1),
                    textfield(message: 'Website', width: screenWidth - 50,lines:1),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                      child: SizedBox(
                          width: screenWidth - 50,
                          child: TextField(
                            controller: _datefield,
                            readOnly: true,
                            onTap: () {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(1950, 1, 1),
                                  maxTime: DateTime.now(),
                                  currentTime: DateTime.now(),
                                  onConfirm: (date) {
                                _datefield.text =
                                    '${date.year}-${date.month}-${date.day}';
                              }, locale: LocaleType.en);
                            },
                            decoration: const InputDecoration(
                              hintText: "Date of birth",
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    //);
  });
}}
