import 'package:docshero/components/constants.dart';
import 'package:docshero/components/providers/api_data_provider.dart';
import 'package:docshero/components/providers/data_provilder.dart';
import 'package:docshero/components/reuseable_widgets/rounded_input_field.dart';
import 'package:docshero/components/reuseable_widgets/text_button_widget.dart';
import 'package:docshero/components/utils/validate_non_empty.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompanyPersonalDetails extends StatefulWidget {
   CompanyPersonalDetails({
     this.checkForUpdate=false,
     Key? key}) : super(key: key);

   bool checkForUpdate;
  @override
  State<CompanyPersonalDetails> createState() => _CompanyPersonalDetailsState();
}

class _CompanyPersonalDetailsState extends State<CompanyPersonalDetails> {
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
  data(){
    DataProvider provider=Provider.of<DataProvider>(context,listen: false);
    provider.setName(null);
    provider.setType(null);
    provider.setCustomerType(null);
    provider.setUrl(null);
    provider.setAddess1(null);
    provider.setAddress2(null);
    provider.setCity(null);
    provider.setZip(null);
    provider.setCountry(null);
    provider.setState(null);
    provider.setPhone(null);
    provider.setVatId(null);
    provider.setFax(null);
    provider.setTermsOfPayment(null);
    provider.setComapnyId(null);
    provider.setCameBackCheck(false);
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
          title: mediumText("Company",color: kWhiteColor,size: 25,),
        ),
        body: WillPopScope(
          onWillPop: () async{
            await data();
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
                        child: largerText("Fill Personal Details",
                            color: kBlueColor,
                            size: size.width * 0.07,
                            fontWeight: FontWeight.normal)),
                    Container(
                        margin: EdgeInsets.only(top: 5,bottom: 5),
                        child: mediumText("Name:", color: kBlueColor,size: 16)),
                    RoundedInputField(
                      initialValue: provider.name,
                        hintText: "Name",
                        hintTextColor: Colors.black.withOpacity(0.5),
                        textColor: kBlackColor,
                        onChanged: (onChanged){
                          provider.setName(onChanged);
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
                            provider.setType(_cnt.dropDownValue!.value.toString());
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
                            hintText: "${provider.customerType == null ? "Customer Type" : provider.customerType}",
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
                            hintText: "enter your custom hint text here"),
                        validator: (value) => validateNonEmpty(value!),
                        dropDownItemCount: 6,
                        dropDownList: const [
                          DropDownValueModel(name: 'Customer', value: "Customer"),
                          DropDownValueModel(name: 'Lead', value: "LEAD"),
                        ],
                        onChanged: (val) {
                            if(val != ""){
                              provider.setCustomerType(_cnt2.dropDownValue!.name);
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
                          provider.setUrl(onChanged);
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
                          provider.setAddess1(onChanged);
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
                          provider.setAddress2(onChanged);
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
                          provider.setCity(onChanged);
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
                          provider.setZip(onChanged);
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
                          provider.setCountry(onChanged);
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
                          provider.setState(onChanged);
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
                          provider.setVatId(onChanged);
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
                          provider.setPhone(onChanged);
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
                          provider.setFax(int.parse(onChanged));
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
                            // initialValue: "name4",
                            controller: _cnt3,
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
                                hintText: "enter your custom hint text here"),
                            validator: (value) {},
                            dropDownItemCount: 6,
                            dropDownList: const [
                              DropDownValueModel(name: 'Sample', value: "Sample"),
                            ],
                            onChanged: (val) {
                              if(val != ""){
                                provider.setTermsOfPayment(_cnt3.dropDownValue!.name);
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

                                text: "Create and Proceed",
                                onPress: () async{
                                  if(!_formKey.currentState!.validate()){
                                    return;
                                  }
                                  _formKey.currentState!.save();

                                  FocusScope.of(context).requestFocus(FocusNode());
                                  if(provider.cameBack == false){
                                    if(widget.checkForUpdate == false){
                                      await Provider.of<ApiDataProvider>(context,listen: false).createCompany(context, provider.loginModel!.token!);
                                    }else{
                                      await Provider.of<ApiDataProvider>(context,listen: false).updateCompany(context, provider.loginModel!.token, provider.companyId!);
                                    }
                                  }else{
                                    await Provider.of<ApiDataProvider>(context,listen: false).updateCompany(context, provider.loginModel!.token, provider.companyId!);
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
