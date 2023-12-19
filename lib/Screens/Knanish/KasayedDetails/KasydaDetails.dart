import 'package:dwaween/Hive_Services/boxes.dart';
import 'package:dwaween/Models/FavModel.dart';
import 'package:dwaween/core/constants.dart';
import 'package:dwaween/core/help/database_helper_fav.dart';
import 'package:dwaween/core/help/database_helper_notification.dart';
import 'package:dwaween/core/nav.dart';
import 'package:dwaween/models/NoteModel.dart';
import 'package:dwaween/models/favourite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screenshot/screenshot.dart';
import '../../../Test/TestShare.dart';
import 'AudioPlayer/audiobar.dart';
import 'mainkasyeda.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class KasydaDetails extends StatefulWidget {
  String kasyeda;
  String KName;
  String kasyedaT;
  String kasyedaTRepeat;
  String KNameT;


  String DName;

  bool p = false;

  KasydaDetails(
      {Key? key,
      required this.kasyeda,
      required this.KName,
      required this.DName,
      this.kasyedaT='',
      this.kasyedaTRepeat='',
      this.KNameT='',
      })
      : super(key: key);



  @override
  State<KasydaDetails> createState() => _KasydaDetailsState();
}



class _KasydaDetailsState extends State<KasydaDetails> {
  DatabaseHelperNotificarion dbNotify = new DatabaseHelperNotificarion();
  DatabaseHelperFavourite dbFav = new DatabaseHelperFavourite();

  bool _isSnackbarActive = false;
  final TextEditingController _searchController = TextEditingController();

  String SearchValue = "";

