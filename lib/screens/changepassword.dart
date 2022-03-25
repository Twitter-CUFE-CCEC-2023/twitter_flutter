import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainPage extends StatefulWidget{
  changepassword createState()=> changepassword();
}

class changepassword extends State<MainPage>{
//  const changepassword({Key? key}) : super(key: key);
  static String route = '/ChangePassword';
bool isButtonActive = true;
late TextEditingController controller;

@override
void initState()
{
  super.initState();
  controller = TextEditingController();
  controller.addListener(() {
    final isButtonActive = controller.text.isNotEmpty;
    setState(() => this.isButtonActive = isButtonActive);
  });
}
@override
void dispose(){
  controller.dispose();
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
            'Update Password',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[

          Positioned(
            top: 0,
            child: Column(
              children: <Widget>[
                //    ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: SizedBox(
                      width: screenWidth-50,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Current Password',
                        ),
                      )),
                ),

                Container(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: SizedBox(
                      width: screenWidth-50,
                      child: TextField(

                        decoration: InputDecoration(
                          labelText: 'New Password',
                          hintText: 'At least 8 charaacters'
                        ),
                      )),
                ),

                Container(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: SizedBox(
                      width: screenWidth-50,
                      child:
                  TextField(
                    controller: controller,
                        decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            hintText: 'At least 8 charaacters'
                        ),
                        //controller: controller,
                      ),
                  ),
                ),

                Container(
                  height: 20,
                ),

            ClipRRect(
              borderRadius: BorderRadius.circular(5000),
              child: SizedBox(
                width: 200,
                height: 45,

                child: RaisedButton(
                  color: Colors.blueAccent,
                  disabledColor: Colors.lightBlueAccent,
                  disabledElevation: 54,
                  onPressed: isButtonActive
                    ? () {
                    setState(() => isButtonActive = false);
                  }
                  : null,
                  child: Text(
                      'Update password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                ),
            ),
              ],
            ),
          ),
        ],
      ),
    );
    //);
  }


}



