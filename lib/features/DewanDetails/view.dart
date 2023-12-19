import 'package:dwaween/core/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class DewanDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Consumer<DewanDetailsProvider>(
      builder: (BuildContext context, provider, Widget? child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Constants.bgColor,
                image: DecorationImage(
                  image: AssetImage('assets/images/paintings/BG.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  SvgPicture.asset(
                    "assets/img/banner2.svg",
                    alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width * 4,
                    height: MediaQuery.of(context).size.height / 2,
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ' ${'dewan'.tr()}${provider.dawawen?.nameT}',
                                style: TextStyle(
                                  fontSize: 12,
                                  // fontFamily: "Cairo",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                  ' ${'number_of_poems'.tr()} ${provider.dawawen?.kasaed!.length} ${'poem'.tr()}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    // fontFamily: "Cairo",
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new_sharp,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      Container(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextFormField(
                          cursorRadius: Radius.circular(10),
                          controller: provider.searchController,
                          onChanged: (value) {
                            provider.setSearchValue(value: value);
                          },
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
                              visible:
                                  provider.searchController.text.length > 0,
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
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 220,
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        width: mediaQuery.size.width * .9,
                        height: mediaQuery.size.height * .17,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 20,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "${'brief_about_dewan'.tr()}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Constants.primary,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Cairo"),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      height: .5,
                                      width: double.infinity,
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                        child: Hero(
                                          tag: provider.dawawen!.dec!,
                                          child: SimpleDialog(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Text(
                                                  provider.dawawen!.dec!,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  provider.dawawen!.dec!,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/images/icons/ic_kafya.svg",
                              height: 30,
                              width: 30,
                            ),
                            Text(
                              "${'kwafy'.tr()}",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Constants.primary2,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Cairo"),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                height: .6,
                                width: double.infinity,
                                color: Constants.primary2,
                              ),
                            )
                          ],
                        ),
                      ),

                      Container(
                        // padding: EdgeI nsets.symmetric(horizontal: 8, vertical: 6),
                        height: mediaQuery.size.height * .18,
                        width: mediaQuery.size.width * .9,
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6,
                            childAspectRatio: 1.8,
                          ),
                          itemCount: provider.kafya.length,
                          itemBuilder: (context, indexGrid) {
                            return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: GestureDetector(
                                onTap: () {
                                  provider.selectKafya(
                                      selectValue: indexGrid,
                                      letter: provider.kafya[indexGrid]);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: indexGrid == provider.kafyaIndex
                                          ? Constants.primary
                                          : Color(0xffE9E9E9),
                                      borderRadius: BorderRadius.circular(5)),
                                  height: 10,
                                  width: 10,
                                  child: Center(
                                      child: Text(
                                    provider.kafya[indexGrid],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: indexGrid == provider.kafyaIndex
                                            ? Colors.white
                                            : Constants.primary2),
                                  )),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Visibility(
                              visible: true,
                              child: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(
                              width: 260,
                              child: Divider(
                                color: Colors.teal,
                                thickness: 1.5,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // القوافى
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 260,
                              child: Divider(
                                color: Colors.teal,
                                thickness: 1.5,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("القصائد ",
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontFamily: "Cairo",
                                    fontWeight: FontWeight.bold)),
                            SvgPicture.asset(
                              "assets/images/icons/ic_ksaed.svg",
                              height: 25,
                              width: 25,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                  //
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// class ExpandableText extends StatefulWidget {
//   const ExpandableText(
//     this.text, {
//     Key? key,
//     this.trimLines = 2,
//   }) : super(key: key);

//   final String text;
//   final int trimLines;

//   @override
//   ExpandableTextState createState() => ExpandableTextState();
// }

// class ExpandableTextState extends State<ExpandableText> {
//   bool _readMore = true;
//   void _onTapLink() {
//     setState(() => _readMore = !_readMore);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colorClickableText = Colors.blue;
//     final widgetColor = Colors.black;
//     TextSpan link = TextSpan(
//         text: _readMore ? "... اقرأ المزيد" : "  اقرأ أقل",
//         style: TextStyle(color: colorClickableText, fontFamily: "Cairo"),
//         recognizer: TapGestureRecognizer()..onTap = _onTapLink);
//     Widget result = LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//         assert(constraints.hasBoundedWidth);
//         final double maxWidth = constraints.maxWidth;
//         // Create a TextSpan with data
//         final text = TextSpan(
//           text: widget.text,
//         );
//         // Layout and measure link
//         TextPainter textPainter = TextPainter(
//           text: link,
//           maxLines: widget.trimLines,
//           ellipsis: '...',
//         );
//         textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
//         final linkSize = textPainter.size;
//         // Layout and measure text
//         textPainter.text = text;
//         textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
//         final textSize = textPainter.size;
//         // Get the endIndex of data
//         int endIndex;
//         final pos = textPainter.getPositionForOffset(Offset(
//           textSize.width - linkSize.width,
//           textSize.height,
//         ));
//         endIndex = textPainter.getOffsetBefore(pos.offset)!;
//         var textSpan;
//         if (textPainter.didExceedMaxLines) {
//           textSpan = TextSpan(
//             text: _readMore ? widget.text.substring(0, endIndex) : widget.text,
//             style: TextStyle(color: widgetColor, fontFamily: "Cairo"),
//             children: <TextSpan>[link],
//           );
//         } else {
//           textSpan = TextSpan(
//             text: widget.text,
//           );
//         }
//         return RichText(
//           softWrap: true,
//           overflow: TextOverflow.clip,
//           text: textSpan,
//           textAlign: TextAlign.right,
//         );
//       },
//     );
//     return result;
//   }
// }