import 'dart:convert';

import 'package:docshero/components/providers/contact_report_apis.dart';
import 'package:docshero/components/providers/data_provilder.dart';
import 'package:docshero/components/providers/employee_apis.dart';
import 'package:docshero/components/reuseable_widgets/rounded_input_field.dart';
import 'package:docshero/components/reuseable_widgets/text_button_widget.dart';
import 'package:docshero/components/utils/validate_non_empty.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:provider/provider.dart';

import '../../../components/constants.dart';

class CreateContactReport extends StatefulWidget {
   CreateContactReport({Key? key}) : super(key: key);

  @override
  State<CreateContactReport> createState() => _CreateContactReportState();
}

class _CreateContactReportState extends State<CreateContactReport> {
  final _controller= quill.QuillController.basic();
  late SingleValueDropDownController _cnt3;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? subjectText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cnt3 = SingleValueDropDownController();
  }
  @override
  void dispose() {
    _cnt3.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    DataProvider dataProvider=Provider.of<DataProvider>(context,listen: false);
    return SafeArea(child:
    Scaffold(
      appBar: AppBar(
        backgroundColor: kBlueColor,
        title: mediumText("Create",color: kWhiteColor,size: 25),
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: () async{
          await Provider.of<ContactReportApis>(context,listen: false).clearFormValues(context);
          return true;
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RoundedInputField(
                    initialValue: dataProvider.contactReportinitialValueSubjectText,
                      hintText: "Subject...",
                      hintTextColor: Colors.black.withOpacity(0.5),
                      onChanged: (onChanged){
                        subjectText=onChanged;
                        dataProvider.setContactReportSubjectText(onChanged);
                      },
                      textColor: kBlackColor,
                      onSaved: (onSaved){
                        if(onSaved != null){
                          subjectText=onSaved;
                          dataProvider.setContactReportSubjectText(onSaved);
                        }
                      },
                      validator: (validator) => validateNonEmpty(validator!),
                      prefixIcon: "",
                      sufficIcon: ""),
                  quill.QuillToolbar.basic(
                      controller: _controller,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5,right: 5,top: 7,bottom: 7),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: kBlackColor)
                    ),
                    child: quill.QuillEditor.basic(
                        controller: _controller,
                        readOnly: false,
                    ),
                  ),

                  SizedBox(height: 15,),
                  SizedBox(
                    // height: size.height * 0.05,
                    child: DropDownTextField(
                      initialValue: dataProvider.contactReportinitialValueType,
                      // controller: _cnt3,
                      clearOption: true,
                      // enableSearch: true,
                      clearIconProperty: IconProperty(color: Colors.green),
                      textFieldDecoration: InputDecoration(
                          hintText: "Type",
                          isDense: true,
                          hintStyle: TextStyle(
                            // color: provider.termsOfPayment == null ? Colors.black.withOpacity(0.5) : Colors.black,
                          ),
                          constraints: BoxConstraints(),
                          contentPadding: EdgeInsets.only(left: 12,right: 12),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kBlackColor
                              )
                          )
                      ),
                      validator: (value)=> validateNonEmpty(value!),
                      dropDownItemCount: 6,
                      dropDownList: const [
                        DropDownValueModel(name: 'Company', value: "customer"),
                        DropDownValueModel(name: 'Lead', value: "lead"),
                      ],
                      onChanged: (val) {
                        if(val != ""){
                          dataProvider.setContactReportType(val.value);
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 5,),
                  SizedBox(
                    // height: size.height * 0.05,
                    child: DropDownTextField(
                      initialValue: "${dataProvider.contactReportinitialValueCompany}",
                      // controller: _cnt3,
                      clearOption: true,
                      enableSearch: true,
                      clearIconProperty: IconProperty(color: Colors.green),
                      textFieldDecoration: InputDecoration(
                        hintText: "Company",
                          isDense: true,
                          hintStyle: TextStyle(
                            // color: provider.termsOfPayment == null ? Colors.black.withOpacity(0.5) : Colors.black,
                          ),
                          constraints: BoxConstraints(),
                          contentPadding: EdgeInsets.only(left: 12,right: 12),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kBlackColor
                              )
                          )
                      ),
                      searchDecoration: const InputDecoration(
                          hintText: "Search..."),
                      validator: (value) => validateNonEmpty(value!),
                      dropDownItemCount: 6,
                      dropDownList: Provider.of<DataProvider>(context,listen: false).allCompanyDropDownModel,
                      onChanged: (val) async{
                        dataProvider.companyEmployeeDropDownModel=[];
                        if(val != ""){
                          await Provider.of<EmployeeApis>(context,listen: false).getEmployeeById(context, dataProvider.loginModel!.token!, val.value);
                          dataProvider.setContactReportCompany(val);
                        }else{
                          dataProvider.companyEmployeeDropDownModel.clear();

                        }
                      },
                    ),
                  ),
                  SizedBox(height: 5,),
                  DropDownTextField.multiSelection(
                    // controller: _cntMulti,
                    initialValue: dataProvider.contactReportinitialValueTalkedToPeople,
                    dropDownList: Provider.of<DataProvider>(context,listen: true).companyEmployeeDropDownModel,
                    textFieldDecoration: InputDecoration(
                      hintText: "Talked to People",
                        constraints: BoxConstraints(),
                        contentPadding: EdgeInsets.only(left: 12,right: 12),
                        isDense: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: kBlackColor
                            )
                        )
                    ),
                    validator: (value) => validateNonEmpty(value!),
                    onChanged: (val) {
                      dataProvider.setContactReportTalkToPeople(val);
                    },
                  ),
                  SizedBox(height: 5,),
                  DropDownTextField.multiSelection(
                    // controller: _cntMulti,
                    initialValue: dataProvider.contactReportinitialValueEmployee,
                    dropDownList: dataProvider.docsHeroAllEmployeesDropdownModel,
                    textFieldDecoration: InputDecoration(
                        hintText: "Employee",
                        constraints: BoxConstraints(),
                        contentPadding: EdgeInsets.only(left: 12,right: 12),
                        isDense: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: kBlackColor
                            )
                        )
                    ),
                    validator: (value) => validateNonEmpty(value!),
                    onChanged: (val) {
                      if(val.length == 0){
                        dataProvider.setContactReportEmployee([]);
                      }else{
                        dataProvider.setContactReportEmployee(val);
                      }

                    },
                  ),
                  SizedBox(height: 5,),
                  SizedBox(
                    // height: size.height * 0.05,
                    child: DropDownTextField(
                       initialValue: dataProvider.contactReportinitialValueCreatedBy,
                      // controller: _cnt3,
                      clearOption: true,
                      enableSearch: true,
                      clearIconProperty: IconProperty(color: Colors.green),
                      textFieldDecoration: InputDecoration(
                          hintText: "Created By",
                          isDense: true,
                          hintStyle: TextStyle(
                            // color: provider.termsOfPayment == null ? Colors.black.withOpacity(0.5) : Colors.black,
                          ),
                          constraints: BoxConstraints(),
                          contentPadding: EdgeInsets.only(left: 12,right: 12),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kBlackColor
                              )
                          )
                      ),
                      searchDecoration: const InputDecoration(
                          hintText: "Search..."),
                      validator: (value) => validateNonEmpty(value!),
                      dropDownItemCount: 6,
                      dropDownList: dataProvider.docsHeroAllEmployeesDropdownModel,
                      onChanged: (val) {
                        if(val != ""){
                          dataProvider.setContactReportCreatedBy(val);
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 5,),
                  SizedBox(
                    // height: size.height * 0.05,
                    child: DropDownTextField(
                      initialValue: dataProvider.contactReportinitialValuePriority,
                      // controller: _cnt3,
                      clearOption: true,
                      clearIconProperty: IconProperty(color: Colors.green),
                      textFieldDecoration: InputDecoration(
                          hintText: "Priority",
                          isDense: true,
                          hintStyle: TextStyle(
                            // color: provider.termsOfPayment == null ? Colors.black.withOpacity(0.5) : Colors.black,
                          ),
                          constraints: BoxConstraints(),
                          contentPadding: EdgeInsets.only(left: 12,right: 12),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kBlackColor
                              )
                          )
                      ),
                      validator: (value)=> validateNonEmpty(value!),
                      dropDownItemCount: 6,
                      dropDownList: const [
                        DropDownValueModel(name: 'Low', value: "low"),
                        DropDownValueModel(name: 'Medium', value: "medium"),
                        DropDownValueModel(name: 'High', value: "high"),
                      ],
                      onChanged: (val) {
                        if(val != ""){
                          dataProvider.setContactReportPriority(val.value);
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 5,),
                  SizedBox(
                    // height: size.height * 0.05,
                    child: DropDownTextField(
                      initialValue: dataProvider.contactReportinitialValueCategory,
                      // controller: _cnt3,
                      clearOption: true,
                      enableSearch: true,
                      clearIconProperty: IconProperty(color: Colors.green),
                      textFieldDecoration: InputDecoration(
                          hintText: "Category",
                          isDense: true,
                          hintStyle: TextStyle(
                            // color: provider.termsOfPayment == null ? Colors.black.withOpacity(0.5) : Colors.black,
                          ),
                          constraints: BoxConstraints(),
                          contentPadding: EdgeInsets.only(left: 12,right: 12),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kBlackColor
                              )
                          )
                      ),
                      searchDecoration: const InputDecoration(
                          hintText: "Search..."),
                      validator: (value)=> validateNonEmpty(value!),
                      dropDownItemCount: 6,
                      dropDownList: dataProvider.docsHeroCategoryDropdownModel,
                      onChanged: (val) {
                        if(val != ""){
                         dataProvider.setContactReportCategory(val);
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 5,),
                  SizedBox(
                    // height: size.height * 0.05,
                    child: DropDownTextField(
                      initialValue: dataProvider.contactReportinitialValueContactType,
                      // controller: _cnt3,
                      clearOption: true,
                      clearIconProperty: IconProperty(color: Colors.green),
                      textFieldDecoration: InputDecoration(
                          hintText: "Contact Type",
                          isDense: true,
                          hintStyle: TextStyle(
                            // color: provider.termsOfPayment == null ? Colors.black.withOpacity(0.5) : Colors.black,
                          ),
                          constraints: BoxConstraints(),
                          contentPadding: EdgeInsets.only(left: 12,right: 12),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kBlackColor
                              )
                          )
                      ),

                      validator: (value) => validateNonEmpty(value!),
                      dropDownItemCount: 6,
                      dropDownList: const [
                        DropDownValueModel(name: 'Mail', value: "mail"),
                        DropDownValueModel(name: 'Phone', value: "phone"),
                        DropDownValueModel(name: 'Facebook', value: "facebook"),
                        DropDownValueModel(name: 'Visit', value: "visit"),
                      ],
                      onChanged: (val) {
                        if(val != ""){
                          dataProvider.setContactReportContactType(val.value);
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 5,),
                  SizedBox(
                    // height: size.height * 0.05,
                    child: DropDownTextField(
                      initialValue: dataProvider.contactReportinitialValueInitiatedBy,
                      // controller: _cnt3,
                      clearOption: true,
                      clearIconProperty: IconProperty(color: Colors.green),
                      textFieldDecoration: InputDecoration(
                          hintText: "Initiated By",
                          isDense: true,
                          hintStyle: TextStyle(
                            // color: provider.termsOfPayment == null ? Colors.black.withOpacity(0.5) : Colors.black,
                          ),
                          constraints: BoxConstraints(),
                          contentPadding: EdgeInsets.only(left: 12,right: 12),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kBlackColor
                              )
                          )
                      ),
                      validator: (value) => validateNonEmpty(value!),
                      dropDownItemCount: 6,
                      dropDownList: const [
                        DropDownValueModel(name: 'Customer', value: "customer"),
                        DropDownValueModel(name: 'DocsHero', value: "docshero"),
                      ],
                      onChanged: (val) {
                        if(val != ""){
                          dataProvider.setContactReportInitiatedBy(val.value);
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextButtonWidget(
                      text: "Create Contact Report",
                      onPress: () async{
                        if(!_formKey.currentState!.validate()){
                          return;
                        }
                        _formKey.currentState!.save();

                        if(_controller.document.isEmpty()){
                          dataProvider.showSnackbar(context, "Please enter valid data", kRedColor);
                        }else{
                           await Provider.of<ContactReportApis>(context,listen: false).createContactReport(context, dataProvider.loginModel!.token!);
                        }

                      })
                ],

              ),
            ),
          ),
        ),
      ),
    ));
  }
}
