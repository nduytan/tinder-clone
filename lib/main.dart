import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tinder_app_clone/page/explore.dart';
import 'package:provider/provider.dart';
import 'package:tinder_app_clone/provider/position_card_provider.dart';

import 'page/like.dart';
import 'provider/list_liked_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Timer(
        const Duration(seconds: 1),
        () => Navigator.of(context)
            .pushReplacement(FadeRouteBuilder(page: const MainPage())));
    return Scaffold(
      //appBar: AppBar(title: const Text('Fab overlay transition')),
      body: Container(
          color: Colors.white,
          child: Stack(
            children: [
              RotatedBox(
                quarterTurns: 1,
                child: Container(
                  //color: const Color(0xffFC5465),
                  child: Lottie.asset('assets/lottie/transition.json',
                      fit: BoxFit.fill,
                      frameRate: FrameRate(160),
                      reverse: false,
                      repeat: false,
                      width: MediaQuery.of(context).size.height),
                ),
              ),
              Container(
                  color: Colors.transparent,
                  // decoration: const BoxDecoration(
                  //     gradient: LinearGradient(
                  //   begin: Alignment.topRight,
                  //   end: Alignment.bottomLeft,
                  //   colors: [
                  //     Color(0xffFE6F53),
                  //     Color(0xffFD635B),
                  //     Color(0xffFD5862),
                  //     Color(0xffFC5465),
                  //     Color(0xffFC5069),
                  //     Color(0xffF94F6C),
                  //     Color(0xffF74E6E),
                  //     Color(0xffF14C74),
                  //     Color(0xffEC4A79),
                  //   ],
                  // )),
                  child: Center(
                    child: Lottie.asset(
                      'assets/lottie/tinder-logo.json',
                      fit: BoxFit.fill,
                      frameRate: FrameRate(120),
                      reverse: true,
                      repeat: true,
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                  )),
            ],
          )),
    );
  }
}

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({this.page})
      : super(
          pageBuilder: (context, animation1, animation2) => page,
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(opacity: animation1, child: child);
          },
        );
}

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  //final List _children = [];
  final List<Widget> _children = [
    const ExplorePage(),
    LikesPage(),
    const PlaceholderWidget(Colors.green)
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<PositionCardProvider>(
              create: (context) => PositionCardProvider()),
          ChangeNotifierProvider<ListLikedProvider>(
              create: (context) => ListLikedProvider()),
        ],
        child: Scaffold(
          body: IndexedStack(index: _currentIndex, children: _children),

          // new
          bottomNavigationBar: BottomNavigationBar(
            onTap: onTabTapped, // new
            currentIndex: _currentIndex, // new
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                      _currentIndex == 0
                          ? 'assets/images/explore_active_icon.svg'
                          : 'assets/images/explore_icon.svg',
                      height: 27),
                  label: ""),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                      _currentIndex == 1
                          ? 'assets/images/chat_active_icon.svg'
                          : 'assets/images/chat_icon.svg',
                      height: 27),
                  label: ""),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                      _currentIndex == 2
                          ? 'assets/images/account_active_icon.svg'
                          : 'assets/images/account_icon.svg',
                      height: 27),
                  label: ""),
            ],
          ),
        ));
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  // ignore: use_key_in_widget_constructors
  const PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
