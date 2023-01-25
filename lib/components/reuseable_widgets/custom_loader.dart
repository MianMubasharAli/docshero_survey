
import 'package:docshero/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class CustomLoader extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black.withAlpha(50),
      child: Center(
        child: const SizedBox(
          width: 50,
          height: 50,
          child: SpinKitFadingCube(
            color: kOrangeColor,
          ),
        ),
      ),
    );
  }
}