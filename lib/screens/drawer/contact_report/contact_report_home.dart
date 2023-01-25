import 'package:docshero/components/providers/api_data_provider.dart';
import 'package:docshero/components/providers/contact_report_apis.dart';
import 'package:docshero/components/providers/docshero_apis_provider.dart';
import 'package:docshero/components/providers/employee_apis.dart';
import 'package:docshero/screens/drawer/contact_report/create_contact_report.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:provider/provider.dart';

import '../../../components/constants.dart';
import '../../../components/providers/data_provilder.dart';
import '../../../components/reuseable_widgets/text_button_widget.dart';

class ContactReportHome extends StatefulWidget {
  ContactReportHome({Key? key}) : super(key: key);

  @override
  State<ContactReportHome> createState() => _ContactReportHomeState();
}

class _ContactReportHomeState extends State<ContactReportHome> {


  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    DataProvider dataProvider=Provider.of<DataProvider>(context,listen: false);
    return SafeArea(
        child:Scaffold(
          appBar: AppBar(
            backgroundColor: kBlueColor,
            title: mediumText("Contact Reports",color: kWhiteColor,size: 25),
            centerTitle: true,
          ),
      body: Container(
        padding: EdgeInsets.only(left: 20,right: 20),
        margin: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextButtonWidget(
                  text: "Create Contact Report",
                  onPress: () async{
                    bool check=await Provider.of<ApiDataProvider>(context,listen: false).getAllCompanies(context, dataProvider.loginModel!.token!,isDelete: true);
                    if(check==true){
                      dataProvider.allCompaniesModel?.data?.forEach((companyData) {
                        dataProvider.allCompanyDropDownModel.add(DropDownValueModel(name: "${companyData?.companyName}", value: "${companyData?.id}"));
                      });
                      await Provider.of<DocsheroApisProvider>(context,listen: false).getDocsheroAllEmployees(context, dataProvider.loginModel!.token!).then((DocsheroAllEmployees) async {
                        if(DocsheroAllEmployees==true){
                          dataProvider.docsheroAllEmployeesModel?.data?.forEach((element) {
                            dataProvider.docsHeroAllEmployeesDropdownModel.add(DropDownValueModel(name: '${element.firstName}', value: '${element.id}'));
                          });
                          await Provider.of<DocsheroApisProvider>(context,listen: false).getDocsheroCategoris(context, dataProvider.loginModel!.token!).then((DocsheroCategoris) {
                            if(DocsheroCategoris==true){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateContactReport()));
                            }

                          });
                        }
                      });

                    }
                  }),

              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: Provider.of<DataProvider>(context,listen: false).getContactReportModel?.data.length,
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap: () async{},
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
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:MainAxisAlignment.end,
                                    children: [
                                      IconButton(onPressed: () async{
                                        await Provider.of<ContactReportApis>(context,listen: false).getContactReportById(context,
                                            dataProvider.loginModel!.token!,
                                            liveData.getContactReportModel!.data[index].id!).then((value) async{
                                          if(value == true){

                                            await dataProvider.setContactReportinitialValueSubjectText(dataProvider.singleContactReportModel!.modelData!.subject);
                                            if(dataProvider.singleContactReportModel!.modelData!.type == "customer"){
                                              await dataProvider.setContactReportinitialValueType("Company");
                                            }else{
                                              if(dataProvider.singleContactReportModel!.modelData!.type == "lead"){
                                                await dataProvider.setContactReportinitialValueType("Lead");
                                              }
                                            }

                                            await dataProvider.setContactReportinitialValuePriority(toCapitalize(dataProvider.singleContactReportModel!.modelData!.priority));
                                            await dataProvider.setContactReportinitialValueContactType(toCapitalize(dataProvider.singleContactReportModel!.modelData!.contactType));
                                            await dataProvider.setContactReportinitialValueInitiatedBy(toCapitalize(dataProvider.singleContactReportModel!.modelData!.initiatedBy));


                                            await Provider.of<ApiDataProvider>(context,listen: false).showCompanyById(context,
                                                dataProvider.loginModel!.token!,
                                                dataProvider.singleContactReportModel!.modelData!.companyId!).then((value) async{

                                              await dataProvider.setContactReportinitialValueCompany(dataProvider.singleCompanyDataModel?.modelData?.companyName);

                                              await Provider.of<ApiDataProvider>(context,listen: false).getAllCompanies(context, dataProvider.loginModel!.token!,isDelete: true).then((allCompaniesCheck) async{
                                                if(allCompaniesCheck == true){
                                                  dataProvider.allCompaniesModel?.data?.forEach((companyData) {
                                                    dataProvider.allCompanyDropDownModel.add(DropDownValueModel(name: "${companyData?.companyName}", value: "${companyData?.id}"));
                                                  });
                                                  dataProvider.setContactReportCompany(DropDownValueModel(name: "${dataProvider.singleCompanyDataModel?.modelData?.companyName}", value: "${dataProvider.singleCompanyDataModel?.modelData?.id}"));

                                                  await Provider.of<EmployeeApis>(context,listen: false).getEmployeeById(context, dataProvider.loginModel!.token!, dataProvider.singleCompanyDataModel?.modelData!.id!).then((EmployeeById) async{
                                                    if(EmployeeById==true){
                                                      List<String> list1=[];
                                                      dataProvider.getEmployeeByIdModel?.data.forEach((element) {
                                                        if(dataProvider.singleContactReportModel!.modelData!.companyEmployees!.contains(element.id)){
                                                          list1.add(element.firstName!);
                                                        }
                                                      });
                                                      await dataProvider.setContactReportinitialValueTalkedToPeople(list1);

                                                      await Provider.of<DocsheroApisProvider>(context,listen: false).getDocsheroAllEmployees(context, dataProvider.loginModel!.token!).then((DocsheroAllEmployees) async{
                                                        if(DocsheroAllEmployees==true){
                                                          List<String> list2=[];
                                                          dataProvider.docsheroAllEmployeesModel?.data?.forEach((element) {
                                                            dataProvider.docsHeroAllEmployeesDropdownModel.add(DropDownValueModel(name: '${element.firstName}', value: '${element.id}'));
                                                          if(dataProvider.singleContactReportModel!.modelData!.employees!.contains(element.id)){
                                                            list2.add(element.firstName!);
                                                          }
                                                          if(dataProvider.singleContactReportModel!.modelData!.createdByEmployee == element.id){
                                                             dataProvider.setContactReportinitialValueCreatedBy(element.firstName);
                                                          }
                                                          });

                                                          await dataProvider.setContactReportinitialValueEmployee(list2);

                                                          await Provider.of<DocsheroApisProvider>(context,listen: false).getDocsheroCategoris(context, dataProvider.loginModel!.token!).then((DocsheroCategoris) async{
                                                            if(DocsheroCategoris==true){
                                                              dataProvider.categoryModel?.data?.forEach((element) async {
                                                                if(element.id == dataProvider.singleContactReportModel!.modelData!.categoryId){
                                                                  await dataProvider.setContactReportinitialValueCategory(element.name);
                                                                }
                                                              });
                                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateContactReport()));
                                                            }

                                                          });
                                                        }
                                                      });
                                                    }
                                                  });


                                                }

                                              });

                                            });
                                          }
                                        });
                                      }, icon: Icon(Icons.edit_note,color: kOrangeColor,)),
                                    IconButton(onPressed: ()async{
                                      await Provider.of<ContactReportApis>(context,listen: false).deleteContactReport(
                                          context,
                                          liveData.loginModel!.token!,
                                          liveData.getContactReportModel!.data[index].id!);
                                      setState(() { });
                                    }, icon: Icon(Icons.delete,color: kOrangeColor,)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      mediumText("Subject:  ",color: kBlackColor),
                                      Expanded(child: mediumText("${liveData.getContactReportModel?.data[index].subject}",color: kBlackColor,fontWeight: FontWeight.normal))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      mediumText("Type:       ",color: kBlackColor),
                                      Expanded(child: mediumText("${liveData.getContactReportModel?.data[index].type}",color: kBlackColor,fontWeight: FontWeight.normal))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      mediumText("Priority:   ",color: kBlackColor),
                                      Expanded(child: mediumText("${liveData.getContactReportModel?.data[index].priority}",color: kBlackColor,fontWeight: FontWeight.normal))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      mediumText("Contact type:   ",color: kBlackColor),
                                      Expanded(child: mediumText("${liveData.getContactReportModel?.data[index].contactType}",color: kBlackColor,fontWeight: FontWeight.normal))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      mediumText("Initiated by:      ",color: kBlackColor),
                                      Expanded(child: mediumText("${liveData.getContactReportModel?.data[index].initiatedBy}",color: kBlackColor,fontWeight: FontWeight.normal))
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //   children: [
                                  //   SizedBox(
                                  //     width:size.width * 0.3,
                                  //       child: TextButtonWidget(onPress: () async{
                                  //        await Provider.of<ContactReportApis>(context,listen: false).getContactReportById(context,
                                  //             dataProvider.loginModel!.token!,
                                  //             liveData.getContactReportModel!.data[index].id!).then((value) async{
                                  //               if(value==true){
                                  //                await Provider.of<ApiDataProvider>(context,listen: false).showCompanyById(context,
                                  //                   dataProvider.loginModel!.token!,
                                  //                     dataProvider.singleContactReportModel!.modelData!.companyId!).then((value) async{
                                  //                  await Provider.of<ApiDataProvider>(context,listen: false).getAllCompanies(context, dataProvider.loginModel!.token!,isDelete: true).then((allCompaniesCheck) async{
                                  //                   if(allCompaniesCheck == true){
                                  //                     dataProvider.allCompaniesModel?.data?.forEach((companyData) {
                                  //                       dataProvider.allCompanyDropDownModel.add(DropDownValueModel(name: "${companyData?.companyName}", value: "${companyData?.id}"));
                                  //                     });
                                  //                     dataProvider.setContactReportCompany(DropDownValueModel(name: "${dataProvider.singleCompanyDataModel?.modelData?.companyName}", value: "${dataProvider.singleCompanyDataModel?.modelData?.id}"));
                                  //                     dataProvider.contactReportCompany;
                                  //
                                  //                     await Provider.of<DocsheroApisProvider>(context,listen: false).getDocsheroCategoris(context, dataProvider.loginModel!.token!).then((DocsheroCategoris) {
                                  //                       if(DocsheroCategoris==true){
                                  //                         Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateContactReport()));
                                  //                       }
                                  //
                                  //                     });
                                  //
                                  //                   }
                                  //
                                  //                  });
                                  //
                                  //                });
                                  //               }
                                  //         });
                                  //
                                  //       },text: "   Edit   ",)),
                                  //   // SizedBox(
                                  //   //     width:size.width * 0.3,
                                  //   //     child: TextButtonWidget(onPress: ()async{
                                  //   //       await Provider.of<ContactReportApis>(context,listen: false).deleteContactReport(
                                  //   //           context,
                                  //   //           liveData.loginModel!.token!,
                                  //   //           liveData.getContactReportModel!.data[index].id!);
                                  //   //       setState(() { });
                                  //   //     },text: " Delete ",)),
                                  // ],),


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
    ));
  }

  String? toCapitalize(String? input) {
    if (input == null || input.isEmpty) return input;
    return '${input[0].toUpperCase()}${input.substring(1).toLowerCase()}';
  }

}
