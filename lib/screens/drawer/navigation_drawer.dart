import 'package:docshero/components/constants.dart';
import 'package:docshero/components/providers/api_data_provider.dart';
import 'package:docshero/components/providers/contact_report_apis.dart';
import 'package:docshero/components/providers/data_provilder.dart';
import 'package:docshero/screens/drawer/company_home.dart';
import 'package:docshero/screens/drawer/contact_report/contact_report_home.dart';
import 'package:docshero/screens/drawer/contact_report/create_contact_report.dart';
import 'package:docshero/screens/drawer/user_profile.dart';
import 'package:docshero/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/reuseable_widgets/custom_loader.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataProvider provider=Provider.of<DataProvider>(context,listen: false);
    return Drawer(
      backgroundColor: kBlueColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),topRight: Radius.circular(20)),
      ),
      width: MediaQuery.of(context).size.shortestSide < 550 ? MediaQuery.of(context).size.width * 0.75 :MediaQuery.of(context).size.width * 0.85,
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildHeader(context,provider),
            buildItems(context,MediaQuery.of(context).size,provider)
          ],
        ),
      ),
    );
  }
  buildHeader(BuildContext context,DataProvider provider){
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20,bottom: 10,left: 10,right: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage("assets/images/logo.png"),
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mediumText("${provider.userModel!.firstName} ${provider.userModel!.lastName}",
                      color: kWhiteColor),
                  mediumText("${provider.userModel!.email}", color: kWhiteColor,size: 16),

                  SizedBox(height: 15,),

                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> UserProfile()));
                    },
                    child: mediumText("My Profile", color: kOrangeColor,size: 16,
                        textDecoration: TextDecoration.underline,),
                  )
                ],
              )
            ],
          ),
        ),

        SizedBox(height: 10,),
        Divider(color: kWhiteColor,thickness: 2,)
      ],
    );

  }
  buildItems(BuildContext context,Size size, DataProvider provider){
    return Column(
      children: [
        Column(
          children: [
            ListTile(
              leading: Icon(Icons.person_add_alt_outlined,color: kWhiteColor),
              title: Text("Companies",style: TextStyle(color: kWhiteColor),),
              onTap: () async{

                await Provider.of<ApiDataProvider>(context,listen: false).getAllCompanies(context,provider.loginModel!.token! );

              },
            ),
            ListTile(
              leading: Icon(Icons.person,color: kWhiteColor),
              title: Text("Customers",style: TextStyle(color: kWhiteColor),),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.contact_mail_sharp,color: kWhiteColor),
              title: Text("Contact Report",style: TextStyle(color: kWhiteColor),),
              onTap: () async{
                await Provider.of<ContactReportApis>(context,listen: false).getContactReports(context, provider.loginModel!.token!);
              },
            ),
          ],
        ),

        SizedBox(height: size.height * 0.47,),

        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Divider(color: kWhiteColor,thickness: 2,),
            ListTile(
              //leading: Icon(Icons.logout,color: kWhiteColor),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Logout",style: TextStyle(color: kWhiteColor),),
                  Icon(Icons.logout,color: kWhiteColor)
                ],
              ),
              onTap: () async{
                SharedPreferences _prefs= await SharedPreferences.getInstance() ;
                _prefs.clear();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
              },
            ),
          ],
        )
      ],
    );
  }
}
