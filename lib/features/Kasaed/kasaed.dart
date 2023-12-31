import 'package:dwaween/core/constants.dart';
import 'package:dwaween/core/utils.dart';
import 'package:dwaween/core/widgits/customTextFormField.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../KasayedByCategory/kasayed_by_category.dart';
import '../provider.dart';

class KasaedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Consumer<BaseProvider>(
      builder: (BuildContext context, provider, Widget? child) =>
          GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Stack(
          children: [
            Stack(
              children: [
                SvgPicture.asset(
                  "assets/images/paintings/img_head_internal.svg",
                  alignment: Alignment.topCenter,
                  width: MediaQuery.of(context).size.width * 4,
                  height: MediaQuery.of(context).size.height / 2,
                ),
                Column(
                  children: [
                    Container(
                      color: Colors.transparent,
                      height: mediaQuery.size.height * .09,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            SvgPicture.asset(
                              "assets/images/icons/ic_ksaed2.svg",
                              height: mediaQuery.size.width / 12,
                              width: mediaQuery.size.width / 12,
                            )
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "poems".tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: mediaQuery.size.width / 25,
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'search_Kasaed_catagories'.tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: mediaQuery.size.width / 25,
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: mediaQuery.size.height * .02,
                    ),
                    CustomTextFormFiled(
                      mediaQuery: mediaQuery,
                      textEditingController: provider.kasayedController,
                      onChanged: (value) {
                        provider.searchKasayedMethod(searchValue: value);
                      },
                      searchText: 'search_in_poems',
                      onPressed: () {
                        provider.kasayedController.clear();
                        provider.searchKasayedMethod(searchValue: '');
                      },
                      onFieldSubmitted: (String) {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: mediaQuery.size.height / 1.55,
                      width: mediaQuery.size.height,
                      child: provider.dewanBodyLoading
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Center(
                                child: SpinKitCircle(
                                  color: Constants.primary,
                                ),
                              ),
                            )
                          : provider.dewanBody!.dawawen.isEmpty
                              ? Container(
                                  width: mediaQuery.size.width,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: mediaQuery.size.width / 30),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Colors.white,
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'there_is_no_Kasayed'.tr(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.teal,
                                            fontFamily: "Cairo",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : GridView.builder(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: mediaQuery.size.width / 30),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 2),
                                  itemCount: provider.groupedBy.length > 15
                                      ? 15
                                      : provider.groupedBy.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      child: Card(
                                        margin: EdgeInsets.all(6),
                                        child: InkWell(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
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
                                                      width: mediaQuery
                                                              .size.width *
                                                          .3,
                                                      child: Text(
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        provider
                                                            .groupedBy[index]
                                                            .purpose,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.teal,
                                                          fontFamily: "Cairo",
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 22),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      "${context.locale.languageCode == 'ar' ? Utils().convertToArabicNumber(provider.groupedBy[index].kenshat.length.toString()) : provider.groupedBy[index].kenshat.length}  ${'poem'.tr()}",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontFamily: "Cairo"),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            provider.setGroupedByIndex(
                                                index: index);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    KasaedByCategoryScreen(),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
