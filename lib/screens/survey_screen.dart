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
import 'drawer/navigation_drawer.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({Key? key}) : super(key: key);

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> with SingleTickerProviderStateMixin {


  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
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
          title: mediumText("DocsHero",size: size.shortestSide < shortestSideCheck ? 21 : size.width * 0.045),
          backgroundColor: kOrangeColor,
        toolbarHeight: size.shortestSide < shortestSideCheck ? 70 : 100 ,
          actions: [
            // IconButton(onPressed: (){
            //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ShoppingCartScreen()));
            // }, icon: Icon(Icons.shopping_cart,color: kWhiteColor,),padding: EdgeInsets.only(right: 10),),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Padding(
                  padding:  EdgeInsets.only(right: size.shortestSide < shortestSideCheck ? 0 : 35.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ShoppingCartScreen()));
                    },
                    icon:  Icon(
                      Icons.shopping_cart_rounded,
                      size: size.shortestSide < shortestSideCheck ? 25 : size.width * 0.04,
                      color: kBlueColor,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 5,
                  child: Container(
                    height: 28,
                    width: 28,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: kOrangeColor,
                    ),
                    child:  Center(
                        child: Text(
                          "${Provider.of<DataProvider>(context,listen: true).productList.length}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp,color: kWhiteColor,size: size.shortestSide < shortestSideCheck ? 25 :45,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),


        bottom: TabBar(
          // controller: _tabController,
            tabs: [
              Tab(
                child: Text("Steps",style: TextStyle(fontSize: size.shortestSide < shortestSideCheck ? 18 : size.width * 0.035),),
              ),
              Tab(child: Text("Questions",style: TextStyle(fontSize: size.shortestSide < shortestSideCheck ? 18 : size.width * 0.035)),),
              Tab(child: Text("Details",style: TextStyle(fontSize: size.shortestSide < shortestSideCheck ? 18 : size.width * 0.035)),)

            ],
          ),
      ),

      body: TabBarView(
        // controller: _tabController,
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
