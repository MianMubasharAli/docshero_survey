import 'package:docshero/components/constants.dart';
import 'package:docshero/components/providers/data_provilder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/providers/api_data_provider.dart';
import '../components/reuseable_widgets/rounded_input_field.dart';
import '../components/reuseable_widgets/text_button_widget.dart';
import '../components/utils/validate_non_empty.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  String email="";
  String password="";
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: kBlueColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.messenger_outline,color: kWhiteColor,size: 70,),
                SizedBox(width: 5,),
                mediumText("DocsHero ",color: kWhiteColor,size: 30),
                mediumText("Survey ",color: kWhiteColor,size: 20)
              ],
            ),
            SizedBox(height: size.height * 0.05,),
            Center(
              child: Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.only(left: size.shortestSide < 550 ? size.width * 0.08 : size.width * 0.08,right: size.shortestSide < 550 ? size.width * 0.08 : size.width * 0.08),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      mediumText("Email:",color: kBlackColor,fontWeight: FontWeight.normal),
                      SizedBox(height: 4,),
                      RoundedInputField(
                        sufficIcon: "",
                          hintText: "email",
                          textColor: kBlackColor,
                          keyboardType: TextInputType.emailAddress,
                          hintTextColor: Colors.black.withOpacity(1),
                          onChanged: (onChanged){
                            email=onChanged;
                          },
                          onSaved: (onSaved){},
                          validator: (email) =>
                              validateNonEmpty(email!),
                          prefixIcon: ""),
                      SizedBox(height: 15,),
                      mediumText("Password:",color: kBlackColor,fontWeight: FontWeight.normal),
                      SizedBox(height: 4,),
                      RoundedInputField(
                        obscure: true,
                          sufficIcon: "aa",
                          hintText: "password",
                          textColor: kBlackColor,
                          keyboardType: TextInputType.visiblePassword,
                          hintTextColor: Colors.black.withOpacity(1),
                          onChanged: (onChanged){
                            password=onChanged;
                          },
                          onSaved: (onSaved){},
                          validator: (email) =>
                              validateNonEmpty(email!),
                          prefixIcon: ""),
                      SizedBox(height: 0,),
                      Row(
                        children: [
                          Checkbox(
                            splashRadius: 0,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              value: Provider.of<ApiDataProvider>(context,listen: true).rememberMe,
                              onChanged: (onChanged){
                                Provider.of<ApiDataProvider>(context,listen: false).setRememberMe(onChanged!);
                              }),
                          mediumText("Remember Me",color: kBlackColor,fontWeight: FontWeight.normal,size: 15)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Center(child: TextButtonWidget(onPress: () async{
                        if(!_formKey.currentState!.validate()){
                          return;
                        }
                        _formKey.currentState!.save();


                        Provider.of<ApiDataProvider>(context,listen: false).login(context, email, password);
                      }))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
