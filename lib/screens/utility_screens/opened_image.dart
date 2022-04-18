import 'package:flutter/material.dart';
import 'package:twitter_flutter/widgets/authentication/constants.dart';

class OpenedImage extends StatelessWidget {
  static const String route = "/OpenedImage";
  final String imageURL;
  OpenedImage({required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          actions: [
            GestureDetector(
              onTap: (){
                //TODO:Open a menu to allow the user to either take a photo from the cam or form the device storage
              },
                child: Icon(
              Icons.more_vert_rounded,
              color: Colors.white,
            ))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: Image.network(imageURL)),
            Center(
              child: OutlinedButton(
                onPressed: () {},
                style: outlinedButtonsStyle.copyWith(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  elevation: MaterialStateProperty.all<double>(5),
                ),
                child: Text("Edit"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
