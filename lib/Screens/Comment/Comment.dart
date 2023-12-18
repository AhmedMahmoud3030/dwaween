import 'package:dwaween/core/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class Comment extends StatefulWidget {
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  TextEditingController tECComment= TextEditingController();


  senToMustafa() async {

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'imp4com@gmail.com',
      queryParameters: {
        'subject': 'تطبيق_دواوين',
        'body': tECComment.text ?? ''
      },
    );
    launchUrl(emailLaunchUri);
  }

  @override
  Widget build(BuildContext context) {
    double shadow=.8;
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

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
                    'تواصل معنا',
                    style: TextStyle(
                      fontFamily: "Cairo",
                      color: Colors.white,fontSize: MediaQuery.of(context).size.width/22,
                      shadows: [
                      Shadow( // bottomLeft
                          offset: Offset(-shadow, -shadow),
                          color: Colors.black38
                      ),
                      Shadow( // bottomLeft
                          offset: Offset(shadow,shadow),
                          color: Colors.black38
                      ),

                      Shadow( // bottomLeft
                          offset: Offset(-shadow, shadow),
                          color: Colors.black38
                      ),

                      Shadow( // bottomLeft
                          offset: Offset(shadow, -shadow),
                          color: Colors.black38
                      ),

                    ],),

                  )),
              Expanded(child: Container(),),
              Container(child: Image.asset("assets/img/message.png",width: MediaQuery.of(context).size.width/10,height: MediaQuery.of(context).size.width/10,),)

            ],
          ),

          backgroundColor: Constants.primary,
        ),
        body: Container(
          color: Color(0xfff8f9f9),
          child: ListView(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                alignment:Alignment.center,
                margin: EdgeInsets.all(MediaQuery.of(context).size.width/12),
                child: Text("يمكنك ارسال استفساراتك أو اقتراحاتك عن طريق البريد الإلكترونى",
                    style: TextStyle(fontSize:MediaQuery.of(context).size.width / 25,
                        color: Colors.black,fontFamily: "Cairo")),
              ),
              Container(
                margin: EdgeInsets.all(MediaQuery.of(context).size.width/20),
                child: Stack(
                  children: <Widget>[

                    //خلفية الكارت
                    Container(

                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width/1.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            //مستوى الوضوح مع اللون
                            color: Colors.grey.withOpacity(0.7),
                            //مدى انتشارة
                            spreadRadius: 2,
                            //مدى تقلة
                            blurRadius: 5,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                    //المحتوى
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(MediaQuery.of(context).size.width/20),
                          child: TextField(

                            controller: tECComment,

                            decoration: InputDecoration(
                              hintText: 'أضف سؤال أو استفسار...',
                              hintStyle: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.width/25),
                            ),
                            cursorColor: Constants.primary,
                            maxLines: 6,
                          ),
                        )
                      ],),

                  ],
                ),

              ),
              SizedBox(height: height/30,),
              Container(
                width: width,
                alignment: Alignment.center,
                child: DefaultElevatedButton(
                  title: 'ارسل',
                  titleSize: width/20,
                  width: width/2.5,
                  height: height/20,
                  borderRadius: 35,
                  color: Constants.primary,
                  onPressed: (){
                    senToMustafa();
                    //displayToastMessage("$currentIndex");
                  },
                ),
              ),


            ],
          ),
        ),

      ),
    );
  }
}
class DefaultElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final double? titleSize;
  final Color? color;
  final double? borderRadius;
  final double? height;
  final double? width;

  const DefaultElevatedButton({
    Key? key,
    required this.onPressed,
    required this.titleSize,
    required this.title,
    required this.color,
    required this.borderRadius,
    required this.height,
    required this.width,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //alignment: Alignment.center,
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color!),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius!),
              ),
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: titleSize,
            fontFamily: "Cairo"
          ),
        ),
      ),
    );
  }
}
