import 'package:docshero/components/constants.dart';
import 'package:docshero/components/models/companies_models/location_by_id.dart';
import 'package:docshero/components/models/companies_models/post_employee_model.dart';
import 'package:docshero/components/providers/employee_apis.dart';
import 'package:docshero/components/providers/location_apis.dart';
import 'package:docshero/components/reuseable_widgets/text_button_widget.dart';
import 'package:docshero/screens/dashboard_screen.dart';
import 'package:docshero/screens/drawer/forms/company_personal_details.dart';
import 'package:docshero/screens/drawer/forms/company_zammad_details.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/providers/data_provilder.dart';
import '../../../components/reuseable_widgets/rounded_input_field.dart';
import '../../../components/utils/validate_non_empty.dart';
import '../../survey_screen.dart';
class CompanyEmployeeDetails extends StatefulWidget {
  CompanyEmployeeDetails({
    required this.locationList,
    Key? key}) : super(key: key);
    List<Location?> locationList;
  @override
  State<CompanyEmployeeDetails> createState() => _CompanyEmployeeDetailsState();
}

class _CompanyEmployeeDetailsState extends State<CompanyEmployeeDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  // final List<Location?> items = locationList;
  final TextEditingController textEditingController = TextEditingController();
  String? selectedLocationId;

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    DataProvider provider=Provider.of<DataProvider>(context,listen: false);
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: size.shortestSide < shortestSideCheck ? 70.0 : 100,
            title: mediumText("Employees",color: kWhiteColor,size: size.shortestSide < shortestSideCheck ? 25 : 35),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_sharp,color: kWhiteColor,size: size.shortestSide < shortestSideCheck ? 25 :45,),
              onPressed: () async{
                Navigator.pop(context);
              },
            ),
          ),
          body: Container(
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
                      SizedBox(
                        width: size.shortestSide < shortestSideCheck ? size.width * 0.35 : size.width * 0.25,
                        child: TextButtonWidget(
                            text: "Add Employee",
                            textSize: size.shortestSide < shortestSideCheck ? 16 : 22,
                            onPress: (){
                              showDialog(context: context, builder: (context){
                                // final List<Location?> items=widget.locationList;
                                widget.locationList;

                                return Dialog(
                                  child: WillPopScope(
                                    onWillPop: () async{
                                      provider.setSelectedValueForLocation(null);
                                      return true;
                                    },
                                    child: Container(

                                      padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                                      child: SingleChildScrollView(
                                        child: Form(
                                          key: _formKey2,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Center(child: mediumText("Add Employee Details",size: size.shortestSide < shortestSideCheck ? 18 : 24,color: kBlackColor,)),
                                              Container(
                                                  margin: EdgeInsets.only(top: 5,bottom: 5),
                                                  child: mediumText("First Name:", color: kBlackColor,size: size.shortestSide < shortestSideCheck ? 16 : 22)),
                                              RoundedInputField(
                                                  hintText: "First Name",
                                                  textSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                                  hintTextSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                                  hintTextColor: Colors.black.withOpacity(0.5),
                                                  textColor: kBlackColor,
                                                  onChanged: (onChanged){
                                                    provider.postEmployeeModel.firstName=onChanged;
                                                  },
                                                  onSaved: (onSaved){
                                                    if(onSaved != null){
                                                      provider.postEmployeeModel.firstName=onSaved;
                                                    }
                                                  },
                                                  validator: (name) => validateNonEmpty(name!),
                                                  prefixIcon: "",
                                                  sufficIcon: ""),
                                              Container(
                                                  margin: EdgeInsets.only(top: 5,bottom: 5),
                                                  child: mediumText("Last Name:", color: kBlackColor,size: size.shortestSide < shortestSideCheck ? 16 : 22)),
                                              RoundedInputField(
                                                  hintText: "Last Name",
                                                  hintTextSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                                  textSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                                  hintTextColor: Colors.black.withOpacity(0.5),
                                                  textColor: kBlackColor,
                                                  onChanged: (onChanged){
                                                    provider.postEmployeeModel.lastName=onChanged;
                                                  },
                                                  onSaved: (onSaved){
                                                    if(onSaved != null){
                                                      provider.postEmployeeModel.lastName=onSaved;
                                                    }
                                                  },
                                                  validator: (name) => validateNonEmpty(name!),
                                                  prefixIcon: "",
                                                  sufficIcon: ""),
                                              Container(
                                                  margin: EdgeInsets.only(top: 5,bottom: 5),
                                                  child: mediumText("Email:", color: kBlackColor,size: size.shortestSide < shortestSideCheck ? 16 : 22)),
                                              RoundedInputField(
                                                keyboardType: TextInputType.emailAddress,
                                                  hintText: "Email",
                                                  textSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                                  hintTextSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                                  hintTextColor: Colors.black.withOpacity(0.5),
                                                  textColor: kBlackColor,
                                                  onChanged: (onChanged){
                                                    provider.postEmployeeModel.email=onChanged;
                                                  },
                                                  onSaved: (onSaved){
                                                    if(onSaved != null){
                                                      provider.postEmployeeModel.email=onSaved;
                                                    }
                                                  },
                                                  validator: (name) => validateNonEmpty(name!),
                                                  prefixIcon: "",
                                                  sufficIcon: ""),
                                              Container(
                                                  margin: EdgeInsets.only(top: 5,bottom: 5),
                                                  child: mediumText("Password:", color: kBlackColor,size: size.shortestSide < shortestSideCheck ? 16 : 22)),
                                              RoundedInputField(
                                                  hintText: "Password",
                                                  hintTextSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                                  textSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                                  hintTextColor: Colors.black.withOpacity(0.5),
                                                  textColor: kBlackColor,
                                                  onChanged: (onChanged){
                                                    provider.postEmployeeModel.password=onChanged;
                                                  },
                                                  onSaved: (onSaved){
                                                    if(onSaved != null){
                                                      provider.postEmployeeModel.password=onSaved;
                                                    }
                                                  },
                                                  validator: (name) => validateNonEmpty(name!),
                                                  prefixIcon: "",
                                                  sufficIcon: ""),
                                              Container(
                                                  margin: EdgeInsets.only(top: 5,bottom: 5),
                                                  child: mediumText("Mobile:", color: kBlackColor,size: size.shortestSide < shortestSideCheck ? 16 : 22)),
                                              RoundedInputField(
                                                keyboardType: TextInputType.phone,
                                                  hintText: "Mobile",
                                                  textSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                                  hintTextSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                                  hintTextColor: Colors.black.withOpacity(0.5),
                                                  textColor: kBlackColor,
                                                  onChanged: (onChanged){
                                                    provider.postEmployeeModel.mobile=onChanged;
                                                  },
                                                  onSaved: (onSaved){
                                                    if(onSaved != null){
                                                      provider.postEmployeeModel.mobile=onSaved;
                                                    }
                                                  },
                                                  validator: (name) => validateNonEmpty(name!),
                                                  prefixIcon: "",
                                                  sufficIcon: ""),
                                              Container(
                                                  margin: EdgeInsets.only(top: 5,bottom: 5),
                                                  child: mediumText("Fax:", color: kBlackColor,size: size.shortestSide < shortestSideCheck ? 16 : 22)),
                                              RoundedInputField(
                                                  hintText: "Fax",
                                                  hintTextSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                                  textSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                                  hintTextColor: Colors.black.withOpacity(0.5),
                                                  textColor: kBlackColor,
                                                  onChanged: (onChanged){
                                                    provider.postEmployeeModel.fax=onChanged;
                                                  },
                                                  onSaved: (onSaved){
                                                    if(onSaved != null){
                                                      provider.postEmployeeModel.fax=onSaved;
                                                    }
                                                  },
                                                  validator: (name) => validateNonEmpty(name!),
                                                  prefixIcon: "",
                                                  sufficIcon: ""),
                                              Container(
                                                  margin: EdgeInsets.only(top: 5,bottom: 5),
                                                  child: mediumText("Position:", color: kBlackColor,size: size.shortestSide < shortestSideCheck ? 16 : 22)),
                                              RoundedInputField(
                                                  hintText: "Position",
                                                  textSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                                  hintTextSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                                  hintTextColor: Colors.black.withOpacity(0.5),
                                                  textColor: kBlackColor,
                                                  onChanged: (onChanged){
                                                    provider.postEmployeeModel.position=onChanged;
                                                  },
                                                  onSaved: (onSaved){
                                                    if(onSaved != null){
                                                      provider.postEmployeeModel.position=onSaved;
                                                    }
                                                  },
                                                  validator: (name) => validateNonEmpty(name!),
                                                  prefixIcon: "",
                                                  sufficIcon: ""),
                                              Container(
                                                  margin: EdgeInsets.only(top: 5,bottom: 5),
                                                  child: mediumText("Department:", color: kBlackColor,size: size.shortestSide < shortestSideCheck ? 16 : 22)),
                                              RoundedInputField(
                                                  hintText: "Department",
                                                  hintTextSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                                  textSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                                  hintTextColor: Colors.black.withOpacity(0.5),
                                                  textColor: kBlackColor,
                                                  onChanged: (onChanged){
                                                    provider.postEmployeeModel.department=onChanged;
                                                  },
                                                  onSaved: (onSaved){
                                                    if(onSaved != null){
                                                      provider.postEmployeeModel.department=onSaved;
                                                    }
                                                  },
                                                  validator: (name) => validateNonEmpty(name!),
                                                  prefixIcon: "",
                                                  sufficIcon: ""),

                                              Container(
                                                  margin: EdgeInsets.only(top: 5,bottom: 5),
                                                  child: mediumText("Location:", color: kBlackColor,size: size.shortestSide < shortestSideCheck ? 16 : 22)),
                                              DropdownButtonHideUnderline(
                                                child: DropdownButton2<Location>(
                                                  isExpanded: true,
                                                  hint: Text(
                                                    'Location',
                                                    style: TextStyle(
                                                      fontSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                                      color: Theme.of(context).hintColor,
                                                    ),
                                                  ),
                                                  items: widget.locationList
                                                      .map((item) => DropdownMenuItem<Location>(
                                                    value: item,
                                                    child: Text(
                                                      item!.addressFirst!,
                                                      style:  TextStyle(
                                                        fontSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                                      ),
                                                    ),
                                                  )).toList(),
                                                  value: Provider.of<DataProvider>(context,listen: true).selectedValueForLocation ?? null,
                                                  onChanged: (Location? value) {
                                                    setState(() {
                                                      provider.setSelectedValueForLocation( value) ;
                                                      selectedLocationId=value?.id;
                                                    });
                                                  },
                                                  buttonHeight: 40,
                                                  // buttonWidth: 200,
                                                  itemHeight: 40,
                                                  dropdownMaxHeight: 200,
                                                  // searchController: textEditingController,
                                                  // searchInnerWidget: Padding(
                                                  //   padding: const EdgeInsets.only(
                                                  //     top: 8,
                                                  //     bottom: 4,
                                                  //     right: 8,
                                                  //     left: 8,
                                                  //   ),
                                                  //   child: TextFormField(
                                                  //     controller: textEditingController,
                                                  //     decoration: InputDecoration(
                                                  //       isDense: true,
                                                  //       contentPadding: const EdgeInsets.symmetric(
                                                  //         horizontal: 10,
                                                  //         vertical: 8,
                                                  //       ),
                                                  //       hintText: 'Search for an item...',
                                                  //       hintStyle: const TextStyle(fontSize: 12),
                                                  //       border: OutlineInputBorder(
                                                  //         borderRadius: BorderRadius.circular(8),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  // searchMatchFn: (item, searchValue) {
                                                  //   return (item.value.toString().contains(searchValue));
                                                  // },
                                                  buttonDecoration: BoxDecoration(
                                                    border: Border.all(color: kBlackColor),
                                                    borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  //This to clear the search value when you close the menu
                                                  // onMenuStateChange: (isOpen) {
                                                  //   if (!isOpen) {
                                                  //     textEditingController.clear();
                                                  //   }
                                                  // },
                                                ),
                                              ),

                                              SizedBox(height: 20,),
                                              Center(
                                                child: SizedBox(
                                                  width: size.shortestSide < shortestSideCheck ? size.width * 0.3 : size.width * 0.22,
                                                  child: TextButtonWidget(
                                                      text: "Add",
                                                      textSize: size.shortestSide < shortestSideCheck ? 16 : 22,
                                                      onPress: () async{
                                                        if(!_formKey2.currentState!.validate()){
                                                          return;
                                                        }
                                                        _formKey2.currentState!.save();

                                                        if(provider.selectedValueForLocation == null){
                                                          provider.showSnackbar(context, "Please select location", kRedColor);
                                                        }else{
                                                          await Provider.of<EmployeeApis>(context,listen: false).createEmployee(
                                                              context,
                                                              provider.loginModel!.token!,
                                                              provider.companyId!,
                                                          selectedLocationId!);
                                                        }
                                                      }),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                            }),
                      ),
                      SizedBox(
                        width: size.shortestSide < shortestSideCheck ? size.width * 0.35: size.width * 0.25,
                        child: TextButtonWidget(
                            text: "Finish",
                            textSize: size.shortestSide < shortestSideCheck ? 16 : 22,
                            onPress: (){
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>DashboardScreen()), (route) => false);
                              // List<DropDownValueModel> employeeList=[];
                              // for(int i=0; i< provider.getEmployeeByIdModel!.data.length; i++){
                              //   employeeList.add(DropDownValueModel(name: "${provider.getEmployeeByIdModel!.data[i].firstName}", value: "${provider.getEmployeeByIdModel!.data[i].id}"));
                              // }
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>CompanyZammadDetails(
                              //   model: Provider.of<DataProvider>(context,listen: true).getEmployeeByIdModel!,
                              //   employeeList: employeeList,
                              // )));
                            }),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Center(child: mediumText("Employees",color: kBlackColor,size: 25)),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: Provider.of<DataProvider>(context,listen: true).getEmployeeByIdModel?.data.length,
                      itemBuilder: (context,index){
                        return InkWell(
                          onTap: () async{


                            showDialog(context: context, builder: (context){
                              // final List<Location?> items=widget.locationList;

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
                                          Center(child: mediumText("Add Employee Details", size: size.shortestSide < shortestSideCheck ? 18 : 24,color: kBlackColor,)),
                                          Container(
                                              margin: EdgeInsets.only(top: 5,bottom: 5),
                                              child: mediumText("First Name:", color: kBlackColor,size: size.shortestSide < shortestSideCheck ? 16 : 22)),
                                          RoundedInputField(
                                            initialValue: provider.getEmployeeByIdModel!.data[index].firstName,
                                              hintText: "First Name",
                                              textSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                              hintTextSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                              hintTextColor: Colors.black.withOpacity(0.5),
                                              textColor: kBlackColor,
                                              onChanged: (onChanged){
                                                provider.postEmployeeModel.firstName=onChanged;
                                              },
                                              onSaved: (onSaved){
                                                if(onSaved != null){
                                                  provider.postEmployeeModel.firstName=onSaved;
                                                }
                                              },
                                              validator: (name) => validateNonEmpty(name!),
                                              prefixIcon: "",
                                              sufficIcon: ""),
                                          Container(
                                              margin: EdgeInsets.only(top: 5,bottom: 5),
                                              child: mediumText("Last Name:", color: kBlackColor,size: size.shortestSide < shortestSideCheck ? 16 : 22)),
                                          RoundedInputField(
                                            initialValue: provider.getEmployeeByIdModel!.data[index].lastName,
                                              hintText: "Last Name",
                                              hintTextSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                              textSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                              hintTextColor: Colors.black.withOpacity(0.5),
                                              textColor: kBlackColor,
                                              onChanged: (onChanged){
                                                provider.postEmployeeModel.lastName=onChanged;
                                              },
                                              onSaved: (onSaved){
                                                if(onSaved != null){
                                                  provider.postEmployeeModel.lastName=onSaved;
                                                }
                                              },
                                              validator: (name) => validateNonEmpty(name!),
                                              prefixIcon: "",
                                              sufficIcon: ""),
                                          Container(
                                              margin: EdgeInsets.only(top: 5,bottom: 5),
                                              child: mediumText("Email:", color: kBlackColor,size: size.shortestSide < shortestSideCheck ? 16 : 22)),
                                          RoundedInputField(
                                            initialValue: provider.getEmployeeByIdModel!.data[index].email,
                                              keyboardType: TextInputType.emailAddress,
                                              hintText: "Email",
                                              textSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                              hintTextSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                              hintTextColor: Colors.black.withOpacity(0.5),
                                              textColor: kBlackColor,
                                              onChanged: (onChanged){
                                                provider.postEmployeeModel.email=onChanged;
                                              },
                                              onSaved: (onSaved){
                                                if(onSaved != null){
                                                  provider.postEmployeeModel.email=onSaved;
                                                }
                                              },
                                              validator: (name) => validateNonEmpty(name!),
                                              prefixIcon: "",
                                              sufficIcon: ""),
                                          Container(
                                              margin: EdgeInsets.only(top: 5,bottom: 5),
                                              child: mediumText("Mobile:", color: kBlackColor,size: size.shortestSide < shortestSideCheck ? 16 : 22)),
                                          RoundedInputField(
                                              initialValue: provider.getEmployeeByIdModel!.data[index].mobile,
                                              keyboardType: TextInputType.phone,
                                              hintText: "Mobile",
                                              hintTextSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                              textSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                              hintTextColor: Colors.black.withOpacity(0.5),
                                              textColor: kBlackColor,
                                              onChanged: (onChanged){
                                                provider.postEmployeeModel.mobile=onChanged;
                                              },
                                              onSaved: (onSaved){
                                                if(onSaved != null){
                                                  provider.postEmployeeModel.mobile=onSaved;
                                                }
                                              },
                                              validator: (name) => validateNonEmpty(name!),
                                              prefixIcon: "",
                                              sufficIcon: ""),
                                          Container(
                                              margin: EdgeInsets.only(top: 5,bottom: 5),
                                              child: mediumText("Fax:", color: kBlackColor,size: size.shortestSide < shortestSideCheck ? 16 : 22)),
                                          RoundedInputField(
                                              initialValue: provider.getEmployeeByIdModel!.data[index].fax,
                                              hintText: "Fax",
                                              textSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                              hintTextSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                              hintTextColor: Colors.black.withOpacity(0.5),
                                              textColor: kBlackColor,
                                              onChanged: (onChanged){
                                                provider.postEmployeeModel.fax=onChanged;
                                              },
                                              onSaved: (onSaved){
                                                if(onSaved != null){
                                                  provider.postEmployeeModel.fax=onSaved;
                                                }
                                              },
                                              validator: (name) => validateNonEmpty(name!),
                                              prefixIcon: "",
                                              sufficIcon: ""),
                                          Container(
                                              margin: EdgeInsets.only(top: 5,bottom: 5),
                                              child: mediumText("Position:", color: kBlackColor,size: size.shortestSide < shortestSideCheck ? 16 : 22)),
                                          RoundedInputField(
                                              initialValue: provider.getEmployeeByIdModel!.data[index].position,
                                              hintText: "Position",
                                              hintTextSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                              textSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                              hintTextColor: Colors.black.withOpacity(0.5),
                                              textColor: kBlackColor,
                                              onChanged: (onChanged){
                                                provider.postEmployeeModel.position=onChanged;
                                              },
                                              onSaved: (onSaved){
                                                if(onSaved != null){
                                                  provider.postEmployeeModel.position=onSaved;
                                                }
                                              },
                                              validator: (name) => validateNonEmpty(name!),
                                              prefixIcon: "",
                                              sufficIcon: ""),
                                          Container(
                                              margin: EdgeInsets.only(top: 5,bottom: 5),
                                              child: mediumText("Department:", color: kBlackColor,size: size.shortestSide < shortestSideCheck ? 16 : 22)),
                                          RoundedInputField(
                                              initialValue: provider.getEmployeeByIdModel!.data[index].department,
                                              hintText: "Department",
                                              textSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                              hintTextSize: size.shortestSide < shortestSideCheck ? 14 : 20,
                                              hintTextColor: Colors.black.withOpacity(0.5),
                                              textColor: kBlackColor,
                                              onChanged: (onChanged){
                                                provider.postEmployeeModel.department=onChanged;
                                              },
                                              onSaved: (onSaved){
                                                if(onSaved != null){
                                                  provider.postEmployeeModel.department=onSaved;
                                                }
                                              },
                                              validator: (name) => validateNonEmpty(name!),
                                              prefixIcon: "",
                                              sufficIcon: ""),

                                          SizedBox(height: 20,),
                                          Center(
                                            child: SizedBox(
                                              width: size.shortestSide < shortestSideCheck ? size.width * 0.3 : size.width * 0.22,
                                              child: TextButtonWidget(
                                                  text: "Add",
                                                  textSize: size.shortestSide < shortestSideCheck ? 16 : 22,
                                                  onPress: () async{
                                                    if(!_formKey2.currentState!.validate()){
                                                      return;
                                                    }
                                                    _formKey2.currentState!.save();


                                                    FocusScope.of(context).requestFocus(FocusNode());
                                                      await Provider.of<EmployeeApis>(context,listen: false).updateEmployee(
                                                          context,
                                                        provider.getEmployeeByIdModel!.data[index].id!,
                                                          provider.loginModel!.token!,
                                                          provider.getEmployeeByIdModel!.data[index].locationId!,
                                                        provider.getEmployeeByIdModel!.data[index].companyId!,);

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
                              children: [
                                Align(
                                  alignment:Alignment.topRight,
                                  child: IconButton(
                                    icon: Icon(Icons.delete, color: kOrangeColor,),
                                    constraints: BoxConstraints(),
                                    padding: EdgeInsets.zero,
                                    onPressed: () async{
                                      await Provider.of<EmployeeApis>(context,listen: false).deleteEmployee(context,
                                          provider.getEmployeeByIdModel!.data[index].id!,
                                      provider.loginModel!.token!);
                                      setState((){});
                                    },
                                  ),
                                ),
                                Row(
                                  children: [
                                    mediumText("Name: ",color: kBlackColor,maxLines: 2,softWrap: false),
                                    Expanded(
                                        child: mediumText("${provider.getEmployeeByIdModel?.data[index].firstName} ${provider.getEmployeeByIdModel?.data[index].lastName}",color: kBlackColor,maxLines: 2,softWrap: false,fontWeight: FontWeight.normal)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    mediumText("Email: ",color: kBlackColor,maxLines: 2,softWrap: false),
                                    Expanded(
                                        child: mediumText("${provider.getEmployeeByIdModel?.data[index].email}",color: kBlackColor,maxLines: 2,size: 16,softWrap: false,fontWeight: FontWeight.normal)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    mediumText("Department: ",color: kBlackColor,maxLines: 2,softWrap: false),
                                    Expanded(
                                        child: mediumText("${provider.getEmployeeByIdModel?.data[index].department}",color: kBlackColor,maxLines: 2,softWrap: false,fontWeight: FontWeight.normal)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    mediumText("Position: ",color: kBlackColor,maxLines: 2,softWrap: false),
                                    Expanded(
                                        child: mediumText("${provider.getEmployeeByIdModel?.data[index].position}",color: kBlackColor,maxLines: 2,softWrap: false,fontWeight: FontWeight.normal)),
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
        ));
  }
}
