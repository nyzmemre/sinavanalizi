

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sinavanalizi/features/homepage/homepage_view.dart';
import 'package:sinavanalizi/features/login/login_view.dart';
import 'package:sinavanalizi/features/login/login_view_model.dart';
import 'package:sinavanalizi/features/login/sign_up_view.dart';

import 'package:sinavanalizi/firebase_options.dart';
import 'package:sinavanalizi/product/utilty/constants/color_constant.dart';
import 'package:sinavanalizi/product/utilty/constants/text_constant.dart';
import 'package:sinavanalizi/services/read_document.dart';

import 'features/login/forgot_password.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(

   MultiProvider(
        providers: [
          ChangeNotifierProvider<LoginViewModel>(create: (_) => LoginViewModel()),
          ChangeNotifierProvider<ReadDocument>(create: (_) => ReadDocument()),
        ],
        child: const SinavAnalizi()));
}

class SinavAnalizi extends StatelessWidget {
  const SinavAnalizi({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: TextConstant.appName,
      ///aidat takipteki tarih seçin butonu için
      ///oradaki tarih ekranı Türkçe oluyor
/*localizationsDelegates: const [
        MonthYearPickerLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],

  supportedLocales: const [
        Locale('tr', 'TR'),
        // ...
      ],*/

      theme: ThemeData(
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
              backgroundColor: ColorConstant.transparent,
              iconTheme: IconThemeData().copyWith(color: ColorConstant.black),
              elevation: 0,
              titleTextStyle: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold))),
      // home: StudentDetailView(studentID: 'bkB0iVrJxsyJp1SS3Oil',),
      // home: CategoryAddView(),
      // home: StudentInfoUpdateView(),
      home: HomePage()
      //onGenerateRoute: Routes.createRoutes,
    );
  }
}


/*





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sinavanalizi/deleted/adana_schools.dart';
import 'package:sinavanalizi/deleted/adiyaman_schools.dart';
import 'package:sinavanalizi/firebase_options.dart';
import 'deleted/adana_schools.dart';


void main() async {
 // WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await addDataToFirestore();
}

Future<void> addDataToFirestore() async {
  var adiyaman=AdiyamanSchools();
   List<String> rawData = adiyaman.list;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  for (String data in rawData) {
    // Veriyi parçalayarak il, ilçe ve okul isimlerini elde et
    List<String> parts = data.split(' - ');
    String city = parts[0];
    String district = parts[1];
    String school = parts[2];

    // İl belgesini oluştur veya al
    DocumentReference cityRef = firestore.collection('cities').doc(city);
    await cityRef.set(<String, dynamic>{});


    // İlçe belgesini oluştur veya al
    DocumentReference districtRef = cityRef.collection('districts').doc(district);
    await districtRef.set(<String, dynamic>{});

    // Okul belgesini oluştur veya al
    DocumentReference schoolRef = districtRef.collection('schools').doc(school);
    await schoolRef.set(<String, dynamic>{});
  }

  print('Veriler Firestore\'a eklendi.');
}


*/
