import 'package:dwaween/core/constants.dart';
import 'package:dwaween/core/nav.dart';
import 'package:flutter/material.dart';


class AboutUs extends StatefulWidget {
  const AboutUs({Key? key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  var formKey=GlobalKey<FormState>();
  String text=" منصة تعلمك من الصفر إلى الإحتراف أو تعدل أغلاطك بأيسر الطرق من غير لف و دوران ، فجمعنا لكم ثلاثة طُرق تعلم وهي طريقة التعلم البصرية و السمعية و الكتابية و كده راح يسهل عليك التطبيق العملي وتختصر مشـوار طويل في التعلم فالتطبيق تم تجربته على ";

  @override
  Widget build(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    double height= MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar:AppBar(
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            title: Row(
              children: <Widget>[
                Container(
                    child: Text(
                      'حول التطبيق',
                      style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width/22,
                        fontFamily: "Cairo",

                      ),

                    )),
                Expanded(child: Container(),),

              ],
            ),
            backgroundColor: Constants.primary,
          ),

          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child:  Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Colors.white
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      SizedBox(height: 20,),
                      Container(
                        width: width,
                        padding: EdgeInsets.symmetric(horizontal: 28),
                        decoration: BoxDecoration(
                          color: Colors.white,

                        ),
                        child: Text(
                          text,
                          style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 20),
                        ),
                      )
                    ])),
          )),
    );
  }
}
