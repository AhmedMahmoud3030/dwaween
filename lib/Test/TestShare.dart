import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';


class CustomDialog extends StatefulWidget {
  final String kasedaName;
  final String kaseda;
  final List<String> allText;


  CustomDialog({Key? key, required this.kasedaName, required this.kaseda, required this.allText}) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  bool shareTextSelected = false;
  ScreenshotController screenshotController = ScreenshotController();

  int currentImageIndex=0;
  @override
  Widget build(BuildContext context) {
    var k = widget.kaseda.toString().split(".");

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),

      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      shareTextSelected = true;
                    });
                  },
                  style:
                  ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color:shareTextSelected? Colors.black: Colors.white),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text('مشاركة كنص',style: TextStyle(fontFamily: 'Cairo'),),
                      SizedBox(width: 8),
                      Icon(Icons.text_fields),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      shareTextSelected = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color:!shareTextSelected? Colors.black: Colors.white),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text('مشاركة كصورة',style: TextStyle(fontFamily: 'Cairo'),),
                      SizedBox(width: 8),
                      Icon(Icons.image),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),


            //قائمة الصور
            Visibility(
              visible: !shareTextSelected,
              child: Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4, // Replace with the actual number of images
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          currentImageIndex=index;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.all(8),
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10)
                            ),
                            child: Image.asset(
                              'assets/img/imageShareList$index.jpg',fit: BoxFit.fill,

                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ),
            SizedBox(height: 8),
            Screenshot(
              controller: screenshotController,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    //الصورة المختارة
                    Visibility(
                      visible: !shareTextSelected,
                      child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Image.asset(
                          'assets/img/imageShareList${currentImageIndex}.jpg', // Replace with actual asset path
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    //النصوص
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(widget.allText[0],style: TextStyle(fontFamily: 'Cairo'),),
                        Text(widget.allText[1],style: TextStyle(fontFamily: 'Cairo'),),
                        Text(widget.allText[2],style: TextStyle(fontFamily: 'Cairo'),),
                        Text(widget.allText[3],style: TextStyle(fontFamily: 'Cairo'),),
                      ],
                    ),

                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('شبكة تراث الفيضة التجارية',style: TextStyle(fontFamily: 'Cairo',fontSize: 10,fontWeight: FontWeight.w300,color: Colors.black54)),

                        Image.asset('assets/img/splash.png',width: 30,height: 30,), // Replace with actual asset path
                        Text('تطبيق دواوين الشيخ إبراهيم نياس',style: TextStyle(fontFamily: 'Cairo',fontSize: 10,fontWeight: FontWeight.w300,color: Colors.black54),),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                if(shareTextSelected){
                  shareText();
                }else{
                  captureScreenShot(context);
                }
              },
              child: Text('مشاركة',style: TextStyle(fontFamily: 'Cairo'),),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
  shareText()async{
    final box = context.findRenderObject() as RenderBox;
    await Share.share("\n${widget.kasedaName}\n\n${widget.kaseda}\n\n",
        subject: "",
        sharePositionOrigin:
        box.localToGlobal(Offset.zero) &
        box.size);
  }


  //التقاط الصورة
  void captureScreenShot(BuildContext context) async{
    final directory = await getTemporaryDirectory();
    Uint8List? imageBytes = await screenshotController.capture();
    String dateTime=DateTime.now().year.toString()+DateTime.now().month.toString()+DateTime.now().day.toString()+DateTime.now().hour.toString()+DateTime.now().minute.toString()+DateTime.now().second.toString();
    String filePath = '${directory.path}/screenshot$dateTime.png';
    await File(filePath).writeAsBytes(imageBytes!);
    // File tempFile = File(filePath);
    await Share.shareFiles([filePath],
        text: '${widget.kasedaName}',
        subject: '');
    // saveImageToGallery(context,imageBytes);

  }

}
