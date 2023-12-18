import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:dwaween/Screens/About/about.dart';
import 'package:dwaween/Screens/Drawer/drawer.dart';
import 'package:dwaween/Screens/DwawenList/dlistview.dart';
import 'package:dwaween/Screens/Home/HomeScreen.dart';
import 'package:dwaween/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_svg/svg.dart';

import '../Knanish/Knanish.dart';

class Home extends StatefulWidget {
  Home({super.key, required this.value});
  int value;
  @override
  State<Home> createState() => _HomeState();
}


final scaffoldKey = GlobalKey<ScaffoldState>();

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void initState() {
    // _selectedIndex = widget.value;
  }
  List<Widget> screens = [
    Homescreen(),
    Dwaweenlist(),
    Knanish(),
    about()
  ];

  void changeIndex(int val) {
    setState(() {
      _selectedIndex = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    double d1=32;
    return WillPopScope(
      onWillPop: ()=>onBackPressed(context),
      child: Scaffold(
        key: scaffoldKey,
        endDrawer: DrawerFb1(),
        body: screens[_selectedIndex],
        bottomNavigationBar: Directionality(
          textDirection: TextDirection.rtl,
          child: BottomNavyBar(
            selectedIndex: _selectedIndex,
            showElevation: true,
            itemCornerRadius: 50,
            curve: Curves.easeIn,
            onItemSelected: (index) {
              if(index==4){
                scaffoldKey.currentState!.openEndDrawer();
              }else{
                changeIndex(index);
              }
            },
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                icon: SvgPicture.asset("assets/ico/ic_home.svg",
                    height: d1, width: d1, fit: BoxFit.scaleDown),
                title: Text("الرئيسية",style: TextStyle(fontFamily: "Cairo"),),

                activeColor: Constants.primary,
                textAlign: TextAlign.center,
              ),

                BottomNavyBarItem(
                  icon: SvgPicture.asset("assets/ico/ic_dwawen.svg",
                      height: d1, width: d1, fit: BoxFit.scaleDown),
                  title: Text('الدواوين',style: TextStyle(fontFamily: "Cairo"),),

                  activeColor: Constants.primary,
                  textAlign: TextAlign.center,
                ),
              BottomNavyBarItem(
                icon: SvgPicture.asset("assets/ico/ic_ksaed.svg",
                    height: d1, width: d1, fit: BoxFit.scaleDown),
                title: Text('الكناش ',style: TextStyle(fontFamily: "Cairo"),),

                activeColor: Constants.primary,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: SvgPicture.asset("assets/ico/ic_shaikh.svg",
                    height: d1, width: d1, fit: BoxFit.scaleDown),
                title: Text('الشيخ',style: TextStyle(fontFamily: "Cairo"),),

                activeColor: Constants.primary,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: SvgPicture.asset("assets/ico/ic_more.svg",
                    height: d1, width: d1, fit: BoxFit.scaleDown),
                title: Text('المزيد',style: TextStyle(fontFamily: "Cairo"),),

                activeColor: Constants.primary,
                textAlign: TextAlign.center,
              ),

          ],
      ),
        ),
      ),
    );
  }

/*
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>onBackPressed(context),
      child: Scaffold(
        key: scaffoldKey,
        endDrawer: DrawerFb1(),
        body: screens[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40), topLeft: Radius.circular(40)),
            color: Colors.white,
          ),
          child: SizedBox(
            height: 65,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconBottomBar(
                    icon: SvgPicture.asset("assets/ico/ic_more.svg",
                        height: d1, width: d1, fit: BoxFit.scaleDown),
                    selected: _selectedIndex == 0,
                    onPressed: () {
                      // setState(() {
                      //   _selectedIndex = 3;
                      // });
                      //Scaffold.of(context).openDrawer();
                      scaffoldKey.currentState!.openEndDrawer();
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        width: 1,
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        IconBottomBar(
                          icon: SvgPicture.asset("assets/ico/ic_shaikh.svg",
                              height: d1, width: d1, fit: BoxFit.scaleDown),
                          selected: _selectedIndex == 0,
                          onPressed: () {
                            changeIndex(3);
                          },
                        ),
                        Text("الشيخ")
                      ],
                    ),
                  ),
                  IconBottomBar(
                    icon: SvgPicture.asset("assets/ico/ic_ksaed.svg",
                        height: d1, width: d1, fit: BoxFit.scaleDown),
                    selected: _selectedIndex == 2,
                    onPressed: () {
                      changeIndex(2);
                    },
                  ),
                  IconBottomBar(
                    icon: SvgPicture.asset("assets/ico/ic_dwawen.svg",
                        height: d1, width: d1, fit: BoxFit.scaleDown),
                    selected: _selectedIndex == 1,
                    onPressed: () {
                      changeIndex(1);
                    },
                  ),
                  IconBottomBar(
                    icon: SvgPicture.asset("assets/ico/ic_home.svg",
                        height: d1, width: d1, fit: BoxFit.scaleDown),
                    selected: _selectedIndex == 0,
                    onPressed: () {
                      changeIndex(0);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
*/
  onBackPressed(BuildContext context) {

    if(scaffoldKey.currentState!.isEndDrawerOpen){
      scaffoldKey.currentState!.closeEndDrawer();
    }else{
      if(_selectedIndex>0){
        setState(() {
          _selectedIndex=0;
        });
      }else {
        FlutterExitApp.exitApp();
      }
    }

  }

}
