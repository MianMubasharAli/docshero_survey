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
    return SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
      backgroundColor: kWhiteColor,
      appBar: AppBar(
          title: Text("DocsHero"),
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
                  icon: const Icon(
                    Icons.shopping_cart_rounded,
                    size: 30,
                    color: kWhiteColor,
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 6,
                  child: Container(
                    height: 22,
                    width: 22,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: kOrangeColor,
                    ),
                    child:  Center(
                        child: Text(
                          "${Provider.of<DataProvider>(context,listen: true).productList.length}",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text("Steps"),
              ),
              Tab(child: Text("Questions"),),
              Tab(child: Text("Details"),)

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
