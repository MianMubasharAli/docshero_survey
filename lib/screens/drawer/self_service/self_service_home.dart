import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/constants.dart';
import '../../../components/models/self_service_models/card_design_model.dart';
import '../../../components/providers/data_provilder.dart';
import '../../../components/reuseable_widgets/self_service/card_design.dart';

class SelfServiceHome extends StatelessWidget {
   SelfServiceHome({Key? key}) : super(key: key);

List<CardDesignModel> list=[
  CardDesignModel(title: "Time Tracker", icon: Icons.view_timeline),
  CardDesignModel(title: "Vacation Request", icon: Icons.umbrella),
  CardDesignModel(title: "Travel Expenses", icon: Icons.airplanemode_active)
];
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    DataProvider dataProvider=Provider.of<DataProvider>(context,listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteColor,
        appBar: AppBar(
          backgroundColor: kBlueColor,
          title: mediumText("Self Service",color: kWhiteColor,size: size.shortestSide < shortestSideCheck ? 25 : 35),
          centerTitle: true,
          toolbarHeight: size.shortestSide < shortestSideCheck ? 70.0 : 100,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp,color: kWhiteColor,size: size.shortestSide < shortestSideCheck ? 25 :45,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 20,right: 20),
          margin: EdgeInsets.only(top: 10),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 8.0,
            children: List.generate(list.length, (index) {
              return Center(
                child: CardDesign(
                  icon: list[index].icon,
                  title: list[index].title,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
