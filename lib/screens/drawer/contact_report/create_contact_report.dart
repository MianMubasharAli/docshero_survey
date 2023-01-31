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
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../components/constants.dart';

class CreateContactReport extends StatefulWidget {
   CreateContactReport({
     this.isUpdate=false,
     Key? key}) : super(key: key);

   bool isUpdate;
  @override
  State<CreateContactReport> createState() => _CreateContactReportState();
}

class _CreateContactReportState extends State<CreateContactReport> {
  final _controller= quill.QuillController(
    document: quill.Document.fromJson(jsonDecode(Provider.of<DataProvider>(Get.context!,listen: false).contactReportinitialValueQuillText ?? "[{\"insert\":\"\\n\"}]")),
    selection: TextSelection.collapsed(offset: 0),
  );
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
        title: mediumText("Create",color: kWhiteColor,size: size.shortestSide < shortestSideCheck ? 25 : 35),
        centerTitle: true,
        toolbarHeight: size.shortestSide < shortestSideCheck ? 70.0 : 100,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp,color: kWhiteColor,size: size.shortestSide < shortestSideCheck ? 25 :45,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
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
                      textSize:  size.shortestSide < shortestSideCheck ? 14 : 25,
                      hintTextSize: size.shortestSide < shortestSideCheck ? 14 : 25,
                      hintTextColor: Colors.black.withOpacity(0.5),
                      onChanged: (onChanged){
                        subjectText=onChanged;
                        dataProvider.setContactReportSubjectText(onChanged);
                        dataProvider.setContactReportinitialValueSubjectText(onChanged);
                      },
                      textColor: kBlackColor,
                      onSaved: (onSaved){
                        if(onSaved != null){
                          subjectText=onSaved;
                          dataProvider.setContactReportSubjectText(onSaved);
                          dataProvider.setContactReportinitialValueSubjectText(onSaved);
                        }
                      },
                      validator: (validator) => validateNonEmpty(validator!),
                      prefixIcon: "",
                      sufficIcon: ""),

                  SizedBox(height: 15,),
                  quill.QuillToolbar.basic(
                      controller: _controller,
                    showSearchButton: false,
                    toolbarIconSize: size.shortestSide < shortestSideCheck ? 24 : 35,
                  ),
                  SizedBox(height: size.shortestSide < shortestSideCheck ? 5 : 15,),
                  Container(
                    padding: size.shortestSide < shortestSideCheck ? EdgeInsets.only(left: 5,right: 5,top: 7,bottom: 7) : EdgeInsets.only(left: 5,right: 5,top: 12,bottom: 12),
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

                  SizedBox(height: size.shortestSide < shortestSideCheck ? 15 : 25,),
                  SizedBox(
                    // height: size.height * 0.05,
                    child: DropDownTextField(
                      initialValue: dataProvider.contactReportinitialValueType,
                      // controller: _cnt3,
                      clearOption: true,
                      // enableSearch: true,
                      textStyle: TextStyle(
                        fontSize: size.shortestSide < shortestSideCheck ? 14 : 25
                      ),
                      clearIconProperty: IconProperty(color: Colors.green),
                      textFieldDecoration: InputDecoration(
                          hintText: "Type",
                          isDense: true,
                          hintStyle: TextStyle(
                            fontSize: size.shortestSide < shortestSideCheck ? 14 : 25
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
                          dataProvider.setContactReportinitialValueType(val.value);
                          dataProvider.singleContactReportModel?.modelData?.type=val.value;
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
                      textStyle: TextStyle(
                          fontSize: size.shortestSide < shortestSideCheck ? 14 : 25
                      ),
                      clearIconProperty: IconProperty(color: Colors.green),
                      textFieldDecoration: InputDecoration(
                        hintText: "Company",
                          isDense: true,
                          hintStyle: TextStyle(
                              fontSize: size.shortestSide < shortestSideCheck ? 14 : 25
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
                          dataProvider.setContactReportinitialValueCompany(val.value);
                          dataProvider.singleContactReportModel?.modelData?.companyId=val.value;
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
                    textStyle: TextStyle(
                        fontSize: size.shortestSide < shortestSideCheck ? 14 : 25
                    ),
                    textFieldDecoration: InputDecoration(
                      hintText: "Talked to People",
                        hintStyle: TextStyle(
                            fontSize: size.shortestSide < shortestSideCheck ? 14 : 25
                        ),
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
                        dataProvider.setContactReportTalkToPeople([]);
                        dataProvider.setContactReportinitialValueTalkedToPeople([]);
                        dataProvider.singleContactReportModel?.modelData?.companyEmployees=[];
                      }else{
                        dataProvider.setContactReportTalkToPeople(val);
                        List<String> list=[];
                        val.forEach((element){
                          list.add(element.value);
                        });
                        dataProvider.setContactReportinitialValueTalkedToPeople(list);
                        dataProvider.singleContactReportModel?.modelData?.companyEmployees=list;
                      }

                    },
                  ),
                  SizedBox(height: 5,),
                  DropDownTextField.multiSelection(
                    // controller: _cntMulti,
                    initialValue: dataProvider.contactReportinitialValueEmployee,
                    dropDownList: dataProvider.docsHeroAllEmployeesDropdownModel,
                    textStyle: TextStyle(
                        fontSize: size.shortestSide < shortestSideCheck ? 14 : 25
                    ),
                    textFieldDecoration: InputDecoration(
                        hintText: "Employee",
                        hintStyle: TextStyle(
                            fontSize: size.shortestSide < shortestSideCheck ? 14 : 25
                        ),
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
                      List<String> list=[];
                      val.forEach((element){
                        list.add(element.value);
                      });
                      if(val.length == 0){
                        dataProvider.setContactReportEmployee([]);
                        dataProvider.setContactReportinitialValueEmployee(list);
                        dataProvider.singleContactReportModel?.modelData?.employees=[];
                      }else{
                        dataProvider.setContactReportEmployee(val);
                        dataProvider.setContactReportinitialValueEmployee(list);
                        dataProvider.singleContactReportModel?.modelData?.employees=list;
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
                      textStyle: TextStyle(
                          fontSize: size.shortestSide < shortestSideCheck ? 14 : 25
                      ),
                      textFieldDecoration: InputDecoration(
                          hintText: "Created By",
                          isDense: true,
                          hintStyle: TextStyle(
                              fontSize: size.shortestSide < shortestSideCheck ? 14 : 25
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
                          dataProvider.setContactReportinitialValueCreatedBy(val.value);
                          dataProvider.singleContactReportModel?.modelData?.createdByEmployee=val.value;
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
                      textStyle: TextStyle(
                          fontSize: size.shortestSide < shortestSideCheck ? 14 : 25
                      ),
                      clearIconProperty: IconProperty(color: Colors.green),
                      textFieldDecoration: InputDecoration(
                          hintText: "Priority",
                          isDense: true,
                          hintStyle: TextStyle(
                              fontSize: size.shortestSide < shortestSideCheck ? 14 : 25
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
                          dataProvider.setContactReportinitialValuePriority(val.value);
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
                      textStyle: TextStyle(
                          fontSize: size.shortestSide < shortestSideCheck ? 14 : 25
                      ),
                      clearIconProperty: IconProperty(color: Colors.green),
                      textFieldDecoration: InputDecoration(
                          hintText: "Category",
                          isDense: true,
                          hintStyle: TextStyle(
                              fontSize: size.shortestSide < shortestSideCheck ? 14 : 25
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
                         dataProvider.setContactReportinitialValueCategory(val.value);
                         dataProvider.singleContactReportModel?.modelData?.categoryId=val.value;
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
                      textStyle: TextStyle(
                          fontSize: size.shortestSide < shortestSideCheck ? 14 : 25
                      ),
                      textFieldDecoration: InputDecoration(
                          hintText: "Contact Type",
                          isDense: true,
                          hintStyle: TextStyle(
                              fontSize: size.shortestSide < shortestSideCheck ? 14 : 25
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
                          dataProvider.setContactReportinitialValueContactType(val.value);
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
                      textStyle: TextStyle(
                          fontSize: size.shortestSide < shortestSideCheck ? 14 : 25
                      ),
                      clearIconProperty: IconProperty(color: Colors.green),
                      textFieldDecoration: InputDecoration(
                          hintText: "Initiated By",
                          isDense: true,
                          hintStyle: TextStyle(
                              fontSize: size.shortestSide < shortestSideCheck ? 14 : 25
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
                          dataProvider.setContactReportinitialValueInitiatedBy(val.value);
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextButtonWidget(
                      text: "Create Contact Report",
                      textSize: size.shortestSide < shortestSideCheck ? 16 : 25,
                      onPress: () async{
                        if(!_formKey.currentState!.validate()){
                          return;
                        }
                        _formKey.currentState!.save();


                        if(_controller.document.isEmpty()){
                          dataProvider.showSnackbar(context, "Please enter valid data", kRedColor);
                        }else{
                          String json=jsonEncode(_controller.document.toDelta().toJson());
                          dataProvider.setContactReportQuillText(json);
                          dataProvider.setContactReportinitialValueQuillText(json);
                          if(widget.isUpdate==true){
                            await Provider.of<ContactReportApis>(context,listen: false).updateContactReport(context, dataProvider.loginModel!.token!,dataProvider.singleContactReportModel!.modelData!.id!);
                          }else{
                            await Provider.of<ContactReportApis>(context,listen: false).createContactReport(context, dataProvider.loginModel!.token!);
                          }
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
