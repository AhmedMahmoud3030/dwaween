import 'package:dwaween/Screens/About/about.dart';
import 'package:dwaween/Screens/DwawenList/DewanDetails/DewanTeserWsol.dart';
import 'package:dwaween/Screens/Knanish/KasayedDetails/KasydaDetails.dart';
import 'package:dwaween/core/constants.dart';
import 'package:dwaween/core/nav.dart';
import 'package:dwaween/core/utils.dart';
import 'package:dwaween/features/Base/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class DwaweenScreen extends StatefulWidget {
  @override
  State<DwaweenScreen> createState() => _DwaweenScreenState();
}

class _DwaweenScreenState extends State<DwaweenScreen> {
  @override
  void initState() {
    Future(() =>
        Provider.of<BaseProvider>(context, listen: true).readDwaweenData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var x = Provider.of<BaseProvider>(context, listen: true);

    return Consumer<DwaweenProvider>(
      builder: (BuildContext context, provider, Widget? child) => Stack(
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
                    height: mediaQuery.size.height * .06,
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
                            "assets/images/icons/ic_dwawen2.svg",
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
                            "dwaween".tr(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: mediaQuery.size.width / 25,
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'search_all_dwaween'.tr(),
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
                  Container(
                    height: mediaQuery.size.height / 1.55,
                    width: mediaQuery.size.height,
                    child: x.dewanBody!.dawawen!.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: x.dewanBody?.dawawen?.length ?? 0,
                            itemBuilder: (BuildContext context, index) {
                              return InkWell(
                                child: Visibility(
                                  visible: x.dewanBody!.dawawen![index].kasaed!
                                      .isNotEmpty,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal:
                                              mediaQuery.size.width / 40),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Colors.white,
                                      ),
                                      child: ListTile(
                                        trailing: SvgPicture.asset(
                                          "assets/images/icons/ic_ksaed.svg",
                                          height: mediaQuery.size.width / 12,
                                          width: mediaQuery.size.width / 12,
                                        ),
                                        title: Align(
                                          alignment: Alignment.centerRight,
                                          child: provider.searchValue.isNotEmpty
                                              ? ColoredText(
                                                  text: x
                                                          .dewanBody
                                                          ?.dawawen?[index]
                                                          .name ??
                                                      '',
                                                  value: provider.searchValue,
                                                  context: context,
                                                )
                                              : Text(
                                                  x.dewanBody?.dawawen?[index]
                                                          .name ??
                                                      '',
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: mediaQuery
                                                              .size.width /
                                                          25,
                                                      fontFamily: "Cairo"),
                                                ),
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(" قصيده",
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily: "Cairo")),
                                            Visibility(
                                              visible: x
                                                  .dewanBody!
                                                  .dawawen![index]
                                                  .kasaed!
                                                  .isNotEmpty,
                                              child: Text(
                                                  context.locale.languageCode ==
                                                          'ar'
                                                      ? Utils()
                                                          .convertToArabicNumber(
                                                              x
                                                                  .dewanBody!
                                                                  .dawawen![
                                                                      index]
                                                                  .kasaed!
                                                                  .length
                                                                  .toString())
                                                      : x
                                                          .dewanBody!
                                                          .dawawen![index]
                                                          .kasaed!
                                                          .length
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontFamily: "Cairo")),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  // Get.to(() => const DewanDetails());
                                  if (x.dewanBody!.dawawen![index].kasaed!
                                      .isNotEmpty) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DewanTeserWsol(),
                                      ),
                                    );
                                  } else {
                                    navigateTo(
                                        context,
                                        KasydaDetails(
                                          kasyeda: items[index]['Kaseyda'],
                                          kasyedaT: items[index]['KaseydaT'],
                                          kasyedaTRepeat: items[index]
                                              ['KaseydaT'],
                                          KName: items[index]['name'],
                                          KNameT: items[index]['KnameT'],
                                          DName: "",
                                        ));
                                  }
                                  // else {
                                  //   displayToastMessage(
                                  //       "عفوا لا يوجد قصائد حاليا فى حذا الديوان");
                                  // }
                                },
                              );
                            })
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Center(
                                child: SpinKitCircle(
                              color: Constants.primary,
                            )),
                          ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ColoredText extends StatelessWidget {
  String text;
  String value;
  BuildContext context;

  ColoredText({required this.text, required this.value, required this.context});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: _buildTextSpans(),
      ),
    );
  }

  List<TextSpan> _buildTextSpans() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int blackWordsCount = 0;

    final List<TextSpan> spans = [];

    // Split the text by space to apply styling to individual words
    final List<String> words = text.split(' ');

    for (int i = 0; i < words.length; i++) {
      final String word = words[i];

      if (word.toLowerCase().contains(value)) {
        blackWordsCount = 0;
        spans.add(
          TextSpan(
            text: '$word ',
            style: TextStyle(
              color: Colors.teal,
              fontSize: width / 30,
              fontFamily: "Cairo",
            ),
          ),
        );
      } else {
        if (blackWordsCount < 4) {
          spans.add(
            TextSpan(
              text: '$word ',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: width / 30,
                  fontFamily: "Cairo"),
            ),
          );
        }
        blackWordsCount++;
      }
    }

    return spans;
  }
}
