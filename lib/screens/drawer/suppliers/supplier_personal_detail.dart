import 'package:docshero/components/constants.dart';
import 'package:docshero/components/providers/api_data_provider.dart';
import 'package:docshero/components/providers/data_provilder.dart';
import 'package:docshero/components/providers/supplier_apis.dart';
import 'package:docshero/components/reuseable_widgets/custom_loader.dart';
import 'package:docshero/components/reuseable_widgets/rounded_input_field.dart';
import 'package:docshero/components/reuseable_widgets/text_button_widget.dart';
import 'package:docshero/components/utils/validate_non_empty.dart';
import 'package:docshero/screens/drawer/suppliers/suppliers_home.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../../components/models/suppliers_models/supplier_input_data_model.dart';

class SupplierPersonalDetails extends StatefulWidget {
  SupplierPersonalDetails({
    this.checkForUpdate=false,
    Key? key}) : super(key: key);

  bool checkForUpdate;
  @override
  State<SupplierPersonalDetails> createState() => _SupplierPersonalDetailsState();
}

class _SupplierPersonalDetailsState extends State<SupplierPersonalDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();
  late SingleValueDropDownController _cnt;
  late MultiValueDropDownController _cntMulti;

  FocusNode searchFocusNode2 = FocusNode();
  FocusNode textFieldFocusNode2 = FocusNode();
  late SingleValueDropDownController _cnt2;
  late MultiValueDropDownController _cntMulti2;

  FocusNode searchFocusNode3 = FocusNode();
  FocusNode textFieldFocusNode3 = FocusNode();
  late SingleValueDropDownController _cnt3;
  late MultiValueDropDownController _cntMulti3;
  SupplierInputDataModel? supplierInputDataModel;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cnt = SingleValueDropDownController();
    _cntMulti = MultiValueDropDownController();
    _cnt2 = SingleValueDropDownController();
    _cntMulti2 = MultiValueDropDownController();
    _cnt3 = SingleValueDropDownController();
    _cntMulti3 = MultiValueDropDownController();
    // updateData();
  }
  @override
  void dispose() {
    _cnt.dispose();
    _cntMulti.dispose();
    _cnt2.dispose();
    _cntMulti2.dispose();
    _cnt3.dispose();
    _cntMulti3.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    DataProvider provider=Provider.of<DataProvider>(context,listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteColor,
        appBar: AppBar(
          centerTitle: true,
          title: mediumText("Supplier",color: kWhiteColor,size: size.shortestSide < shortestSideCheck ? 25 : 35,),
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
            // await provider.data();
            return true;
          },
          child: Container(
            padding: EdgeInsets.only(left: 20,right: 20),
            margin: EdgeInsets.only(top: 10),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: largerText("Fill Supplier Details",
                            color: kBlueColor,
                            size: size.width * 0.07,
                            fontWeight: FontWeight.normal)),
                    Container(
                        margin: EdgeInsets.only(top: 5,bottom: 5),
                        child: mediumText("Name:", color: kBlueColor,size: 16)),
                    RoundedInputField(
                        // initialValue: provider.name,
                        hintText: "Name",
                        hintTextColor: Colors.black.withOpacity(0.5),
                        textColor: kBlackColor,
                        onChanged: (onChanged) async{
                          provider.setName(onChanged);
                          provider.name;
                          provider.supplierInputDataModel.supplierName=onChanged;

                        },
                        onSaved: (onSaved){},
                        validator: (name) => validateNonEmpty(name!),
                        prefixIcon: "",
                        sufficIcon: ""),
                    Container(
                        margin: EdgeInsets.only(top: 5,bottom: 5),
                        child: mediumText("Type:", color: kBlueColor,size: 16)),
                    SizedBox(
                      // height: size.height * 0.05,
                      child: DropDownTextField(
                        // initialValue: provider.type,
                        controller: _cnt,
                        clearOption: true,
                        enableSearch: false,
                        clearIconProperty: IconProperty(color: Colors.green),
                        textFieldDecoration: InputDecoration(
                            constraints: BoxConstraints(),
                            contentPadding: EdgeInsets.only(left: 12,right: 12),
                            hintText: "${provider.type == null ? "Type" : provider.type}",
                            isDense: true,
                            hintStyle: TextStyle(
                              color: provider.type == null ? Colors.black.withOpacity(0.5) : Colors.black,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: kBlackColor
                                )
                            )
                        ),
                        padding: EdgeInsets.zero,
                        searchDecoration: const InputDecoration(
                            hintText: "Search..."),
                        validator: (value) => validateNonEmpty(value!),
                        dropDownItemCount: 6,
                        dropDownList: const [
                          DropDownValueModel(name: 'On premise company', value: "premise"),
                          DropDownValueModel(name: 'Private cloud company', value: "private"),
                          DropDownValueModel(name: 'Public cloud company', value: "public"),
                        ],
                        onChanged: (val) {
                          if(val != ""){
                            provider.supplierInputDataModel.type = _cnt.dropDownValue!.value.toString();
                          }
                        },
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 5,bottom: 5),
                        child: mediumText("Type:", color: kBlueColor,size: 16)),
                    SizedBox(
                      // height: size.height * 0.05,
                      child: DropDownTextField(
                        // initialValue: "name4",
                        controller: _cnt2,
                        clearOption: true,
                        enableSearch: true,
                        clearIconProperty: IconProperty(color: Colors.green),
                        textFieldDecoration: InputDecoration(
                            hintText: "${provider.customerType == null ? "Supplier Type" : provider.customerType}",
                            isDense: true,
                            hintStyle: TextStyle(
                              color: provider.customerType == null ? Colors.black.withOpacity(0.5) : Colors.black,
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
                        dropDownList: const [
                          DropDownValueModel(name: 'Supplier', value: "supplier"),
                          DropDownValueModel(name: 'Lead', value: "lead"),
                        ],
                        onChanged: (val) {
                          if(val != ""){
                            provider.supplierInputDataModel.supplierType=_cnt2.dropDownValue!.value.toString();

                          }

                        },
                      ),
                    ),

                    Container(
                        margin: EdgeInsets.only(top: 5,bottom: 5),
                        child: mediumText("URL:", color: kBlueColor,size: 16)),
                    RoundedInputField(
                        initialValue: provider.url,
                        hintText: "URL",
                        hintTextColor: Colors.black.withOpacity(0.5),
                        textColor: kBlackColor,
                        onChanged: (onChanged){
                          provider.supplierInputDataModel.url=onChanged;
                        },
                        onSaved: (onSaved){},
                        validator: (name) => validateNonEmpty(name!),
                        prefixIcon: "",
                        sufficIcon: ""),
                    Container(
                        margin: EdgeInsets.only(top: 5,bottom: 5),
                        child: mediumText("Address:", color: kBlueColor,size: 16)),
                    RoundedInputField(
                        initialValue: provider.address1,
                        hintText: "Address Line 1",
                        hintTextColor: Colors.black.withOpacity(0.5),
                        textColor: kBlackColor,
                        onChanged: (onChanged){
                          provider.supplierInputDataModel.addressFirst=onChanged;
                        },
                        onSaved: (onSaved){},
                        validator: (name) => validateNonEmpty(name!),
                        prefixIcon: "",
                        sufficIcon: ""),
                    Container(
                        margin: EdgeInsets.only(top: 5,bottom: 5),
                        child: mediumText("Address:", color: kBlueColor,size: 16)),
                    RoundedInputField(
                        initialValue: provider.address2,
                        hintText: "Address Line 2",
                        hintTextColor: Colors.black.withOpacity(0.5),
                        textColor: kBlackColor,
                        onChanged: (onChanged){
                          provider.supplierInputDataModel.addressSecond=onChanged;
                        },
                        onSaved: (onSaved){},
                        validator: (name) {},
                        prefixIcon: "",
                        sufficIcon: ""),
                    Container(
                        margin: EdgeInsets.only(top: 5,bottom: 5),
                        child: mediumText("City:", color: kBlueColor,size: 16)),
                    RoundedInputField(
                        initialValue: provider.city,
                        hintText: "City",
                        hintTextColor: Colors.black.withOpacity(0.5),
                        textColor: kBlackColor,
                        onChanged: (onChanged){
                          provider.supplierInputDataModel.city=onChanged;
                        },
                        onSaved: (onSaved){},
                        validator: (name) => validateNonEmpty(name!),
                        prefixIcon: "",
                        sufficIcon: ""),
                    Container(
                        margin: EdgeInsets.only(top: 5,bottom: 5),
                        child: mediumText("Zip:", color: kBlueColor,size: 16)),
                    RoundedInputField(
                        initialValue: provider.zip,
                        hintText: "Zip",
                        hintTextColor: Colors.black.withOpacity(0.5),
                        textColor: kBlackColor,
                        onChanged: (onChanged){
                          provider.supplierInputDataModel.zip=onChanged;
                        },
                        onSaved: (onSaved){},
                        validator: (name) => validateNonEmpty(name!),
                        prefixIcon: "",
                        sufficIcon: ""),
                    Container(
                        margin: EdgeInsets.only(top: 5,bottom: 5),
                        child: mediumText("Country:", color: kBlueColor,size: 16)),
                    RoundedInputField(
                        initialValue: provider.country,
                        hintText: "Country",
                        hintTextColor: Colors.black.withOpacity(0.5),
                        textColor: kBlackColor,
                        onChanged: (onChanged){
                          provider.supplierInputDataModel.country=onChanged;
                        },
                        onSaved: (onSaved){},
                        validator: (name) => validateNonEmpty(name!),
                        prefixIcon: "",
                        sufficIcon: ""),
                    Container(
                        margin: EdgeInsets.only(top: 5,bottom: 5),
                        child: mediumText("State:", color: kBlueColor,size: 16)),
                    RoundedInputField(
                        initialValue: provider.state,
                        hintText: "State",
                        hintTextColor: Colors.black.withOpacity(0.5),
                        textColor: kBlackColor,
                        onChanged: (onChanged){
                          provider.supplierInputDataModel.state=onChanged;
                        },
                        onSaved: (onSaved){},
                        validator: (name) => validateNonEmpty(name!),
                        prefixIcon: "",
                        sufficIcon: ""),
                    Container(
                        margin: EdgeInsets.only(top: 5,bottom: 5),
                        child: mediumText("VAT ID:", color: kBlueColor,size: 16)),
                    RoundedInputField(
                        initialValue: provider.vatId,
                        hintText: "VAT ID",
                        hintTextColor: Colors.black.withOpacity(0.5),
                        textColor: kBlackColor,
                        onChanged: (onChanged){
                          provider.supplierInputDataModel.vatId=onChanged;
                        },
                        onSaved: (onSaved){},
                        validator: (name) => validateNonEmpty(name!),
                        prefixIcon: "",
                        sufficIcon: ""),
                    Container(
                        margin: EdgeInsets.only(top: 5,bottom: 5),
                        child: mediumText("Phone:", color: kBlueColor,size: 16)),
                    RoundedInputField(
                        initialValue: provider.phone,
                        hintText: "Phone",
                        keyboardType: TextInputType.phone,
                        hintTextColor: Colors.black.withOpacity(0.5),
                        textColor: kBlackColor,
                        onChanged: (onChanged){
                          provider.supplierInputDataModel.phone=onChanged;
                        },
                        onSaved: (onSaved){},
                        validator: (name) => validateNonEmpty(name!),
                        prefixIcon: "",
                        sufficIcon: ""),
                    Container(
                        margin: EdgeInsets.only(top: 5,bottom: 5),
                        child: mediumText("Fax:", color: kBlueColor,size: 16)),
                    RoundedInputField(
                        initialValue: provider.fax.toString() == "null" ? null : provider.fax.toString(),
                        keyboardType: TextInputType.number,
                        hintText: "Fax",
                        hintTextColor: Colors.black.withOpacity(0.5),
                        textColor: kBlackColor,
                        onChanged: (onChanged){
                          if(onChanged != ""){
                            provider.supplierInputDataModel.fax=onChanged;
                          }
                        },
                        onSaved: (onSaved){},
                        validator: (name) => validateNonEmpty(name!),
                        prefixIcon: "",
                        sufficIcon: ""),

                    widget.checkForUpdate == true ? SizedBox() : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 5,bottom: 5),
                            child: mediumText("Terms of Payment:", color: kBlueColor,size: 16)),
                        SizedBox(
                          // height: size.height * 0.05,
                          child: DropDownTextField(
                            initialValue: "name4",
                            // controller: _cnt3,
                            clearOption: true,
                            enableSearch: true,
                            clearIconProperty: IconProperty(color: Colors.green),
                            textFieldDecoration: InputDecoration(
                                hintText: "${provider.termsOfPayment == null ? "Terms of Payment" : provider.termsOfPayment}",
                                isDense: true,
                                hintStyle: TextStyle(
                                  color: provider.termsOfPayment == null ? Colors.black.withOpacity(0.5) : Colors.black,
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
                            validator: (value) {},
                            dropDownItemCount: 6,
                            dropDownList: List.generate(provider.termsOfPaymentModel!.data!.length, (index) {
                              return DropDownValueModel(name: "${provider.termsOfPaymentModel?.data?[index].paymentTerms}", value: "${provider.termsOfPaymentModel?.data?[index].id}");
                            }),
                            onChanged: (val) {
                              if(val != ""){
                                provider.supplierInputDataModel.termsOfPayment=int.parse(val.value);
                              }
                            },
                          ),
                        ),
                      ],
                    ),


                    SizedBox(height: 15,),
                    Consumer<DataProvider>(
                        builder: (context,liveData, snap) {
                          return Center(
                            child: Container(
                              width: size.width * 0.5,
                              margin: EdgeInsets.only(bottom: 10),
                              child: TextButtonWidget(

                                  text: "Create and Proceed" ,
                                  onPress: () async{
                                    if(!_formKey.currentState!.validate()){
                                      return;
                                    }
                                    _formKey.currentState!.save();

                                    FocusScope.of(context).requestFocus(FocusNode());
                                    Get.dialog(CustomLoader());
                                    bool check=await Provider.of<SupplierApis>(context,listen: false).createSupplier(context, provider.loginModel!.token!);
                                    Get.back();
                                    if(check==true){
                                      Navigator.pop(context);
                                    }
                                  }),
                            ),
                          );
                        }
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
