import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:twitter_flutter/widgets/authentication/constants.dart';
import 'package:focused_menu/focused_menu.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Image.network(imageURL)),
            Padding(
              padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.12),
              child: FocusedMenuHolder(
                blurSize: 0,
                animateMenuItems: false,
                //bottomOffsetHeight: MediaQuery.of(context).size.height/2,
                menuOffset: MediaQuery.of(context).size.height/2.5,
                menuWidth: MediaQuery.of(context).size.width*0.8,
                duration: Duration.zero,
                openWithTap: true,
                child:  Center(
                  child: Padding(
                    padding: EdgeInsets.only(right:MediaQuery.of(context).size.width*0.12),
                    child: OutlinedButton(
                      style: outlinedButtonsStyle.copyWith(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        elevation: MaterialStateProperty.all<double>(5),
                      ),
                      onPressed: null,
                      child:Text("Edit"),
                    ),
                  ),
                ),
                menuItems: [
                  FocusedMenuItem(title: Text("Take photo"), onPressed: (){}),
                  FocusedMenuItem(title: Text("Choose Existing Photo"), onPressed: (){}),
                ],
                onPressed: (){},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
