import 'package:docshero/components/constants.dart';
import 'package:docshero/components/providers/data_provilder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/models/option_product2_model.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    DataProvider provider=Provider.of<DataProvider>(context,listen: false);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: size.shortestSide < shortestSideCheck ? 70.0 : 100,
        title: mediumText("Shopping Cart",color: kWhiteColor,size: size.shortestSide < shortestSideCheck ? 25 : 35),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp,color: kWhiteColor,size: size.shortestSide < shortestSideCheck ? 25 :45,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10,right: 10,top: 10),
          child: SingleChildScrollView(
        child: Consumer<DataProvider>(
          builder: (context,dataProvider,child) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width * 0.34,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        // color: kBlueColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      alignment: Alignment.center,
                      child: mediumText("PRODUCT NAME",color: kOrangeColor,size: size.width * 0.04),
                    ),
                    Container(
                      width: size.width * 0.23,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          // color: kBlueColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      alignment: Alignment.center,
                      child: mediumText("QUANTITY",color: kOrangeColor,size: size.width * 0.04),
                    ),
                    Container(
                      width: size.width * 0.34,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          // color: kBlueColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      alignment: Alignment.center,
                      child: mediumText("PRODUCT PRICE",color: kOrangeColor,size: size.width * 0.04,softWrap: false,maxLines: 2),
                    )
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                    itemCount: Provider.of<DataProvider>(context).productList.length,
                    itemBuilder: (context,index){
                    OptionProduct2 product=provider.productList[index];

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: size.width * 0.34,
                        padding: EdgeInsets.only(top: 5,left: 5),
                        margin: EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                            color: kBlackColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: mediumText("${product.name}",color: kBlackColor,size: size.shortestSide < shortestSideCheck ? 18 : 25,softWrap: false,maxLines: 3),
                      ),
                      Container(
                        width: size.width * 0.23,
                        padding: EdgeInsets.only(top: 5,left: 5),
                        margin: EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                            color: kBlackColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: mediumText("${product.quantity}",size: size.shortestSide < shortestSideCheck ? 18 : 25,color: kBlackColor,softWrap: false,maxLines: 3),
                      ),
                      Container(
                        width: size.width * 0.34,
                        padding: EdgeInsets.only(top: 5,left: 5),
                        margin: EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                            color: kBlackColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: mediumText("${
                            // int.parse(product.quantity.toString()) *
                                double.parse(product.salePrice.toString())}",size: size.shortestSide < shortestSideCheck ? 18 : 25,color: kBlackColor,softWrap: false,maxLines: 3),
                      )
                    ],
                  );
                })
              ],
            );
          }
        ),
      )),
    ));
  }
}
