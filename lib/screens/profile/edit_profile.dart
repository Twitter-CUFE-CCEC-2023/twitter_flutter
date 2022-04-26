import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:twitter_flutter/blocs/EditProfileStates/editprofile_states.dart';
import 'package:twitter_flutter/blocs/EditProfileStates/editprofile_events.dart';
import 'package:twitter_flutter/blocs/EditProfileStates/editprofile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfile extends StatefulWidget {
  static String route = '/EditProfile';
  String name;
  String bio;
  String location;
  String website;
  DateTime birth_date;
  EditProfile(
      {Key? key,
      required this.name,
      required this.website,
      required this.birth_date,
      required this.location,
      required this.bio})
      : super(key: key);
  @override
  editprofile createState() => editprofile();
}

class editprofile extends State<EditProfile> {
  late String name;
  late TextEditingController _namefield,
      _datefield,
      _biofield,
      _locationfield,
      _websitefield;
  late DateTime birth_date;
  late String bio;
  late String location;
  late String website;
  bool nextActive = false;

  @override
  void initState() {
    name = widget.name;
    birth_date = widget.birth_date;
    bio = widget.bio;
    location = widget.location;
    website = widget.website;

    super.initState();
    _namefield = TextEditingController();
    _namefield.addListener(() {
      setState(() {
        nextActive = DisableButton();
      });
    });
    _biofield = TextEditingController();
    _websitefield = TextEditingController();
    _locationfield = TextEditingController();
    _datefield = TextEditingController();

    _namefield.text = name;
    _biofield.text = bio;
    _locationfield.text = location;
    _datefield.text = birth_date.toIso8601String();
    _websitefield.text = website;
  }

  bool DisableButton() {
    if (_namefield.text.isEmpty) {
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

  Widget textfieldController(
      {required int lines,
        required String message,
        required String message2,
        required double width,
        required TextEditingController controller,
        required double fontSizeMultiplier,}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
      child: SizedBox(
          width: width,
          child: TextFormField(
            key: Key(name),
            enabled: true,
            controller: controller,
            keyboardType: TextInputType.text,
            maxLines: lines,
            decoration: InputDecoration(
              labelText: message,
              hintText: message2,
              hintStyle: textStyle(fontSizeMultiplier),
            ),
          )),
    );
  }

  Widget textfield({
    required String message,
    required double width,
    required int lines,
    required double fontSizeMultiplier,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
      child: SizedBox(
          width: width,
          child: TextFormField(
            maxLines: lines,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: message),
          )),
    );
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
        imageMultiplier[0] = 1;
        fontSizeMultiplier[0] = 1;
      } else {
        sizedBoxHeightMultiplier[0] = .1;
        imageMultiplier[0] = 1.8;
        fontSizeMultiplier[0] = 2;
      }

      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              BlocListener<EditProfileBloc, EditProfileStates>(
                listenWhen: (previous, current) =>
                    current is EditProfileSuccessState ||
                    current is EditProfileFailureState,
                listener: (context, state) {
                  if (state is EditProfileSuccessState) {
                    try {
                      Navigator.pushNamedAndRemoveUntil(context, '/HomePage',
                          (Route<dynamic> route) => false);
                    } on Exception catch (e) {
                      context.read<EditProfileBloc>().add(StartEvent());
                    }
                  } else if (state is EditProfileFailureState) {}
                },
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    onSurface: Colors.grey, // Disable color
                  ),
                  onPressed: nextActive
                      ? () {
                          context.read<EditProfileBloc>().add(
                              EditProfileButtonPressed(
                                  birth_date: birth_date.toIso8601String(),
                                  name: _namefield.text,
                                  website: _websitefield.text,
                                  bio: _biofield.text,
                                  location: _locationfield.text,
                                  month_day_access:
                                      '2', //data['month_day_access'].toString(),
                                  year_access:
                                      '1')); //data['year_access'].toString()));
                        }
                      : null,
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 0.0192 * fontSizeMultiplier[0] * screenHeight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
                    fontSize: 0.0232 * fontSizeMultiplier[0] * screenHeight,
                  ),
                ),
              ),
            ),
          ),
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
                    IcoButton(
                        width: screenWidth,
                        size: 35,
                        left: 0,
                        top: 0,
                        right: 0,
                        bottom: 0,
                        height: screenHeight * 0.16)
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(0, screenHeight * 0.16 - 53, 0, 0),
                  child: Container(
                    //      color: Colors.white,
                    padding: const EdgeInsets.all(8),
                    child: const CircleAvatar(
                      backgroundImage: null,
                      radius: 45,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(5, screenHeight * 0.16 - 48, 0, 0),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: CircleAvatar(
                      backgroundImage:null,
                      radius: 40,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 2, 10),
                        child: IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.white70,
                            size: screenHeight * 0.04 * imageMultiplier[0],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.16 + 40,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _namefield.clear();
                          });
                        },
                        child: textfieldController(
                            lines: 1,
                            fontSizeMultiplier:
                                0.0192 * fontSizeMultiplier[0] * screenHeight,
                            message: 'Name',
                            message2: 'Name cannot be blank',
                            controller: _namefield,
                            width: screenWidth - 50),
                      ),
                      textfield(
                        fontSizeMultiplier:
                            0.0192 * fontSizeMultiplier[0] * screenHeight,
                        message: 'Bio',
                        width: screenWidth - 50,
                        lines: 3,
                      ),
                      textfield(
                          fontSizeMultiplier:
                              0.0192 * fontSizeMultiplier[0] * screenHeight,
                          message: ('Location'),
                          width: screenWidth - 50,
                          lines: 1),
                      textfield(
                          fontSizeMultiplier:
                              0.0192 * fontSizeMultiplier[0] * screenHeight,
                          message: ('Website'),
                          width: screenWidth - 50,
                          lines: 1),
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
                                    currentTime: widget.birth_date,
                                    onConfirm: (date) {
                                  _datefield.text =
                                      '${date.year}-${date.month}-${date.day}';
                                  birth_date = date;
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
  }
}
