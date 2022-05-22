import 'package:flutter/material.dart';
import 'package:country_list/country_list.dart';

import 'change_country2.dart';



class ChangeCountry extends StatefulWidget {
  static String route = '/ChangeCountry';

  const ChangeCountry({Key? key}) : super(key: key);
  changecountry createState() => changecountry();
}

class changecountry extends State<ChangeCountry> {
  bool value = false;

  @override
  void initstate() {
    super.initState();
    setState(() {
    });
  }

  onSearch(String search) {
    setState(() {

    });
  }


  AppBar logoAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.blue,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          'Select a country',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),

      //systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: logoAppBar(),
        body:SingleChildScrollView(
            child:Container(
              constraints: const BoxConstraints(maxWidth: 480),
              child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                itemCount: Countries.list.length,
                itemBuilder: (_, position) {
                  Country country = Countries.list[position];
                  return ListTile(
                    onTap: (){
                      Navigator.pushNamed(
                        context, ChangeCountry2.route);

                    },
                    title: Text(country.name,
                      style: TextStyle(fontWeight: FontWeight.bold),),
                  );
                }, separatorBuilder: (BuildContext context, int index) => Divider(height: 0,color: Colors.blueGrey.shade300,),),

            ) ));

  }
}