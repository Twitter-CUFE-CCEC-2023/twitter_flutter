import 'package:flutter/material.dart';

import '../../blocs/InternetStates/internet_cubit.dart';

//Default network listner function
void networkListner(context, state) {
  FocusScope.of(context).unfocus();
  if (state is InternetDisconnected) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Internet Disconnected"),
        duration: Duration(seconds: 3)));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Internet Connected"), duration: Duration(seconds: 3),));
  }
}

