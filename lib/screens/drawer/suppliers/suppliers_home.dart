import 'package:docshero/components/constants.dart';
import 'package:docshero/components/providers/data_provilder.dart';
import 'package:docshero/components/reuseable_widgets/text_button_widget.dart';
import 'package:docshero/screens/drawer/suppliers/supplier_personal_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../../components/providers/supplier_apis.dart';
import '../../../components/reuseable_widgets/custom_loader.dart';


class SuppliersHome extends StatefulWidget {
  const SuppliersHome({Key? key}) : super(key: key);

  @override
  State<SuppliersHome> createState() => _SuppliersHomeState();
}

class _SuppliersHomeState extends State<SuppliersHome> {



  _runFilter(String enteredKeyword){
    List result=Provider.of<DataProvider>(context,listen: false).getAllSuppliersModel!.data!;
    if(enteredKeyword.isEmpty){

    }else{
      result = Provider.of<DataProvider>(context,listen: false).getAllSuppliersModel!.data!.where((element) => element.supplierName!.toLowerCase()
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
    _fountUsers=Provider.of<DataProvider>(context,listen: false).getAllSuppliersModel!.data!;
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
          title: mediumText("Suppliers",color: kWhiteColor,size: size.shortestSide < shortestSideCheck ? 25 : 35),
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
                    text: "Create Supplier",
                    textSize:  size.shortestSide < shortestSideCheck ? 16 : 22,
                    onPress: () async{
                      Get.dialog(CustomLoader());
                      bool check=await Provider.of<SupplierApis>(context,listen: false).termsOfPaymentSupplier(context, dataProvider.loginModel!.token!);
                     Get.back();
                     if(check==true){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=> SupplierPersonalDetails())).then((value) {
                         setState(() {
                           _fountUsers=Provider.of<DataProvider>(context,listen: false).getAllSuppliersModel!.data!;
                         });
                       });
                     }

                    }),

                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _fountUsers.length,
                    itemBuilder: (context, index){
                      return InkWell(
                        onTap: () async{

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
                                        child: mediumText("${_fountUsers[index]?.supplierName}",color: kBlackColor,softWrap: false,maxLines: 1,size: size.shortestSide < shortestSideCheck ? 16 : 22)),
                                    Row(
                                      children: [
                                        IconButton(onPressed: () async{

                                      }, icon: Icon(Icons.remove_red_eye,color: kOrangeColor,size: size.shortestSide < shortestSideCheck ? 24 : 35,),padding: EdgeInsets.zero,),

                                        IconButton(onPressed: () async{

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

}
