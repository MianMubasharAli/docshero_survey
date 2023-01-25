import 'package:docshero/components/constants.dart';
import 'package:docshero/components/providers/employee_apis.dart';
import 'package:docshero/components/providers/location_apis.dart';
import 'package:docshero/components/reuseable_widgets/text_button_widget.dart';
import 'package:docshero/screens/drawer/forms/company_employee_details.dart';
import 'package:docshero/screens/drawer/forms/company_personal_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/providers/data_provilder.dart';
import '../../../components/reuseable_widgets/rounded_input_field.dart';
import '../../../components/utils/validate_non_empty.dart';
class CompanyLocationDetails extends StatefulWidget {
   CompanyLocationDetails({Key? key}) : super(key: key);

  @override
  State<CompanyLocationDetails> createState() => _CompanyLocationDetailsState();
}

class _CompanyLocationDetailsState extends State<CompanyLocationDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    DataProvider provider=Provider.of<DataProvider>(context,listen: false);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: mediumText("Locations",color: kWhiteColor,size: 25),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back,size: 30),
        //   onPressed: (){
        //
        //   },
        // ),
      ),
      body: WillPopScope(
        onWillPop: () async{
          await provider.setCameBackCheck(true);
          provider.cameBack;
          print(provider.cameBack);
          return true;
        },
        child: Container(
          padding: EdgeInsets.only(left: 20,right: 20),
          margin: EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Center(child: mediumText("Add Location Details",color: kOrangeColor)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButtonWidget(
                        text: "Add Location",
                        onPress: (){
                          showDialog(context: context, builder: (context){

                            return Dialog(
                              child: Container(

                                  padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                                  child: SingleChildScrollView(
                                    child: Form(
                                      key: _formKey2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Center(child: mediumText("Add Location Details",color: kBlackColor,)),
                                          Container(
                                              margin: EdgeInsets.only(top: 5,bottom: 5),
                                              child: mediumText("Address Line 1:", color: kBlackColor,size: 16)),
                                          RoundedInputField(
                                              hintText: "Address 1",
                                              hintTextColor: Colors.black.withOpacity(0.5),
                                              textColor: kBlackColor,
                                              onChanged: (onChanged){
                                                provider.locationData.addess1=onChanged;
                                              },
                                              onSaved: (onSaved){},
                                              validator: (name) => validateNonEmpty(name!),
                                              prefixIcon: "",
                                              sufficIcon: ""),
                                          Container(
                                              margin: EdgeInsets.only(top: 5,bottom: 5),
                                              child: mediumText("Address Line 2:", color: kBlackColor,size: 16)),
                                          RoundedInputField(
                                              hintText: "Address 2",
                                              hintTextColor: Colors.black.withOpacity(0.5),
                                              textColor: kBlackColor,
                                              onChanged: (onChanged){
                                                provider.locationData.address2=onChanged;
                                              },
                                              onSaved: (onSaved){},
                                              validator: (name) => validateNonEmpty(name!),
                                              prefixIcon: "",
                                              sufficIcon: ""),
                                          Container(
                                              margin: EdgeInsets.only(top: 5,bottom: 5),
                                              child: mediumText("City:", color: kBlackColor,size: 16)),
                                          RoundedInputField(
                                              hintText: "City",
                                              hintTextColor: Colors.black.withOpacity(0.5),
                                              textColor: kBlackColor,
                                              onChanged: (onChanged){
                                                provider.locationData.city=onChanged;
                                              },
                                              onSaved: (onSaved){},
                                              validator: (name) => validateNonEmpty(name!),
                                              prefixIcon: "",
                                              sufficIcon: ""),
                                          Container(
                                              margin: EdgeInsets.only(top: 5,bottom: 5),
                                              child: mediumText("Zip:", color: kBlackColor,size: 16)),
                                          RoundedInputField(
                                              hintText: "Zip",
                                              hintTextColor: Colors.black.withOpacity(0.5),
                                              textColor: kBlackColor,
                                              onChanged: (onChanged){
                                                provider.locationData.zip=onChanged;
                                              },
                                              onSaved: (onSaved){},
                                              validator: (name) => validateNonEmpty(name!),
                                              prefixIcon: "",
                                              sufficIcon: ""),
                                          Container(
                                              margin: EdgeInsets.only(top: 5,bottom: 5),
                                              child: mediumText("Country:", color: kBlackColor,size: 16)),
                                          RoundedInputField(
                                              hintText: "Country",
                                              hintTextColor: Colors.black.withOpacity(0.5),
                                              textColor: kBlackColor,
                                              onChanged: (onChanged){
                                                provider.locationData.country=onChanged;
                                              },
                                              onSaved: (onSaved){},
                                              validator: (name) => validateNonEmpty(name!),
                                              prefixIcon: "",
                                              sufficIcon: ""),
                                          Container(
                                              margin: EdgeInsets.only(top: 5,bottom: 5),
                                              child: mediumText("State:", color: kBlackColor,size: 16)),
                                          RoundedInputField(
                                              hintText: "State",
                                              hintTextColor: Colors.black.withOpacity(0.5),
                                              textColor: kBlackColor,
                                              onChanged: (onChanged){
                                                provider.locationData.state=onChanged;
                                              },
                                              onSaved: (onSaved){},
                                              validator: (name) => validateNonEmpty(name!),
                                              prefixIcon: "",
                                              sufficIcon: ""),

                                          SizedBox(height: 20,),
                                          Center(
                                            child: SizedBox(
                                              width: size.width * 0.3,
                                              child: TextButtonWidget(
                                                  text: "Add",
                                                  onPress: () async{
                                                    if(!_formKey2.currentState!.validate()){
                                                      return;
                                                    }
                                                    _formKey2.currentState!.save();
                                                    LocationApis locationApisProvider=Provider.of<LocationApis>(context,listen: false);
                                                    await locationApisProvider.createLocation(context, provider.loginModel!.token!);
                                                  }),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            );
                          });
                        }),
                    TextButtonWidget(
                        text: "Proceed Next",
                        onPress: () async{
                          bool check=await Provider.of<EmployeeApis>(context,listen: false).getEmployeeById(context, provider.loginModel!.token!, provider.companyId!);
                        if(check==true){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CompanyEmployeeDetails(
                            locationList: provider.locationByIdModel!.locations ?? [],
                          )));
                        }
                        })
                  ],
                ),
                SizedBox(height: 20,),
                Center(child: mediumText("Addresses",color: kBlackColor,size: 25)),
                ListView.builder(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: Provider.of<DataProvider>(context,listen: true).locationByIdModel!.locations?.length,
                    itemBuilder: (context,index){
                  return InkWell(
                    onTap: () async{
                      showDialog(context: context, builder: (context){

                        return Dialog(
                          child: Container(

                            padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                            child: SingleChildScrollView(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Center(child: mediumText("Add Location Details",color: kBlackColor,)),
                                    Container(
                                        margin: EdgeInsets.only(top: 5,bottom: 5),
                                        child: mediumText("Address Line 1:", color: kBlackColor,size: 16)),
                                    RoundedInputField(
                                        hintText: "Address 1",
                                        initialValue: "${provider.locationByIdModel!.locations?[index]!.addressFirst}",
                                        hintTextColor: Colors.black.withOpacity(0.5),
                                        textColor: kBlackColor,
                                        onChanged: (onChanged){
                                          provider.locationData.addess1=onChanged;
                                        },
                                        onSaved: (onSaved){
                                          if(onSaved != null){
                                            provider.locationData.addess1=onSaved;
                                          }
                                        },
                                        validator: (name) => validateNonEmpty(name!),
                                        prefixIcon: "",
                                        sufficIcon: ""),
                                    Container(
                                        margin: EdgeInsets.only(top: 5,bottom: 5),
                                        child: mediumText("Address Line 2:", color: kBlackColor,size: 16)),
                                    RoundedInputField(
                                        hintText: "Address 2",
                                        initialValue: "${provider.locationByIdModel!.locations?[index]!.addressSecond}",
                                        hintTextColor: Colors.black.withOpacity(0.5),
                                        textColor: kBlackColor,
                                        onChanged: (onChanged){
                                          provider.locationData.address2=onChanged;
                                        },
                                        onSaved: (onSaved){
                                          if(onSaved != null){
                                            provider.locationData.address2=onSaved;
                                          }
                                        },
                                        validator: (name) {},
                                        prefixIcon: "",
                                        sufficIcon: ""),
                                    Container(
                                        margin: EdgeInsets.only(top: 5,bottom: 5),
                                        child: mediumText("City:", color: kBlackColor,size: 16)),
                                    RoundedInputField(
                                      initialValue: "${provider.locationByIdModel!.locations?[index]!.city}",
                                        hintText: "City",
                                        hintTextColor: Colors.black.withOpacity(0.5),
                                        textColor: kBlackColor,
                                        onChanged: (onChanged){
                                          provider.locationData.city=onChanged;
                                        },
                                        onSaved: (onSaved){
                                        if(onSaved != null){
                                          provider.locationData.city=onSaved;
                                        }
                                        },
                                        validator: (name) => validateNonEmpty(name!),
                                        prefixIcon: "",
                                        sufficIcon: ""),
                                    Container(
                                        margin: EdgeInsets.only(top: 5,bottom: 5),
                                        child: mediumText("Zip:", color: kBlackColor,size: 16)),
                                    RoundedInputField(
                                      initialValue: "${provider.locationByIdModel!.locations?[index]!.zip}",
                                        hintText: "Zip",
                                        hintTextColor: Colors.black.withOpacity(0.5),
                                        textColor: kBlackColor,
                                        onChanged: (onChanged){
                                          provider.locationData.zip=onChanged;
                                        },
                                        onSaved: (onSaved){
                                        if(onSaved != null){
                                          provider.locationData.zip=onSaved;
                                        }
                                        },
                                        validator: (name) => validateNonEmpty(name!),
                                        prefixIcon: "",
                                        sufficIcon: ""),
                                    Container(
                                        margin: EdgeInsets.only(top: 5,bottom: 5),
                                        child: mediumText("Country:", color: kBlackColor,size: 16)),
                                    RoundedInputField(
                                      initialValue: "${provider.locationByIdModel!.locations?[index]!.country}",
                                        hintText: "Country",
                                        hintTextColor: Colors.black.withOpacity(0.5),
                                        textColor: kBlackColor,
                                        onChanged: (onChanged){
                                          provider.locationData.country=onChanged;
                                        },
                                        onSaved: (onSaved){
                                        if(onSaved != null){
                                          provider.locationData.country=onSaved;
                                        }
                                        },
                                        validator: (name) => validateNonEmpty(name!),
                                        prefixIcon: "",
                                        sufficIcon: ""),
                                    Container(
                                        margin: EdgeInsets.only(top: 5,bottom: 5),
                                        child: mediumText("State:", color: kBlackColor,size: 16)),
                                    RoundedInputField(
                                      initialValue: "${provider.locationByIdModel!.locations?[index]!.state}",
                                        hintText: "State",
                                        hintTextColor: Colors.black.withOpacity(0.5),
                                        textColor: kBlackColor,
                                        onChanged: (onChanged){
                                          provider.locationData.state=onChanged;
                                        },
                                        onSaved: (onSaved){
                                        if(onSaved != null){
                                          provider.locationData.state=onSaved;
                                        }
                                        },
                                        validator: (name) => validateNonEmpty(name!),
                                        prefixIcon: "",
                                        sufficIcon: ""),

                                    SizedBox(height: 20,),
                                    Center(
                                      child: SizedBox(
                                        width: size.width * 0.3,
                                        child: TextButtonWidget(
                                            text: "Add",
                                            onPress: () async{
                                              if(!_formKey.currentState!.validate()){
                                                return;
                                              }
                                              _formKey.currentState!.save();

                                              FocusScope.of(context).requestFocus(FocusNode());
                                              LocationApis locationApisProvider=Provider.of<LocationApis>(context,listen: false);
                                              await locationApisProvider.updateLocation(context,
                                                  provider.loginModel!.token!,provider.locationByIdModel!.locations![index]!.id!, index );
                                              setState(() {

                                              });
                                            }),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 10),
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment:Alignment.topRight,
                            child: IconButton(
                              icon: Icon(Icons.delete, color: kOrangeColor,),
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.zero,
                              onPressed: () async{
                               await Provider.of<LocationApis>(context,listen: false).deleteLocation(context, provider.loginModel!.token!,
                                    provider.locationByIdModel!.locations![index]!.id!);
                               setState(() {

                               });
                              },
                            ),
                          ),
                          Row(
                            children: [
                              mediumText("Address 1: ",color: kBlackColor,maxLines: 2,softWrap: false),
                              Expanded(
                                  child: mediumText("${provider.locationByIdModel!.locations?[index]!.addressFirst}",color: kBlackColor,maxLines: 2,softWrap: false,fontWeight: FontWeight.normal)),
                            ],
                          ),
                          Row(
                            children: [
                              mediumText("Address 2: ",color: kBlackColor,maxLines: 2,softWrap: false),
                              Expanded(
                                  child:
                                  mediumText("${provider.locationByIdModel!.locations?[index]!.addressSecond}",fontWeight: FontWeight.normal,color: kBlackColor,maxLines: 2,softWrap: false),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              mediumText("City: ",color: kBlackColor,maxLines: 2,softWrap: false),
                              Expanded(
                                child:
                                mediumText("${provider.locationByIdModel!.locations?[index]!.city}",fontWeight: FontWeight.normal,color: kBlackColor,maxLines: 2,softWrap: false),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              mediumText("Country: ",color: kBlackColor,maxLines: 2,softWrap: false),
                              Expanded(
                                child:
                                mediumText("${provider.locationByIdModel!.locations?[index]!.country}",fontWeight: FontWeight.normal,color: kBlackColor,maxLines: 2,softWrap: false),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              mediumText("State: ",color: kBlackColor,maxLines: 2,softWrap: false),
                              Expanded(
                                child:
                                mediumText("${provider.locationByIdModel!.locations?[index]!.state}",fontWeight: FontWeight.normal,color: kBlackColor,maxLines: 2,softWrap: false),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                })

              ],
            ),
          ),
        ),
      ),
    ));
  }
}
