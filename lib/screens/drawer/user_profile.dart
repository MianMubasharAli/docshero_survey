import 'package:docshero/components/constants.dart';
import 'package:docshero/components/providers/data_provilder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    DataProvider provider=Provider.of<DataProvider>(context,listen: false);
    return SafeArea(child: Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        title: mediumText("Profile",color: kWhiteColor,fontWeight: FontWeight.normal,size: 25),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20,bottom: 10,left: 10,right: 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage("assets/images/logo.png"),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mediumText("${provider.userModel!.firstName} ${provider.userModel!.lastName}",
                            color: kBlackColor),
                        mediumText("${provider.userModel!.email}", color: kBlackColor,size: 16,fontWeight: FontWeight.normal),

                        SizedBox(height: 15,),

                        Row(
                          children: [
                            Icon(Icons.phone),
                            SizedBox(width: 10,),
                            mediumText("${provider.userModel!.mobile}",color: kBlackColor,size: 16,fontWeight: FontWeight.normal),
                          ],
                        )

                      ],
                    )
                  ],
                ),
              ),
              Divider(thickness: 1,color: Colors.black.withOpacity(0.1),),
             ProfileDetailCard(size: size, provider: provider, icon: Icons.location_city_outlined, text: "${provider.userModel!.city} ${provider.userModel!.street} ${provider.userModel!.streetNumber}"),
              ProfileDetailCard(size: size, provider: provider,text: "${provider.userModel!.zip}",icon: Icons.folder_zip_outlined),
              // ProfileDetailCard(size: size, provider: provider,text: "${provider.userModel!.zip}",icon: Icons.folder_zip_outlined),

            ],
          ),
        ),
      ),
    ));
  }
}

class ProfileDetailCard extends StatelessWidget {
   ProfileDetailCard({
    Key? key,
    required this.size,
    required this.provider,
     required this.icon,
     required this.text,
  }) : super(key: key);

  final Size size;
  final DataProvider provider;
  IconData icon;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0,right: 0,top: 5),
      padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
      decoration: BoxDecoration(
        color: kWhiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 20,),
          SizedBox(
            width: size.width * 0.74,
              child: mediumText("$text",color: kBlackColor,fontWeight: FontWeight.normal))
        ],
      ),
    );
  }
}
