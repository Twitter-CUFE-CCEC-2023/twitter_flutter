import 'package:flutter/material.dart';

Widget buildBottomSheet(context, state) {
  return Transform.translate(
    offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10.0)),
            child: Text(
              state.errorMessage,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
}