import 'package:dwaween/Screens/Knanish/KasayedDetails/AudioPlayer/audio_card.dart';
import 'package:dwaween/Screens/Knanish/Knanish.dart';
import 'package:dwaween/core/constants.dart';
import 'package:dwaween/core/nav.dart';
import 'package:dwaween/core/utils.dart';
import 'package:dwaween/features/DewanDetails/view.dart';
import 'package:dwaween/features/Dwaween/view.dart';
import 'package:dwaween/features/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Consumer<BaseProvider>(
      builder: (BuildContext context, provider, Widget? child) => Stack(
        children: [
          SvgPicture.asset(
            "assets/images/paintings/img_head_home.svg",
            alignment: Alignment.topCenter,
            width: mediaQuery.size.width,
            height: mediaQuery.size.height / 2,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.transparent,
                height: mediaQuery.size.height / 4,
              ),
              Container(
                height: 60,
                width: mediaQuery.size.width * .9,
                child: TextFormField(
                  cursorRadius: Radius.circular(10),
                  controller: provider.searchController,
                  onChanged: (value) {
                    provider.setSearchValue(value: value);
                  },
                  cursorColor: Constants.primary,
                  decoration: InputDecoration(
                    prefixIconColor: Color(0xff8C8C8C),
                    hintText: 'search_in_dwaween'.tr(),
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: Constants.primary,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintStyle: TextStyle(
                      color: Color(0xff8C8C8C),
                      fontFamily: 'Cairo',
                    ),
                    prefixIcon: IconButton(
                      icon: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                      onPressed: () {
                        //todo here u need to navigate to dwaween page with search result
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    ),
                    suffixIcon: Visibility(
                      visible: provider.searchController.text.length > 0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Constants.primary,
                        ),
                        onPressed: () {
                          provider.searchController.clear();
                          provider.setSearchValue(value: '');
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: provider.dewanBodyLoading
                      ? Center(
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).size.height / 2),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Center(
                              child: SpinKitCircle(
                                color: Constants.primary,
                              ),
                            ),
                          ),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            AudioCard(),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 35,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: mediaQuery.size.width / 25,
                                  ),
                                  SvgPicture.asset(
                                    "assets/images/icons/ic_dwawenTit.svg",
                                    height: mediaQuery.size.width / 12,
                                    width: mediaQuery.size.width / 12,
                                  ),
                                  Text(
                                    "dwaween".tr(),
                                    style: TextStyle(
                                      color: Color(0xff1C7F88),
                                      fontSize: mediaQuery.size.width / 25,
                                      fontFamily: "Cairo",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    width: mediaQuery.size.width / 2.1,
                                    child: Divider(
                                      color: Colors.teal,
                                      thickness: 1.5,
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DwaweenScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "view_all".tr(),
                                      style: TextStyle(
                                          color: Colors.teal,
                                          fontSize: mediaQuery.size.width / 25,
                                          fontFamily: "Cairo",
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: mediaQuery.size.width / 25,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: provider.dewanBody!.dawawen!.length > 0
                                  ? false
                                  : true,
                              child: Container(
                                width: mediaQuery.size.width,
                                margin: EdgeInsets.symmetric(
                                    horizontal: mediaQuery.size.width / 30),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.white,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'عذرا لا يوجد دواويين',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.teal,
                                          fontFamily: "Cairo",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: provider.dewanBody!.dawawen!.length > 0
                                  ? true
                                  : false,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: mediaQuery.size.width,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: mediaQuery.size.width / 30),
                                    child: InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors.white,
                                          ),
                                          child: ListTile(
                                            trailing: SvgPicture.asset(
                                              "assets/images/icons/ic_ksaed.svg",
                                              height: 25,
                                              width: 25,
                                            ),
                                            title: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                provider
                                                        .dewanBody
                                                        ?.dawawen?[index]
                                                        .name ??
                                                    '',
                                                style: TextStyle(
                                                    color: Colors.teal,
                                                    fontFamily: "Cairo"),
                                              ),
                                            ),
                                            subtitle: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "number_of_poems".tr(),
                                                  style: TextStyle(
                                                    color: Colors.teal,
                                                  ),
                                                ),
                                                Text('  '),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 4.0),
                                                  child: Text(
                                                    context.locale
                                                                .languageCode ==
                                                            'ar'
                                                        ? Utils().convertToArabicNumber(
                                                            provider
                                                                    .dewanBody
                                                                    ?.dawawen?[
                                                                        index]
                                                                    .kasaed
                                                                    ?.length
                                                                    .toString() ??
                                                                "0")
                                                        : provider
                                                                .dewanBody
                                                                ?.dawawen?[
                                                                    index]
                                                                .kasaed
                                                                ?.length
                                                                .toString() ??
                                                            "0",
                                                    style: TextStyle(
                                                      color: Colors.teal,
                                                      fontFamily: "Cairo",
                                                    ),
                                                  ),
                                                ),
                                                Text('  '),
                                                Text(
                                                  "poem".tr(),
                                                  style: TextStyle(
                                                    color: Colors.teal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        provider.setDawawen(provider
                                            .dewanBody!.dawawen![index]);

                                        provider.setKafya(index);

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DewanDetailsPage(),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                                itemCount:
                                    provider.dewanBody!.dawawen!.length > 15
                                        ? 15
                                        : provider.dewanBody?.dawawen?.length,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            //todo from here you need to handel
                            SizedBox(
                              height: 35,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: mediaQuery.size.width / 25,
                                  ),
                                  SvgPicture.asset(
                                    "assets/images/icons/ic_ksaed.svg",
                                    height: mediaQuery.size.width / 12,
                                    width: mediaQuery.size.width / 12,
                                  ),
                                  Text(
                                    "poems".tr(),
                                    style: TextStyle(
                                      color: Colors.teal,
                                      fontSize: mediaQuery.size.width / 20,

                                      // fontFamily: "Cairo",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    width: mediaQuery.size.width / 2.1,
                                    child: Divider(
                                      color: Colors.teal,
                                      thickness: 1.5,
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      navigateTo(context, Knanish());
                                    },
                                    child: Text(
                                      "view_all".tr(),
                                      style: TextStyle(
                                          color: Colors.teal,
                                          fontSize: mediaQuery.size.width / 25,
                                          fontFamily: "Cairo",
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: mediaQuery.size.width / 25,
                                  ),
                                ],
                              ),
                            ),
                            GridView.builder(
                              padding: EdgeInsets.symmetric(
                                  horizontal: mediaQuery.size.width / 30),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, childAspectRatio: 2),
                              itemCount: provider.groupedBy.length > 15
                                  ? 15
                                  : provider.groupedBy.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  margin: EdgeInsets.all(6),
                                  child: InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 6,
                                              ),
                                              SvgPicture.asset(
                                                "assets/images/icons/ic_ksaed.svg",
                                                height: 25,
                                                width: 25,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                child: Text(
                                                    maxLines: 1,
                                                    overflow: TextOverflow.fade,
                                                    provider.groupedBy[index]
                                                        .purpose,
                                                    style: TextStyle(
                                                        color: Colors.teal,
                                                        fontFamily:
                                                            "Amiri Regular")),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: 22),
                                            child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  "${context.locale.languageCode == 'ar' ? Utils().convertToArabicNumber(provider.groupedBy[index].kenshat.length.toString()) : provider.groupedBy[index].kenshat.length}  ${'poem'.tr()}",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily:
                                                          "Amiri Regular"),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                );
                              },
                            ),
                            // DuelList(),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
