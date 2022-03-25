import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  static String route = '/';
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context, false)),
        backgroundColor: Colors.white,
        title: SizedBox.fromSize(
          child: Text(
            'Edit Profile',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.blueAccent,
                height: 150,
                width: screenWidth,
                child: Icon(
                  Icons.add_a_photo,
                  color: Colors.white70,
                  size: 35,
                ),
              ),
            ],
          ),
          Positioned(
            top: 96,
            right : screenWidth-121,
            //child: ClipRRect(
            // borderRadius: BorderRadius.circular(5000),
            child: Container(
              //      color: Colors.white,
              padding: EdgeInsets.all(8),
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Colors.white,
              ),
            ),
          ),
          //  ),
          // ),
          Positioned(
            top: 100,

            //child: ClipRRect(
             // borderRadius: BorderRadius.circular(5000),
              child: Container(
          //      color: Colors.white,
                padding: EdgeInsets.all(8),
                child: CircleAvatar(
                  radius: 50,
                  child: Icon(
                    Icons.add_a_photo,
                    color: Colors.white70,
                    size: 35,
                  ),
                ),
              ),
            ),
         // ),

          Positioned(
            top: 200,
            child: Column(
              children: <Widget>[
                Container(
                  height: 15,
                ),

                //    ),
                 Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: SizedBox(
                      width: screenWidth-50,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                      )),
                ),

                Container(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: SizedBox(
                      width: screenWidth-50,
                      child: TextField(
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Bio',
                        ),
                      )),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: SizedBox(
                      width: screenWidth-50,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Location',
                        ),
                      )),
                ),

                 Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: SizedBox(
                      width: screenWidth-50,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Website',
                        ),
                      )),
                ),

                /*    Padding(
              padding: const EdgeInsets.fromLTRB(35, 0, 30, 0),
              child: SizedBox(
                  width: 320,
                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2018, 3, 5),
                          maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            print('confirm $date');
                          }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    decoration: const InputDecoration(
                        hintText: "Date of birth",
                        hintStyle: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 88, 85, 85))),
                  )),
            ),*/
              ],
            ),
          ),
        ],
      ),
    ),
    );
    //);
  }
}
