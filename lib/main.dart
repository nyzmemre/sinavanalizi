import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sinavanalizi/features/homepage/homepage_view.dart';
import 'package:sinavanalizi/features/login/login_view.dart';
import 'package:sinavanalizi/features/login/sign_up_view.dart';

import 'package:sinavanalizi/firebase_options.dart';
import 'package:sinavanalizi/product/utilty/constants/color_constant.dart';
import 'package:sinavanalizi/product/utilty/constants/text_constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
     const SinavAnalizi(),
  );
  /* MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AttendationViewModel()),
        ],
        child: const SinavAnalizi()),);*/
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
      ],*/
    /*  supportedLocales: const [
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
      home: SignUpView()
      //onGenerateRoute: Routes.createRoutes,
    );
  }
}