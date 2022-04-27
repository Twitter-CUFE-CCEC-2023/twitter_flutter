import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class FABActions extends StatelessWidget {
  const FABActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildFABActionButton(iconData: Icons.mic_none_outlined,buttonLabel: "Spaces",callback: ()=>print("Mic Pressed")),
          _buildFABActionButton(iconData: Icons.photo_outlined,buttonLabel: "Photos",callback: ()=>print("Photo Pressed")),
          _buildFABActionButton(iconData:Icons.gif_box_outlined,buttonLabel: "Gif",callback: ()=>print("GIF pressed")),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(padding: EdgeInsets.only(right: 30,bottom: 15),
                child:Text("Tweet",style: TextStyle(fontSize: 18),),
              ),
              FloatingActionButton(
                onPressed: () => print("Tweet pressed"),
                child: FaIcon(FontAwesomeIcons.featherPointed),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildFABActionButton({IconData? iconData,void Function()? callback,String? buttonLabel}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Padding(padding: EdgeInsets.only(right: 30,bottom: 15),
       child:Text(buttonLabel??"",style: TextStyle(fontSize: 18),),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 10,bottom: 12),
        child: SizedBox(
          height: 37,
          width: 37,
          child: FloatingActionButton(
              elevation: 5,
              onPressed: callback,
              child: Icon(
                iconData,
                //Icons.gif_box_outlined,
                size: 25,
                color: Colors.lightBlue,
              ),
              backgroundColor: Colors.white),
        ),
      ),
    ],
  );
}
