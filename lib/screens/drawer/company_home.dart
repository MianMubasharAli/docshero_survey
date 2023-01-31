import 'package:docshero/components/constants.dart';
import 'package:docshero/components/providers/data_provilder.dart';
import 'package:docshero/components/reuseable_widgets/rounded_input_field.dart';
import 'package:docshero/components/reuseable_widgets/text_button_widget.dart';
import 'package:docshero/components/utils/validate_non_empty.dart';
import 'package:docshero/screens/drawer/forms/company_personal_details.dart';
import 'package:docshero/screens/drawer/show_company_detail.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/providers/api_data_provider.dart';

class Companies extends StatefulWidget {
  const Companies({Key? key}) : super(key: key);

  @override
  State<Companies> createState() => _CompaniesState();
}

class _CompaniesState extends State<Companies> {

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
    provider.setFax(null);
    provider.setTermsOfPayment(null);
  }

  _runFilter(String enteredKeyword){
    List result=Provider.of<DataProvider>(context,listen: false).allCompaniesModel!.data!;
    if(enteredKeyword.isEmpty){

    }else{
      result = Provider.of<DataProvider>(context,listen: false).allCompaniesModel!.data!.where((element) => element!.companyName!.toLowerCase()
          .contains(enteredKeyword.toLowerCase())).toList();
    }
    setState((){
      _fountUsers=result;
    });

  }

  List _fountUsers=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data();
    _fountUsers=Provider.of<DataProvider>(context,listen: false).allCompaniesModel!.data!;
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    DataProvider dataProvider=Provider.of<DataProvider>(context,listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteColor,
        appBar: AppBar(
          backgroundColor: kBlueColor,
          title: mediumText("Companies",color: kWhiteColor,size: size.shortestSide < shortestSideCheck ? 25 : 35),
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
          padding: EdgeInsets.only(left: 20,right: 20),
          margin: EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  style: TextStyle(
                    color: kBlackColor,
                    fontSize:  size.shortestSide < shortestSideCheck ? 16 : 22
                  ),
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(
                      fontSize:  size.shortestSide < shortestSideCheck ? 16 : 22,
                      color: Colors.black.withOpacity(0.5)
                    ),
                    filled: true,
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: kBlackColor),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    prefixIcon: Icon(Icons.search,size: size.shortestSide < shortestSideCheck ? 35 : 45,)
                  ),
                  onChanged: (onChanged) async{
                   await _runFilter(onChanged);
                  },
                ),
                SizedBox(height: 10,),
                TextButtonWidget(
                    text: "Create Company",
                    textSize:  size.shortestSide < shortestSideCheck ? 16 : 22,
                    onPress: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> CompanyPersonalDetails()));
                    }),

                ListView.builder(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _fountUsers.length,
                    itemBuilder: (context, index){
                  return InkWell(
                    onTap: () async{
                      await getData(index);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> CompanyPersonalDetails(checkForUpdate: true,)));
                    },
                    child: Consumer<DataProvider>(
                      builder: (context,liveData,snap) {
                        return Container(
                          margin: EdgeInsets.only(top: index== 0 ? 20:5,bottom: 0),
                          padding: EdgeInsets.only(top: 15,bottom: 15,right: 5,left: 10),
                          decoration: BoxDecoration(
                            color: kWhiteColor,
                            borderRadius: BorderRadius.circular(5),
                            // border: Border.all(color: kBlackColor)
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: size.width * 0.6,
                                  child: mediumText("${_fountUsers[index]?.companyName} (${_fountUsers[index]?.companyNumber})",color: kBlackColor,softWrap: false,maxLines: 1,size: size.shortestSide < shortestSideCheck ? 16 : 22)),
                            Row(
                              children: [
                                IconButton(onPressed: () async{
                                  await Provider.of<ApiDataProvider>(context,listen: false).showCompanyById(context,
                                      liveData.loginModel!.token!,
                                      _fountUsers[index]!.id!);
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowCompanyDetail()));

                                }, icon: Icon(Icons.remove_red_eye,color: kOrangeColor,size: size.shortestSide < shortestSideCheck ? 24 : 35,),padding: EdgeInsets.zero,),

                                IconButton(onPressed: () async{
                                 await Provider.of<ApiDataProvider>(context,listen: false).deleteCompanyById(context,  dataProvider.loginModel!.token!,
                                     _fountUsers[index]!.id!);
                                 setState(() {

                                 });
                                }, icon: Icon(Icons.delete,color: kOrangeColor,size: size.shortestSide < shortestSideCheck ? 24 : 30,),padding: EdgeInsets.zero,constraints: BoxConstraints(),)

                              ],
                            )
                            ],
                          ),
                        );
                      }
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
  getData(int index) async{

    DataProvider dataProvider=Provider.of<DataProvider>(context,listen: false);

    // await dataProvider.data();

    ApiDataProvider apiDataProvider=Provider.of<ApiDataProvider>(context,listen: false);
    String companyId=dataProvider.allCompaniesModel!.data![index]!.id!;
    await apiDataProvider.showCompanyById(context, dataProvider.loginModel!.token!, companyId);
    dataProvider.setName(dataProvider.singleCompanyDataModel?.modelData?.companyName);
    dataProvider.setType(dataProvider.singleCompanyDataModel?.modelData?.type);
    dataProvider.setCustomerType(dataProvider.singleCompanyDataModel?.modelData?.customerType);
    dataProvider.setUrl(dataProvider.singleCompanyDataModel?.modelData?.url);
    dataProvider.setAddess1(dataProvider.locationByIdModel?.locations?[0]?.addressFirst);
    dataProvider.setAddress2(dataProvider.locationByIdModel?.locations?[0]?.addressSecond);
    dataProvider.setCity(dataProvider.locationByIdModel?.locations?[0]?.city);
    dataProvider.setZip(dataProvider.locationByIdModel?.locations?[0]?.zip);
    dataProvider.setCountry(dataProvider.locationByIdModel?.locations?[0]?.country);
    dataProvider.setState(dataProvider.locationByIdModel?.locations?[0]?.state);
    dataProvider.setVatId(dataProvider.singleCompanyDataModel?.modelData?.vatId);
    dataProvider.setPhone(dataProvider.singleCompanyDataModel?.modelData?.phone);
    dataProvider.setFax(dataProvider.singleCompanyDataModel?.modelData?.fax);
  }
}
