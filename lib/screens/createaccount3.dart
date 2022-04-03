import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CreateAccount3 extends StatefulWidget {
  createaccount3 createState() => createaccount3();
}

class createaccount3 extends State<CreateAccount3> {
//  const CreateAccount3({Key? key}) : super(key: key);
  bool value = false;

  static String route = '/CreateAccount3';

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
            onPressed: () => Navigator.pop(context, false)),
        title: Image.asset(
          'assets/images/bluetwitterlogo64.png',
          cacheHeight: 70,
        ),

        //systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      //),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 35.0, right: 30.0, top: 20.0, bottom: 10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Customise your experience',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                Container(
                  height: 30,
                ),
                const Text(
                  'Track where you see Twitter content across the web',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CheckboxListTile(
                  contentPadding: const EdgeInsets.only(
                      left: 0.0, right: 28.0, top: 20.0, bottom: 20.0),
                  activeColor: Colors.blue,
                  value: value,
                  onChanged: (value) => setState(() => this.value = value!),
                  title: const Text(
                      'Twitter uses this data to personlise your experience. This web browsing history will never be stored with your name, email, or phone number.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      )),
                ),
                const Text.rich(
                  TextSpan(
                      text: 'By continuing, you agree to our ',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Terms',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.lightBlue,
                          ),
                        ),
                        TextSpan(
                            text: ', Privacy Policy and ',
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Cookie Use',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.lightBlue,
                                    ),
                              ),
                            ]),
                        TextSpan(
                            text:
                                '.Twitter may use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy. ',
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Learn more',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.lightBlue,
                                ),
                              ),
                            ])
                      ]),
                ),
              ]),
        ),
      ),
      bottomNavigationBar: ButtonBar(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5000),
            child: SizedBox(
              width: 80,
              height: 45,
              child: RaisedButton(
                color: Colors.black,

                onPressed: () {},
                child: const Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    //);
  }
}
