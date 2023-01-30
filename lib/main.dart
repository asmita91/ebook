import 'package:ebook/ViewModel/BookViewModel.dart';
import 'package:ebook/pages/home_body.dart';
import 'package:ebook/states/currentUser.dart';
import 'package:ebook/utils/ourTheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BookViewModel>(create: (_) => BookViewModel()),
        ChangeNotifierProvider(
          create: (context) => CurrentUser(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: OurTheme().buildTheme(),
        home:
            // OurLogin(),
            HomeBody(),
      ),
    );
  }
}
/*
* return ChangeNotifierProvider(
      // theme: OurTheme().buildTheme(),
      create: ((context) => BookData()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        routes: {
          Home.id: (context) => const Home(),
          Splash.id: (ctx) => const Splash(),
        },
        initialRoute: Splash.id,
      ),
    );
* */
