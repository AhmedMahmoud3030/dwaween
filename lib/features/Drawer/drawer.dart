import 'package:dwaween/Notes/notesData.dart';
import 'package:dwaween/Screens/AboutUs/AboutUs.dart';
import 'package:dwaween/Screens/Comment/Comment.dart';
import 'package:dwaween/core/constants.dart';
import 'package:dwaween/features/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../Favourite/FavDataBase.dart';

class DrawerFb1 extends StatelessWidget {
  const DrawerFb1({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Drawer(
      shadowColor: Constants.primary2,
      elevation: 20,
      // surfaceTintColor: Colors.amber,
      backgroundColor: Color(0xff0A8065),
      child: ListView(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: mediaQuery.size.height * .3,
            width: double.infinity,
            child: SvgPicture.asset(
              "assets/images/paintings/sidemenu.svg",
              alignment: Alignment.topCenter,
              //width: 500,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Container(
            height: mediaQuery.size.height * .7,
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(8.0, 8.0, 12.0, 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FavDataBase(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/icons/fav.png",
                        width: 30,
                        height: 30,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Favourite".tr(),
                        style: TextStyle(
                          color: Constants.primary2,
                          fontFamily: "Cairo",
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => noteData(),
                        ),
                      );
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/icons/notes.png",
                        width: 30,
                        height: 30,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Notes".tr(),
                        style: TextStyle(
                          color: Constants.primary2,
                          fontFamily: "Cairo",
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    Navigator.of(context).pop();
                    final box = context.findRenderObject() as RenderBox;
                    await Share.share(
                        "\nرابط التطبيق للاندرويد : \n # \nرابط التطبيق للايفون : \n #\n\n",
                        subject: "",
                        sharePositionOrigin:
                            box.localToGlobal(Offset.zero) & box.size);
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/icons/share.png",
                        width: 30,
                        height: 30,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Share".tr(),
                        style: TextStyle(
                          color: Constants.primary2,
                          fontFamily: "Cairo",
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Consumer<BaseProvider>(
                  builder: (BuildContext context, value, Widget? child) =>
                      InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      value.changeLang(context: context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/icons/lang.png",
                              width: 30,
                              height: 30,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Language".tr(),
                              style: TextStyle(
                                color: Constants.primary2,
                                fontFamily: "Cairo",
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              context.locale.languageCode == 'ar'
                                  ? 'عربي'
                                  : 'English',
                              style: TextStyle(
                                color: Constants.primary2,
                                fontFamily: "Cairo",
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Constants.primary2,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Comment(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/icons/contactus.png",
                        width: 30,
                        height: 30,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "ContactUs".tr(),
                        style: TextStyle(
                          color: Constants.primary2,
                          fontFamily: "Cairo",
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AboutUs(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/icons/about.png",
                        width: 30,
                        height: 30,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "AboutUs".tr(),
                        style: TextStyle(
                          color: Constants.primary2,
                          fontFamily: "Cairo",
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
