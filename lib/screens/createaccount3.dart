import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class createaccount3 extends StatelessWidget {
  const createaccount3({Key? key}) : super(key: key);

  static String route = '/';
  @override
  Widget build(BuildContext context) {
    bool value = false;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.blue,
              ),
              onPressed: () => Navigator.pop(context, false)),
          title: SizedBox.fromSize(
            child: Center(
              child: Image.asset('assets/images/bluetwitterlogo64.png'),
            ),
            //systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(
              left: 30.0, right: 30.0, top: 20.0, bottom: 10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Customise your',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              'experience',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 30,
            ),
            Text(
              'Track where you see Twitter',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('content across the web',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            Container(
              height: 30,
            ),
            Text('Twitter uses this data to personlise your experience. This web beowsing history will never be stored with your name, email, or phone number',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,

                )),
             Container(
               height: 30,
             ),
              Text('By signing up, you agree to our Terms, Privacy Policy and Cookie Use. Twitter may use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,

                    )),
          ]),
        ),
      ),
    );
    //);
  }
}
