import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/constants.dart';
import '../../components/providers/data_provilder.dart';

class ShowCompanyDetail extends StatelessWidget {
  const ShowCompanyDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    DataProvider dataProvider=Provider.of<DataProvider>(context,listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: mediumText("Details",color: kWhiteColor,fontWeight: FontWeight.normal,size: 25),
          centerTitle: true,
        ),
        body: Container(
          //padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            // color: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10)
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(5),
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
                    children: [
                      SizedBox(
                          width:size.width * 0.17,
                          child: mediumText("Name:",color: kBlackColor)),
                      SizedBox(width: 5,),
                      mediumText("${dataProvider.singleCompanyDataModel?.modelData?.companyName}",maxLines: 3,color: kBlackColor,fontWeight: FontWeight.normal)
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(5),
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
                    children: [
                      SizedBox(
                          width:size.width * 0.17,
                          child: mediumText("Type:",color: kBlackColor)),
                      SizedBox(width: 5,),
                      mediumText("${dataProvider.singleCompanyDataModel?.modelData?.type}",maxLines: 3,color: kBlackColor,fontWeight: FontWeight.normal)
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(5),
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
                    children: [
                      SizedBox(
                          width:size.width * 0.17,
                          child: mediumText("Url:",color: kBlackColor)),
                      SizedBox(width: 5,),
                      mediumText("${dataProvider.singleCompanyDataModel?.modelData?.url}",maxLines: 3,color: kBlackColor,fontWeight: FontWeight.normal)
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(5),
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
                    children: [
                      SizedBox(
                          width:size.width * 0.25,
                          child: mediumText("Address 1:",color: kBlackColor)),
                      SizedBox(width: 5,),
                      mediumText("${dataProvider.locationByIdModel?.locations?[0]?.addressFirst}",maxLines: 3,color: kBlackColor,fontWeight: FontWeight.normal)
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(5),
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
                    children: [
                      SizedBox(
                          width:size.width * 0.25,
                          child: mediumText("Address 2:",color: kBlackColor)),
                      SizedBox(width: 5,),
                      mediumText("${dataProvider.locationByIdModel?.locations?[0]?.addressSecond ?? "..."}",maxLines: 3,color: kBlackColor,fontWeight: FontWeight.normal)
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(5),
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
                    children: [
                      SizedBox(
                          width:size.width * 0.17,
                          child: mediumText("City:",color: kBlackColor)),
                      SizedBox(width: 5,),
                      mediumText("${dataProvider.locationByIdModel?.locations?[0]?.city}",maxLines: 3,color: kBlackColor,fontWeight: FontWeight.normal)
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(5),
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
                    children: [
                      SizedBox(
                          width:size.width * 0.17,
                          child: mediumText("Zip:",color: kBlackColor)),
                      SizedBox(width: 5,),
                      mediumText("${dataProvider.locationByIdModel?.locations?[0]?.zip}",maxLines: 3,color: kBlackColor,fontWeight: FontWeight.normal)
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(5),
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
                    children: [
                      SizedBox(
                          width:size.width * 0.2,
                          child: mediumText("Country:",color: kBlackColor)),
                      SizedBox(width: 5,),
                      mediumText("${dataProvider.locationByIdModel?.locations?[0]?.country}",maxLines: 3,color: kBlackColor,fontWeight: FontWeight.normal)
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(5),
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
                    children: [
                      SizedBox(
                          width:size.width * 0.17,
                          child: mediumText("State:",color: kBlackColor)),
                      SizedBox(width: 5,),
                      mediumText("${dataProvider.locationByIdModel?.locations?[0]?.state}",maxLines: 3,color: kBlackColor,fontWeight: FontWeight.normal)
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(5),
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
                    children: [
                      SizedBox(
                          width:size.width * 0.17,
                          child: mediumText("VAT ID:",color: kBlackColor)),
                      SizedBox(width: 5,),
                      mediumText("${dataProvider.singleCompanyDataModel?.modelData?.vatId}",maxLines: 3,color: kBlackColor,fontWeight: FontWeight.normal)
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(5),
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
                    children: [
                      SizedBox(
                          width:size.width * 0.17,
                          child: mediumText("Phone:",color: kBlackColor)),
                      SizedBox(width: 5,),
                      mediumText("${dataProvider.singleCompanyDataModel?.modelData?.phone}",maxLines: 3,color: kBlackColor,fontWeight: FontWeight.normal)
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(5),
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
                    children: [
                      SizedBox(
                          width:size.width * 0.17,
                          child: mediumText("Fax:",color: kBlackColor)),
                      SizedBox(width: 5,),
                      mediumText("${dataProvider.singleCompanyDataModel?.modelData?.fax ?? "..."}",maxLines: 3,color: kBlackColor,fontWeight: FontWeight.normal)
                    ],
                  ),
                ),
                // SizedBox(height: 5,),
                // Row(
                //   children: [
                //     SizedBox(
                //         width:size.width * 0.5,
                //         child: mediumText("Terms of Payment:",color: kBlackColor)),
                //     SizedBox(width: 5,),
                //     mediumText("${dataProvider.locationByIdModel?.locations?[0]?. ?? "..."}",color: kBlackColor,fontWeight: FontWeight.normal)
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
