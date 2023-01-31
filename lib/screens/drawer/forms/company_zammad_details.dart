import 'package:docshero/components/models/companies_models/get_employee_by_id_model.dart';
import 'package:docshero/components/reuseable_widgets/text_button_widget.dart';
import 'package:docshero/screens/dashboard_screen.dart';
import 'package:docshero/screens/survey_screen.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

import '../../../components/constants.dart';

class CompanyZammadDetails extends StatefulWidget {
   CompanyZammadDetails({
     required this.model,
     required this.employeeList,
     Key? key}) : super(key: key);

   GetEmployeeByIdModel model;
   List<DropDownValueModel> employeeList;
  @override
  State<CompanyZammadDetails> createState() => _CompanyZammadDetailsState();
}

class _CompanyZammadDetailsState extends State<CompanyZammadDetails> {
  late MultiValueDropDownController _cntMulti;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cntMulti = MultiValueDropDownController();
  }
  @override
  void dispose() {
    _cntMulti.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: mediumText("Zammad",color: kWhiteColor,size: 25),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20,right: 20),
        margin: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    Center(child: mediumText("Select users for zammad ticketing system",color: kBlackColor,size: 25,maxLines: 3)),
                    DropDownTextField.multiSelection(
                      controller: _cntMulti,
                      //initialValue: const ["name1", "name2", "name8", "name3"],
                      dropDownList: widget.employeeList,
                      onChanged: (val) {
                        setState(() {});
                      },
                    ),
                    Center(
                      child: Container(
                          width: size.width * 0.5,
                          margin: EdgeInsets.only(top: 20),
                          child: TextButtonWidget(text: "Employee",onPress: (){},)),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              TextButtonWidget(text: "Finish",onPress: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>DashboardScreen()), (route) => false);
              },)
            ],
          ),
        ),
      ),
    ));
  }
}
