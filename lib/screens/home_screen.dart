import 'dart:convert';

import 'package:docshero/components/models/survey_model.dart';
import 'package:docshero/components/providers/data_provilder.dart';
import 'package:docshero/screens/shopping_cart_screen.dart';
import 'package:docshero/screens/tabbar_screens/details.dart';
import 'package:docshero/screens/tabbar_screens/questions.dart';
import 'package:docshero/screens/tabbar_screens/steps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../components/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
      backgroundColor: kWhiteColor,
      appBar: AppBar(
          title: mediumText("DocsHero",size: size.width * 0.06),
          backgroundColor: kOrangeColor,
          actions: [
            // IconButton(onPressed: (){
            //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ShoppingCartScreen()));
            // }, icon: Icon(Icons.shopping_cart,color: kWhiteColor,),padding: EdgeInsets.only(right: 10),),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ShoppingCartScreen()));
                  },
                  icon:  Icon(
                    Icons.shopping_cart_rounded,
                    size: size.width * 0.08,
                    color: kBlueColor,
                  ),
                ),
                Positioned(
                  top: -4,
                  right: 5,
                  child: Container(
                    height: size.height * 0.05,
                    width: size.width * 0.05,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: kOrangeColor,
                    ),
                    child:  Center(
                        child: Text(
                          "${Provider.of<DataProvider>(context,listen: true).productList.length}",
                          style: TextStyle(
                            fontSize: size.width * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ],
          leading: Container(
            // margin: EdgeInsets.only(top: 5),
            color: kOrangeColor,
            child: Image.asset("assets/images/logo.png",fit: BoxFit.fill),
          ),
          leadingWidth: size.width * 0.13,

          bottom: TabBar(
            tabs: [
              Tab(
                child: Text("Steps",style: TextStyle(fontSize: size.width * 0.05),),
              ),
              Tab(child: Text("Questions",style: TextStyle(fontSize: size.width * 0.05)),),
              Tab(child: Text("Details",style: TextStyle(fontSize: size.width * 0.05)),)

            ],
          ),
      ),
      body: TabBarView(
          children: [
            Steps(),
            Questions(),
            Details(),
          ],
      ),
      ),
        ),
    );
  }
}
