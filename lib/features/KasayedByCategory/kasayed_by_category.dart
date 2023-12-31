import 'package:dwaween/core/constants.dart';
import 'package:dwaween/core/utils.dart';
import 'package:dwaween/features/DewanDetails/view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../provider.dart';

class KasaedByCategoryScreen extends StatelessWidget {
  final int indexList;

  const KasaedByCategoryScreen({
    super.key,
    required this.indexList,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Consumer<BaseProvider>(
      builder: (BuildContext context, provider, Widget? child) => Stack(
        children: [
          Scaffold(
            body: Stack(
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
                      height: mediaQuery.size.height * .06,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                          ),
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${"poemsx".tr()} ${provider.groupedBy[indexList].purpose}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: mediaQuery.size.width / 25,
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${context.locale.languageCode == 'ar' ? Utils().convertToArabicNumber(provider.groupedBy[indexList].kenshat.length.toString()) : provider.groupedBy[indexList].kenshat.length} ${'poem'.tr()}",
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
                    Container(
                      height: 60,
                      width: mediaQuery.size.width * .9,
                      child: TextFormField(
                        cursorRadius: Radius.circular(10),
                        controller: provider.searchController,
                        onChanged: (value) {
                          provider.searchValue = value;
                        },
                        textAlign: TextAlign.right,
                        cursorColor: Constants.primary,
                        decoration: InputDecoration(
                          prefixIconColor: Color(0xff8C8C8C),
                          hintText: 'search_in_poems'.tr(),
                          filled: true,
                          fillColor: Colors.white,
                          focusColor: Constants.primary,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintStyle: TextStyle(
                            color: Color(0xff8C8C8C),
                            fontFamily: 'Cairo',
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 30,
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
                                provider.searchHomeMethod(searchValue: '');
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: mediaQuery.size.height / 1.55,
                      width: mediaQuery.size.height,
                      child: provider.groupedBy[indexList].kenshat.isEmpty
                          ? Container(
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
                                      'there_is_no_Dwaween'.tr(),
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
                          : ListView.builder(
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
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/images/icons/ic_ksaed.svg",
                                                  height: 25,
                                                  width: 25,
                                                ),
                                                Text(
                                                  provider.groupedBy[indexList]
                                                      .kenshat[index].name,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.teal,
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      provider
                                                          .groupedBy[indexList]
                                                          .kenshat[index]
                                                          .kaseydaT
                                                          .split('.')
                                                          .first,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black45,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 12,
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      provider
                                                          .groupedBy[indexList]
                                                          .kenshat[index]
                                                          .kaseydaT
                                                          .split('.')[1],
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black45,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: () {
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
                              itemCount: provider.dewanBody!.dawawen.length > 15
                                  ? 15
                                  : provider.dewanBody?.dawawen.length,
                            ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
