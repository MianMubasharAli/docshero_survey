import 'package:docshero/components/constants.dart';
import 'package:docshero/components/providers/api_data_provider.dart';
import 'package:docshero/components/providers/contact_report_apis.dart';
import 'package:docshero/components/providers/data_provilder.dart';
import 'package:docshero/components/providers/supplier_apis.dart';
import 'package:docshero/screens/drawer/self_service/self_service_home.dart';
import 'package:docshero/screens/drawer/suppliers/suppliers_home.dart';
import 'package:docshero/screens/drawer/user_profile.dart';
import 'package:docshero/screens/survey_screen.dart';
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
      width: MediaQuery.of(context).size.shortestSide < shortestSideCheck ? MediaQuery.of(context).size.width * 0.75 :MediaQuery.of(context).size.width * 0.85,
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildHeader(context,provider,MediaQuery.of(context).size),
            buildItems(context,MediaQuery.of(context).size,provider)
          ],
        ),
      ),
    );
  }
  buildHeader(BuildContext context,DataProvider provider, Size size){
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20,bottom: 10,left: 10,right: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: size.shortestSide < shortestSideCheck ? 35 : 60,
                backgroundImage: AssetImage("assets/images/logo.png"),
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mediumText("${provider.userModel!.firstName} ${provider.userModel!.lastName}",
                      color: kWhiteColor,
                      size: size.shortestSide < shortestSideCheck ? 18 : 35
                  ),

                  mediumText("${provider.userModel!.email}", color: kWhiteColor,
                  size: size.shortestSide < shortestSideCheck ? 16 : 25),

                  SizedBox(height: 15,),

                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> UserProfile()));
                    },
                    child: mediumText("My Profile", color: kOrangeColor,size: size.shortestSide < shortestSideCheck ? 16 : 25,
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
              leading: Icon(Icons.person_add_alt_outlined,color: kWhiteColor,size: size.shortestSide < shortestSideCheck ? 24 : 50),
              title: Text("Customers",style: TextStyle(color: kWhiteColor,fontSize: size.shortestSide < shortestSideCheck ? 16 : 25),),
              onTap: () async{
                await provider.setCheckForDialog(true);
                await Provider.of<ApiDataProvider>(context,listen: false).getAllCompanies(context,provider.loginModel!.token! );
                await provider.setCheckForDialog(false);
              },
            ),
            SizedBox(height: size.shortestSide < shortestSideCheck ? 0 :10,),
            ListTile(
              leading: Icon(Icons.group,color: kWhiteColor,size: size.shortestSide < shortestSideCheck ? 24 : 50),
              title: Text("Suppliers",style: TextStyle(color: kWhiteColor,fontSize: size.shortestSide < shortestSideCheck ? 16 : 25),),
              onTap: () async{
                Get.dialog(CustomLoader());
                bool check= await Provider.of<SupplierApis>(context,listen: false).getAllSuppliers(context, provider.loginModel!.token!);
                Get.back();
                if(check==true){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SuppliersHome()));
                }

              },
            ),
            SizedBox(height: size.shortestSide < shortestSideCheck ? 0 : 10,),
            ListTile(
              leading: Icon(Icons.contact_mail_sharp,color: kWhiteColor,size: size.shortestSide < shortestSideCheck ? 24 : 50),
              title: Text("Contact Report",style: TextStyle(color: kWhiteColor,fontSize: size.shortestSide < shortestSideCheck ? 16 : 25),),
              onTap: () async{
                await provider.setCheckForDialog(true);
                await Provider.of<ContactReportApis>(context,listen: false).getContactReports(context, provider.loginModel!.token!);
                await provider.setCheckForDialog(false);
                },
            ),

            SizedBox(height: size.shortestSide < shortestSideCheck ? 0 :10,),
            ListTile(
              leading: Icon(Icons.edit_note,color: kWhiteColor, size: size.shortestSide < shortestSideCheck ? 24 : 60,),
              title: Text("Survey",style: TextStyle(color: kWhiteColor,fontSize: size.shortestSide < shortestSideCheck ? 16 : 25),),
              onTap: () async{
                await provider.setCheckForDialog(true);
                await Provider.of<DataProvider>(context,listen: false).loadJsonData().then((value) async{
                  if(value==true){
                    await provider.setCheckForDialog(false);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SurveyScreen()));
                  }
                });

              },
            ),
            SizedBox(height: size.shortestSide < shortestSideCheck ? 0 :10,),
            ListTile(
              leading: Icon(Icons.groups,color: kWhiteColor,size: size.shortestSide < shortestSideCheck ? 24 : 50),
              title: Text("Self Service",style: TextStyle(color: kWhiteColor,fontSize: size.shortestSide < shortestSideCheck ? 16 : 25),),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SelfServiceHome()));
              },
            ),
          ],
        ),

        SizedBox(height: size.height * 0.4,),

        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Divider(color: kWhiteColor,thickness: 2,),
            ListTile(
              //leading: Icon(Icons.logout,color: kWhiteColor),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Logout",style: TextStyle(color: kWhiteColor,fontSize: size.shortestSide < shortestSideCheck ? 16 : 25),),
                  Icon(Icons.logout,color: kWhiteColor,size: size.shortestSide < shortestSideCheck ? 24 : 60)
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
