import 'package:dwaween/core/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../provider.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Consumer<BaseProvider>(
      builder: (BuildContext context, provider, Widget? child) => Stack(
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
                          provider.searchMethod( searchValue: '', );
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
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'his_birth_and_upbringing'.tr(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Constants.primary2,
                                        fontSize: 18,
                                        fontFamily: "Cairo"),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: .8,
                                    color: Constants.primary2,
                                  ),
                                  Text(
                                    'brief_about_him'.tr(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black54,
                                        fontSize: 14,
                                        fontFamily: "Cairo"),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Image.asset(
                                    "assets/images/paintings/shikh.png"),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'his_elders'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Constants.primary2,
                                  fontSize: 18,
                                  fontFamily: "Cairo"),
                            ),
                            Container(
                              width: double.infinity,
                              height: .8,
                              color: Constants.primary2,
                            ),
                            Text(
                              'his_elders_brief'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: "Cairo"),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'scholars_granted_him_permission'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Constants.primary2,
                                  fontSize: 18,
                                  fontFamily: "Cairo"),
                            ),
                            Container(
                              width: double.infinity,
                              height: .8,
                              color: Constants.primary2,
                            ),
                            Text(
                              'there_are_very_many'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: "Cairo"),
                            ),
                            Text(
                              'scholars_1'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: "Cairo"),
                            ),
                            Text(
                              'scholars_2'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: "Cairo"),
                            ),
                            Text(
                              'scholars_3'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: "Cairo"),
                            ),
                            Text(
                              'scholars_4'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: "Cairo"),
                            ),
                            Text(
                              'scholars_5'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: "Cairo"),
                            ),
                            Text(
                              'scholars_6'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: "Cairo"),
                            ),
                            Text(
                              'scholars_7'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: "Cairo"),
                            ),
                            Text(
                              'scholars_8'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: "Cairo"),
                            ),
                            Text(
                              'scholars_9'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: "Cairo"),
                            ),
                            Text(
                              'scholars_10'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: "Cairo"),
                            ),
                            Text(
                              'scholars_11'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: "Cairo"),
                            ),
                            Text(
                              'scholars_12'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: "Cairo"),
                            ),
                            Text(
                              'scholars_13'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: "Cairo"),
                            ),
                            Text(
                              'scholars_14'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: "Cairo"),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
