import 'package:docshero/components/constants.dart';
import 'package:docshero/components/providers/data_provilder.dart';
import 'package:docshero/components/providers/docshero_apis_provider.dart';
import 'package:docshero/components/reuseable_widgets/rounded_input_field.dart';
import 'package:docshero/components/reuseable_widgets/text_button_widget.dart';
import 'package:docshero/components/utils/validate_non_empty.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatelessWidget {
   UserProfile({Key? key}) : super(key: key);
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    DataProvider provider=Provider.of<DataProvider>(context,listen: false);
    return SafeArea(

      child: Scaffold(
        backgroundColor: kWhiteColor,
        appBar: AppBar(
          title: mediumText("Profile",color: kWhiteColor,fontWeight: FontWeight.normal,size: size.shortestSide < shortestSideCheck ? 25 : 35),
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
          padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20,bottom: 10,left: 10,right: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: size.shortestSide < shortestSideCheck ? 45 : 75,
                          backgroundImage: AssetImage("assets/images/logo.png",),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mediumText("${provider.userModel!.firstName} ${provider.userModel!.lastName}",
                                color: kBlackColor,
                            size: size.shortestSide < shortestSideCheck ? 18 : 30
                            ),
                            mediumText("${provider.userModel!.email}",
                                color: kBlackColor,
                                size: size.shortestSide < shortestSideCheck ? 16 : 25,fontWeight: FontWeight.normal),

                            SizedBox(height: 15,),

                            Row(
                              children: [
                                Icon(Icons.phone,size: size.shortestSide < shortestSideCheck ? 24 : 40,),
                                SizedBox(width: 10,),
                                mediumText("${provider.userModel!.mobile}",color: kBlackColor,
                                    size: size.shortestSide < shortestSideCheck ? 16 : 25,fontWeight: FontWeight.normal),
                              ],
                            )

                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(thickness: 1,color: Colors.black.withOpacity(0.1),),
                 ProfileDetailCard(size: size,
                     provider: provider,
                     icon: Icons.location_city_outlined,
                     text: "${provider.userModel!.firstName}",
                     fieldName: "First Name:",
                      onChanged: (onChanged){
                        provider.userModel!.firstName=onChanged;
                      },
                   onSaved: (onSaved){
                   if(onSaved != null && onSaved != ""){
                     provider.userModel!.firstName=onSaved;
                   }
                   },
                 ),
                  ProfileDetailCard(size: size,
                      provider: provider,
                      text: "${provider.userModel!.lastName}",
                      icon: Icons.folder_zip_outlined,
                      fieldName: "Last Name:",
                    onChanged: (onChanged){

                        provider.userModel!.lastName=onChanged;

                    },
                    onSaved: (onSaved){
                      if(onSaved != null && onSaved != ""){
                        provider.userModel!.lastName=onSaved;
                      }
                    },
                  ),
                  ProfileDetailCard(size: size,
                    provider: provider,
                    icon: Icons.location_city_outlined,
                    text: "${provider.userModel!.city}",
                    fieldName: "City:",
                    onChanged: (onChanged){
                      provider.userModel!.city=onChanged;
                    },
                    onSaved: (onSaved){
                      if(onSaved != null && onSaved != ""){
                        provider.userModel!.city=onSaved;
                      }
                    },
                  ),
                  ProfileDetailCard(size: size,
                    provider: provider,
                    icon: Icons.location_city_outlined,
                    text: "${provider.userModel!.street}",
                    fieldName: "Street:",
                    onChanged: (onChanged){
                      provider.userModel!.street=onChanged;
                    },
                    onSaved: (onSaved){
                      if(onSaved != null && onSaved != ""){
                        provider.userModel!.street=onSaved;
                      }
                    },
                  ),
                  ProfileDetailCard(size: size,
                    provider: provider,
                    icon: Icons.location_city_outlined,
                    text: "${provider.userModel!.streetNumber}",
                    fieldName: "Street Number:",
                    onChanged: (onChanged){
                      provider.userModel!.streetNumber=onChanged;
                    },
                    onSaved: (onSaved){
                      if(onSaved != null && onSaved != ""){
                        provider.userModel!.streetNumber=onSaved;
                      }
                    },
                  ),
                  ProfileDetailCard(size: size,
                    provider: provider,
                    icon: Icons.location_city_outlined,
                    text: "${provider.userModel!.zip}",
                    fieldName: "Zip:",
                    onChanged: (onChanged){
                      provider.userModel!.zip=onChanged;
                    },
                    onSaved: (onSaved){
                      if(onSaved != null && onSaved != ""){
                        provider.userModel!.zip=onSaved;
                      }
                    },
                  ),
                  ProfileDetailCard(size: size,
                    provider: provider,
                    icon: Icons.location_city_outlined,
                    text: "${provider.userModel!.mobile}",
                    fieldName: "Phone:",
                    onChanged: (onChanged){
                      provider.userModel!.mobile=onChanged;
                    },
                    onSaved: (onSaved){
                      if(onSaved != null && onSaved != ""){
                        provider.userModel!.mobile=onSaved;
                      }
                    },
                  ),
                  // ProfileDetailCard(size: size, provider: provider,text: "${provider.userModel!.zip}",icon: Icons.folder_zip_outlined),

                  SizedBox(
                    width: size.shortestSide < shortestSideCheck ? size.width * 0.4 : size.width * 0.3,
                    child: TextButtonWidget(
                        text: "Update",
                        textColor: kWhiteColor,
                        textSize: size.shortestSide < shortestSideCheck ? 18 : 30,
                        onPress: () async{
                          if(!_formKey.currentState!.validate()){
                            return;
                          }
                          _formKey.currentState!.save();

                          await provider.setCheckForDialog(true);
                         await Provider.of<DocsheroApisProvider>(context,listen: false).updateUserProfile(context, provider.loginModel!.token!);
                          await provider.setCheckForDialog(false);
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileDetailCard extends StatelessWidget {
   ProfileDetailCard({
    Key? key,
    required this.size,
    required this.provider,
     required this.icon,
     required this.text,
     required this.fieldName,
     required this.onSaved,
     required this.onChanged,
  }) : super(key: key);

  final Size size;
  final DataProvider provider;
  IconData icon;
  String text;
  String fieldName;
   final ValueChanged<String> onChanged;
   final ValueChanged<String?> onSaved;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mediumText("${fieldName}",color: kBlackColor,size: size.shortestSide < shortestSideCheck ? 18 : 30),
        SizedBox(height: 5,),
        RoundedInputField(
          initialValue: "$text",
            hintText: "First Name",
            hintTextColor: kBlackColor,
            textColor: kBlackColor,
            hintTextSize: size.shortestSide < shortestSideCheck ? 18 : 30,
            textSize: size.shortestSide < shortestSideCheck ? 18 : 30,
            onChanged: onChanged,
            onSaved: onSaved,
            validator: (validator) => validateNonEmpty(validator!),
            prefixIcon: "",
            sufficIcon: ""),
        SizedBox(height: 10,),
      ],
    );
    //   Container(
    //   margin: EdgeInsets.only(left: 0,right: 0,top: 5),
    //   padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
    //   decoration: BoxDecoration(
    //     color: kWhiteColor,
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.grey.withOpacity(0.5),
    //         spreadRadius: 1,
    //         blurRadius: 1,
    //         offset: Offset(0, 0), // changes position of shadow
    //       ),
    //     ],
    //   ),
    //   child: Row(
    //     children: [
    //       Icon(icon,size: size.shortestSide < shortestSideCheck ? 24 : 40,),
    //       SizedBox(width: 20,),
    //       SizedBox(
    //         width: size.width * 0.74,
    //           child: mediumText("$text",
    //               size: size.shortestSide < shortestSideCheck ? 18 : 30,
    //               color: kBlackColor,fontWeight: FontWeight.normal))
    //     ],
    //   ),
    // );
  }
}
