import 'package:docshero/components/providers/contact_report_apis.dart';
import 'package:docshero/components/providers/data_provilder.dart';
import 'package:docshero/components/providers/docshero_apis_provider.dart';
import 'package:docshero/components/providers/employee_apis.dart';
import 'package:docshero/components/providers/location_apis.dart';
import 'package:docshero/screens/survey_screen.dart';
import 'package:docshero/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'components/providers/api_data_provider.dart';
import 'components/providers/supplier_apis.dart';
import 'components/utils/navigator_key.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => DataProvider()),
    ChangeNotifierProvider(create: (context) => ApiDataProvider()),
    ChangeNotifierProvider(create: (context) => LocationApis()),
    ChangeNotifierProvider(create: (context)=> EmployeeApis()),
    ChangeNotifierProvider(create: (context) => ContactReportApis()),
    ChangeNotifierProvider(create: (context) => DocsheroApisProvider()),
    ChangeNotifierProvider(create: (context) => SupplierApis())
  ],
    child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DocsHero Surey',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      navigatorKey: NavigatorKeyClass.navigatorKey,

      home: SplashScreen(),
    );
  }
}