  late AudioPlayer _audioPlayer;
  Stream<PositionData> get _postionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _audioPlayer.positionStream,
          _audioPlayer.bufferedPositionStream,
          _audioPlayer.durationStream,
          (position, bufferedPosition, duration) => PositionData(
                position,
                bufferedPosition,
                duration ?? Duration.zero,
              ));


  bool isFav=false;
  int favIndex=0;

  String color="";

  TextEditingController tc_title = TextEditingController();
  TextEditingController tc_body = TextEditingController();
  Color textcolor = Colors.teal;
  Color backColor = Color.fromARGB(255, 253, 253, 234);
  double textsize = 20;
  bool loobMode = false;

  ScreenshotController screenshotController = ScreenshotController();

  List<FavModel> allFav =  <FavModel>[];
  FavModel favModel=FavModel('','','','');

  List<String> allTexts = [];

  List<String> selectedTexts = [];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer()..setAsset('assets/tone10.mp3');
    getAllData();
    readData2();
  }


  getAllData()async{
    allFav =  <FavModel>[];
    await dbFav.getAllFav().then((duaaModels){
      setState((){
        duaaModels.forEach((duaaModel){
          allFav.add(FavModel.fromMap(duaaModel));
        });
      });
    });

    for(int i=0;i<allFav.length;i++){
      if(allFav[i].kName==widget.KName){
        setState(() {
          favModel=allFav[i];
          isFav=true;
        });
      }
    }
  }
  readData2() async {
    var k = widget.kasyeda.toString().split(".");
    var kT = widget.kasyedaTRepeat.toString().split(".");
    widget.kasyedaT='';


    if(SearchValue.isNotEmpty){
      for(int i=0;i<k.length;i++){
        if(k[i].contains(SearchValue)){
          widget.kasyedaT+=kT[i]+'.';
        }
      }
    }else{
      widget.kasyedaT=widget.kasyedaTRepeat;

      //للمشاركة
      for(int i=0;i<kT.length;i++){
        allTexts.add(kT[i]);
      }

    }
    print('${SearchValue}');
    print('${widget.kasyedaT}');

    setState(() {});

  }

  void getFavourite() {
    for(int i=0;i<boxFavourite.length;i++){
      Favourite favourite=boxFavourite.getAt(i);

      if(widget.KName==favourite.Dname){
        setState(() {
          favIndex=i;
          isFav=true;
        });
      }
    }
  }
  Future<void> onSetRepeatMode() async {
    setState(() {
        if(loobMode){
          _audioPlayer.setLoopMode(LoopMode.off);
          loobMode=false;

        }else{
          _audioPlayer.setLoopMode(LoopMode.all);
          loobMode=true;
        }
    });

  }

  onBackPressed(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    navigateBack(context);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double d1 = width / 12;
    double d3 = width / 25;
    double d4 = height / 40;
    return WillPopScope(
      onWillPop:()=>onBackPressed(context),
      child: Scaffold(
        body: Screenshot(
          controller: screenshotController,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: height,
                  color: backColor,
                ),
                SvgPicture.asset(
                  "assets/img/BG.svg",
                  alignment: Alignment.topCenter,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
                SafeArea(
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
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: height / 9,
                            child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Text(widget.KName,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Amiri Regular",
                                          color: Colors.white)),
                                  Text(widget.KNameT==''?widget.KName:widget.KNameT,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Amiri Regular",
                                          color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                          ),
                          Container(
                            height: height / 15,
                            color: backColor,
                            // Add padding around the search bar
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            // Use a Material design search bar
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                setState(() {

                                  SearchValue = value;
                                  readData2();
                                });
                              },
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                hintText: 'البحث فى القصيدة',
                                filled: true,

                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3, color: Colors.white),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),

                                // Add a clear button to the search bar
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () {},
                                ),
                                // Add a search icon or button to the search bar
                                prefixIcon: _searchController.text.length > 0
                                    ? IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed: () {
                                          _searchController.clear();
                                          setState(() {
                                            SearchValue = "";
                                          });
                                          readData2();

                                        },
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: height / 4,
                    ),
                    Container(
                      height: height / 1.75,
                      child: kasyedaArea(
                        value:SearchValue,
                        kasyeda: widget.kasyedaT,
                        textcolor: textcolor,
                        size: textsize,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          child: StreamBuilder<PositionData>(
            stream: _postionDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return SafeArea(
                child: Container(
                  height: height / 6.5,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 27, 161, 134),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: IconButton(
                              icon: SvgPicture.asset(
                                "assets/img/ic_mnshed.svg",
                              ),
                              onPressed: () {
                                if (_isSnackbarActive) {
                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                  _isSnackbarActive = false;
                                } else {
                                  _isSnackbarActive = true;
                                  //Bottom Sheet
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                          duration: const Duration(minutes: 5),
                                          content: Container(
                                            padding: EdgeInsets.all(10),
                                            height: height / 1.8,
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap:(){
                                                    print("object");
                                                    setState(() {
                                                      ScaffoldMessenger.of(context).hideCurrentSnackBar();

                                                    });
                                                  },
                                                  child: SizedBox(
                                                    height: 15,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Icon(Icons.close,size: width/15,)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                      style: TextButton.styleFrom(
                                                        foregroundColor: Colors.white,
                                                        padding: const EdgeInsets.all(8.0),
                                                        textStyle: const TextStyle(fontSize: 16),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          if(isFav){
                                                            deleteFav(favModel);
                                                            displayToastMessage("تم حذف القصيدة من المفضلة");
                                                            isFav=false;
                                                          }else{
                                                            saveFav(widget.KName,widget.kasyeda,widget.KNameT,widget.kasyedaTRepeat);
                                                            displayToastMessage("تم اضافة القصيدة للمفضلة");
                                                            isFav=true;
                                                          }

                                                          getAllData();
                                                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                        });

                                                      },
                                                      child: Text(
                                                        isFav?"حذف من المفضلة":"اضافة للمفضلة",
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(color: Colors.teal, fontFamily: "Cairo"),
                                                      ),
                                                    ),
                                                    Image.asset(
                                                      "assets/img/fav.png",
                                                      width: d1,
                                                      height: d1,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  child: Divider(
                                                    color: const Color.fromARGB(
                                                        255, 135, 138, 138),
                                                  ),
                                                ),
                                                //ملحوظات
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                      style: TextButton.styleFrom(
                                                        foregroundColor: Colors.white,
                                                        padding: const EdgeInsets.all(8.0),
                                                        textStyle: const TextStyle(fontSize: 16),
                                                      ),
                                                      onPressed: () {
                                                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(
                                                            duration: Duration(minutes: 2),
                                                            content: Container(
                                                              padding: EdgeInsets.all(16),
                                                              height: 310,
                                                              decoration: BoxDecoration(color: Colors.white,
                                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                              ),
                                                              child: Container(
                                                                child: Column(
                                                                  children: [
                                                                    SizedBox(
                                                                      child: Text("ملحوظات",
                                                                        style: TextStyle(
                                                                            fontFamily: "Cairo",
                                                                            color: Colors.teal),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(8.0),
                                                                      child: Row(
                                                                        children: [
                                                                          Flexible(
                                                                            child: TextField(
                                                                              decoration: InputDecoration(
                                                                                hintStyle: TextStyle(color: Colors.teal),
                                                                                hintText: "اضف العنوان",
                                                                              ),
                                                                              controller: tc_title,
                                                                              textAlign: TextAlign.right,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(8.0),
                                                                      child: Row(
                                                                        children: [
                                                                          Flexible(
                                                                            child: TextField(decoration: InputDecoration(hintStyle: TextStyle(color: Colors.teal), hintText: "اضف ملحوظه",
                                                                              ),
                                                                              controller: tc_body,
                                                                              textAlign: TextAlign.right,
                                                                              maxLines: 4,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment: Alignment.center,
                                                                      child:
                                                                        Padding(
                                                                          padding: const EdgeInsets.all(8.0),
                                                                          child: Row(
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              ElevatedButton(
                                                                                      onPressed: () {
                                                                                          if(tc_title.text.isEmpty){
                                                                                            displayToastMessage("حقل العنوان فارغ");
                                                                                          }else if(tc_body.text.isEmpty){
                                                                                            displayToastMessage("حقل النص فارغ");
                                                                                          }else{

                                                                                            displayToastMessage("تم اضافة الملاحظة");
                                                                                            saveNote(tc_title.text,tc_body.text,widget.KName,widget.kasyeda,widget.KNameT,widget.kasyedaTRepeat);
                                                                                            ScaffoldMessenger.of(context).hideCurrentSnackBar();

                                                                                          }
                                                                                    },
                                                                            child: Text("حفظ", textAlign: TextAlign.right,
                                                                                      style: TextStyle(color: Colors.teal, fontFamily: "Cairo", fontSize: 14),),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            behavior: SnackBarBehavior.floating,
                                                            backgroundColor: Colors.transparent,
                                                            elevation: 0,
                                                          ),
                                                        );

                                                      },
                                                      child: Text(
                                                        "أضف ملاحظة",
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                            color: Colors.teal,
                                                            fontFamily: "Cairo"),
                                                      ),
                                                    ),
                                                    Image.asset(
                                                      "assets/img/notes.png",
                                                      width: d1,
                                                      height: d1,
                                                      fit: BoxFit.fill,
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  child: Divider(color: const Color.fromARGB(255, 135, 138, 138)),
                                                ),
                                                SizedBox(height: 10,),

                                                //حجم الخط
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                      style: TextButton.styleFrom(
                                                        foregroundColor:
                                                            Colors.white,
                                                        padding:
                                                            const EdgeInsets.all(
                                                                8.0),
                                                        textStyle:
                                                            const TextStyle(
                                                                fontSize: 16),
                                                      ),
                                                      onPressed: () {
                                                        if(textsize==10){
                                                          displayToastMessage("عذرا لا يمكن تصغير حجم الخط اكثر من ذلك");
                                                        }else{
                                                          setState(() {
                                                            textsize -= 5;
                                                          });
                                                        }
                                                        ScaffoldMessenger.of(context).hideCurrentSnackBar();

                                                      },
                                                      child: Text(
                                                        "-",
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                            fontSize: 35,
                                                            color: Colors.teal,
                                                            fontFamily: "Cairo"),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    TextButton(
                                                      style: TextButton.styleFrom(
                                                        foregroundColor:
                                                            Colors.teal,
                                                        backgroundColor:
                                                            Colors.teal,
                                                        padding:
                                                            const EdgeInsets.all(
                                                                8.0),
                                                        textStyle:
                                                            const TextStyle(
                                                                fontSize: 16),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          textsize = 20;
                                                        });
                                                        ScaffoldMessenger.of(context).hideCurrentSnackBar();

                                                      },
                                                      child: Text(
                                                        "=",
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: "Cairo"),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    TextButton(
                                                      style: TextButton.styleFrom(
                                                        foregroundColor: Colors.white,
                                                        padding: const EdgeInsets.all(8.0),
                                                        textStyle: const TextStyle(fontSize: 16),
                                                      ),
                                                      onPressed: () {
                                                        if(textsize==50){
                                                          displayToastMessage("عذرا لا يمكن تكبير حجم الخط اكثر من ذلك");
                                                        }else{
                                                          setState(() {
                                                            textsize += 5;
                                                          });
                                                        }

                                                        ScaffoldMessenger.of(context).hideCurrentSnackBar();

                                                      },
                                                      child: Text(
                                                        "+",
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                            color: Colors.teal,
                                                            fontSize: 25,
                                                            fontFamily: "Cairo"),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    TextButton(
                                                      style: TextButton.styleFrom(
                                                        foregroundColor: Colors.white,
                                                        padding: const EdgeInsets.all(8.0),
                                                        textStyle: const TextStyle(fontSize: 16),
                                                      ),
                                                      onPressed: () {
                                                        //function
                                                      },
                                                      child: Text(
                                                        "حجم الخط",
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                            color: Colors.teal,
                                                            fontFamily: "Cairo"),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  child: Divider(
                                                      color: const Color.fromARGB(255, 135, 138, 138)),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [

                                                    TextButton(
                                                      style: TextButton.styleFrom(
                                                        foregroundColor: Colors.white,
                                                        padding: const EdgeInsets.all(8.0),
                                                        textStyle: const TextStyle(fontSize: 12),
                                                      ),
                                                      onPressed: () {
                                                        ScaffoldMessenger.of(context).hideCurrentSnackBar();

                                                        openSelectionDialog(context);

                                                      },
                                                      child: Text(
                                                        "مشاركه  القصيدة",
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(
                                                            color: Colors.teal,
                                                            fontSize: 16,
                                                            fontFamily: "Cairo"),
                                                      ),
                                                    ),
                                                    Image.asset(
                                                      "assets/img/share.png",
                                                      width: d1,
                                                      height: d1,
                                                      fit: BoxFit.fill,
                                                    ),

                                                  ],
                                                ),
                                                SizedBox(
                                                  child: Divider(
                                                      //height: 2,
                                                      color: const Color.fromARGB(255, 135, 138, 138)),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),

                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    SizedBox(
                                                      width: 35.0,
                                                      height: 35.0,
                                                      child: InkWell(
                                                        child: const DecoratedBox(
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: Color.fromARGB(255, 81, 222, 207),
                                                                  shape: BoxShape.circle),
                                                        ),
                                                        onTap: () {
                                                          setState(() {
                                                            textcolor = Color.fromARGB(255, 81, 222, 207);
                                                          });
                                                          ScaffoldMessenger.of(context).hideCurrentSnackBar();

                                                        },
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    SizedBox(
                                                      width: 35.0,
                                                      height: 35.0,
                                                      child: InkWell(
                                                        child: const DecoratedBox(
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: Color.fromARGB(255, 4, 126, 99),
                                                                  shape: BoxShape.circle),
                                                        ),
                                                        onTap: () {
                                                          setState(() {
                                                            textcolor = Color.fromARGB(255,4,126,99);
                                                          });
                                                          ScaffoldMessenger.of(context).hideCurrentSnackBar();

                                                        },
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    SizedBox(
                                                      width: 35.0,
                                                      height: 35.0,
                                                      child: InkWell(
                                                        child: const DecoratedBox(
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: Color
                                                                      .fromARGB(255, 15, 38, 76),
                                                                  shape: BoxShape.circle),
                                                        ),
                                                        onTap: () {
                                                          setState(() {
                                                            textcolor = Color.fromARGB(255, 15, 38, 76);
                                                          });
                                                          ScaffoldMessenger.of(context).hideCurrentSnackBar();

                                                        },
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    SizedBox(
                                                      width: 35.0,
                                                      height: 35.0,
                                                      child: InkWell(
                                                        child: DecoratedBox(
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: Colors.teal,
                                                                  shape: BoxShape.circle),
                                                        ),
                                                        onTap: () {
                                                          setState(() {
                                                            textcolor = Colors.teal;
                                                          });
                                                          ScaffoldMessenger.of(context).hideCurrentSnackBar();

                                                        },
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    SizedBox(
                                                      width: 35.0,
                                                      height: 35.0,
                                                      child: InkWell(
                                                        child: DecoratedBox(
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: Colors.black,
                                                                  shape: BoxShape.circle),
                                                        ),
                                                        onTap: () {
                                                          setState(() {
                                                            textcolor = Colors.black;
                                                          });
                                                          ScaffoldMessenger.of(context).hideCurrentSnackBar();

                                                        },
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                      width: width / 6,
                                                      child: Text(
                                                        "لون الخط",
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                            color: Colors.teal,
                                                            fontFamily: "Cairo"),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    SizedBox(
                                                      width: 35.0,
                                                      height: 35.0,
                                                      child: InkWell(
                                                        child: const DecoratedBox(
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: Color.fromARGB(255, 220, 237, 241),
                                                                  shape: BoxShape.circle),
                                                        ),
                                                        onTap: () {
                                                          setState(() {
                                                            backColor = Color.fromARGB(255, 220, 237, 241);
                                                          });
                                                          ScaffoldMessenger.of(context).hideCurrentSnackBar();

                                                        },
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    SizedBox(
                                                      width: 35.0,
                                                      height: 35.0,
                                                      child: InkWell(
                                                        child: const DecoratedBox(
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: Color.fromARGB(255, 230, 219, 208),
                                                                  shape: BoxShape.circle),
                                                        ),
                                                        onTap: () {
                                                          setState(() {
                                                            backColor = Color.fromARGB(255,230,219, 208);
                                                          });
                                                          ScaffoldMessenger.of(context).hideCurrentSnackBar();

                                                        },
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    SizedBox(
                                                      width: 35.0,
                                                      height: 35.0,
                                                      child: InkWell(
                                                        child: const DecoratedBox(
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: Color.fromARGB(255, 223, 223, 223),
                                                                  shape: BoxShape.circle),
                                                        ),
                                                        onTap: () {
                                                          setState(() {
                                                            backColor = Color.fromARGB(255, 223, 223, 223);
                                                          });
                                                          ScaffoldMessenger.of(context).hideCurrentSnackBar();

                                                        },
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    SizedBox(
                                                      width: 35.0,
                                                      height: 35.0,
                                                      child: InkWell(
                                                        child: DecoratedBox(
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: Color.fromARGB(255, 255, 248, 233),
                                                                  shape: BoxShape.circle),
                                                        ),
                                                        onTap: () {
                                                          setState(() {
                                                            backColor = Color.fromARGB(255, 255, 248, 233);
                                                          });
                                                          ScaffoldMessenger.of(context).hideCurrentSnackBar();

                                                        },
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    SizedBox(
                                                      width: 35.0,
                                                      height: 35.0,
                                                      child: InkWell(
                                                        child: DecoratedBox(
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: Colors.white,
                                                                  shape: BoxShape.circle),
                                                        ),
                                                        onTap: () {
                                                          setState(() {
                                                            backColor = Colors.white;
                                                          });
                                                          ScaffoldMessenger.of(context).hideCurrentSnackBar();

                                                        },
                                                      ),
                                                    ),

                                                    Spacer(),
                                                    Text(
                                                      "لون الخلفيه",
                                                      textAlign: TextAlign.right,
                                                      style: TextStyle(
                                                          color: Colors.teal,
                                                          fontFamily: "Cairo"),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.white,
                                          elevation: 0,
                                        ),
                                  ).closed.then((value) {_isSnackbarActive = false;
                                  });
                                  //Bottom Sheet
                                }
                              },
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 50,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text("صوت القصيدة أبرق بدا نحو المرابع يلمع",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Amiri Regular"),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: 25,
                            width: 350,
                            child: ProgressBar(
                              barHeight: 8,
                              baseBarColor: Colors.grey[600],
                              bufferedBarColor: Colors.grey,
                              progressBarColor: Colors.teal[600],
                              thumbColor: Colors.teal[600],
                              timeLabelTextStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              progress: positionData?.position ?? Duration.zero,
                              buffered:
                                  positionData?.bufferedPosition ?? Duration.zero,
                              total: positionData?.duration ?? Duration.zero,
                              onSeek: _audioPlayer.seek,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 45,
                            width: 45,
                          ),
                          SizedBox(
                            height: 45,
                            width: 45,
                            child: IconButton(
                                onPressed: () {
                                  if(_audioPlayer.position.inSeconds>=0&&_audioPlayer.position.inSeconds<60){
                                    _audioPlayer.seek(Duration(
                                        seconds: _audioPlayer.position.inSeconds - _audioPlayer.position.inSeconds));
                                  }else{
                                    _audioPlayer.seek(Duration(
                                        seconds: _audioPlayer.position.inSeconds - 60));
                                  }
                                },
                                icon:
                                    SvgPicture.asset("assets/img/ic_pspeed.svg")),
                          ),
                          SizedBox(
                            height: 45,
                            width: 45,
                            child: IconButton(
                                onPressed: () {
                                  if(_audioPlayer.position.inSeconds>=0&&_audioPlayer.position.inSeconds<10){
                                    _audioPlayer.seek(Duration(
                                        seconds:
                                        _audioPlayer.position.inSeconds - _audioPlayer.position.inSeconds));
                                  }else{
                                    _audioPlayer.seek(Duration(
                                        seconds:
                                        _audioPlayer.position.inSeconds - 10));
                                  }
                                },
                                icon: SvgPicture.asset("assets/img/ic_p.svg")),
                          ),
                          SizedBox(
                            height: 45,
                            width: 45,
                            child: IconButton(
                                onPressed: () {
                                  if (p == false) {
                                    _audioPlayer.play();
                                    p = true;
                                  } else {
                                    _audioPlayer.pause();
                                    p = false;
                                  }
                                },
                                icon: !p
                                    ? SvgPicture.asset("assets/img/ic_play.svg")
                                    : SvgPicture.asset("assets/img/ic_pause.svg")),
                          ),
                          SizedBox(
                            height: 45,
                            width: 45,
                            child: IconButton(
                                onPressed: () {
                                  if(_audioPlayer.position.inSeconds+10<=_audioPlayer.duration!.inSeconds){
                                    _audioPlayer.seek(Duration(
                                        seconds:
                                        _audioPlayer.position.inSeconds + 10));
                                  }
                                },
                                icon: SvgPicture.asset("assets/img/ic_next.svg")),
                          ),
                          SizedBox(
                            height: 45,
                            width: 45,
                            child: IconButton(
                                onPressed: () {
                                  if(_audioPlayer.position.inSeconds+60<=_audioPlayer.duration!.inSeconds){
                                    _audioPlayer.seek(Duration(
                                        seconds:
                                        _audioPlayer.position.inSeconds + 60));
                                  }
                                },
                                icon:
                                    SvgPicture.asset("assets/img/ic_nspeed.svg")),
                          ),
                          SizedBox(
                            height: 55,
                            width: 55,
                            child: IconButton(
                                onPressed: () {
                                  onSetRepeatMode();
                                },
                                icon:
                                    SvgPicture.asset(
                                        "assets/img/ic_repeat.svg",
                                        color:loobMode?Colors.amber:Colors.white ,
                                    )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  void dispose() {
    super.dispose();
    _audioPlayer.stop();
  }
  void saveNote(String title, String body, String kName, String kasyeda, String kNameT, String kasyedaT) async{
    await  dbNotify.saveDuaa(NoteModel("$title","$body","$kName","$kasyeda","$kNameT","$kasyedaT"));
  }

  void saveFav(String kName, String kasyeda, String kNameT, String kasyedaT) async{
    await  dbFav.saveFav(FavModel("$kName","$kasyeda","$kNameT","$kasyedaT"));
  }
  void deleteFav(FavModel currentNote) async{
    await dbFav.deleteFav(currentNote.id);
    getAllData();
  }



  Future<void> openSelectionDialog(BuildContext context) async {
    List<String>? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('اضف نصوص للمشاركة',style: TextStyle(fontFamily: 'Cairo'),),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  width: double.maxFinite,
                  child: ListView.builder(
                    itemCount: allTexts.length,
                    itemBuilder: (BuildContext context, int index) {
                      String text = allTexts[index];
                      bool isSelected = selectedTexts.contains(text);

                      return ListTile(
                        title: Text(text,style: TextStyle(fontFamily: 'Cairo')),
                        tileColor: isSelected ? Constants.primary : null,
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                                selectedTexts.remove(text);
                            } else {
                              if (selectedTexts.length < 4) {
                                selectedTexts.add(text);
                              } else {
                                displayToastMessage('يمكنك فقط اختيار 4 ابيات للمشاركة');
                              }
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Navigator.of(context).pop(selectedTexts);
                navigateBack(context);

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDialog(
                      kasedaName: widget.KNameT,
                      kaseda: widget.kasyedaTRepeat,
                      allText:selectedTexts
                    );
                  },
                );

                },
              child: Text('تأكيد',style: TextStyle(fontFamily: 'Cairo'),),
            ),
          ],
        );
      },
    );

    if (result != null) {
      // Handle the selected texts, for example, you can use them in your application logic.
      print('Selected Texts: $result');
    }
  }
}

class PositionData {
  const PositionData(
    this.position,
    this.bufferedPosition,
    this.duration,
  );
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
}
