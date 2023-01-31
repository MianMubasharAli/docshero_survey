import 'package:docshero/components/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/providers/data_provilder.dart';
import 'drawer/navigation_drawer.dart';

class DashboardScreen extends StatelessWidget {
   DashboardScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: mediumText("Dashboard",color: kWhiteColor,size: size.shortestSide < 550 ? 25 : 35),
          centerTitle: true,
          toolbarHeight: size.shortestSide < shortestSideCheck ? 70.0 : 100,
          leading: IconButton(
            icon: Icon(Icons.menu,color: kWhiteColor,size: size.shortestSide < shortestSideCheck ? 25 :45,),
            onPressed: (){
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
        drawer:  NavigationDrawer(),
        body: Container(
          padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
          child: Column(
            children: [
              RichText(text: TextSpan(
                text: "Hey there! Welcome to ",
                  style: TextStyle(
              color: kBlackColor,
              fontSize: size.shortestSide < shortestSideCheck ? 20 : 30
              ),
                children: [
                  TextSpan(text: "DocsHero",style: TextStyle(
                    color: kBlueColor,
                    decoration: TextDecoration.underline,
                    fontSize: size.shortestSide < shortestSideCheck ? 23 : 33
                  ),
                  recognizer: TapGestureRecognizer()..onTap=(){

                  }
                  ),
                  TextSpan(text: " Admin Panel.",style: TextStyle(
                  color: kBlackColor,
                      fontSize: size.shortestSide < shortestSideCheck ? 20 : 30
                  ))
                ]
              ))
              // mediumText("Hey there! Welcome to DocsHero Admin Panel.",color: kBlackColor,maxLines: 5)
            ],
          ),
        ),
      ),
    );
  }
}
