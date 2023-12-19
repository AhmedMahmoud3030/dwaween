import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class about extends StatefulWidget {
  const about({Key? key}) : super(key: key);

  @override
  State<about> createState() => _aboutState();
}

final TextEditingController _searchController = TextEditingController();
int _selectedIndex = 0;
String SearchValue = "";
var filtared;
var items;

Future getData() async {
  var url = 'https://www.turathtijania.com/index.php';
  //var url = 'http://10.0.2.2/test/index.php';
  http.Response response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  return data;
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 250, 250, 234),
          child: Stack(
            children: [
              Stack(
                children: [
                  SvgPicture.asset(
                    "assets/images/paintings/img_head_home.svg",
                    alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width * 4,
                    height: MediaQuery.of(context).size.height / 2,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 210,
                      ),
                      Container(
                        height: 60,
                        color: Color.fromARGB(255, 250, 250, 234),
                        // Add padding around the search bar
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        // Use a Material design search bar
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() {
                              SearchValue = value;
                            });
                          },
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: 'البحث فى الديوان',
                            filled: true, //<-- SEE HERE
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3, color: Colors.white),
                              borderRadius: BorderRadius.circular(20.0),
                            ),

                            // Add a clear button to the search bar
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {},
                            ),
                            // Add a search icon or button to the search bar
                            prefixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () => _searchController.clear(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),

              Column(
                children: [
                  SizedBox(
                    height: 280,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: Image.asset("assets/img/cheikh.jpg"),
                      ),
                      Container(
                        width: 240,
                        child: RichText(
                          text: TextSpan(
                            text:
                                "باختصار:كان نورا ساطعا وسيفا قاطعا وأعجوبة زمانه، ويومه له ما بعده، غرس الإيمان في القلوب وسقاهم بمحبة قائد الأمة ومؤسسها صلى عليه وسلم حتى تجمعت القلوب حوله، وأحاطته بمشاعر الحب والتقدير، فكان مُجَلي الصدق وعين إبراز الحق، فتراهم يرقبون ظهوره وتفيض أعينهم دمعا مما عرفوا فيه من الحق، يتسابقون لخدمته والتقرب إليه والقرب منه والحظوة لديه، يجمعهم بإطراقه وينير بواطنهم بإشراقه،.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                                fontSize: 20,
                                fontFamily: "Amiri Regular"),
                          ),
                          maxLines: 10,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 385,
                        child: RichText(
                          text: TextSpan(
                            text:
                                " فطُبِعَت فيهم محبة ذاته، فإنه الشيخ حقا بجميع مراتبه، شيخ الإسلام الشيخ إبراهيم نياس",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                                fontSize: 20,
                                fontFamily: "Amiri Regular"),
                          ),
                          maxLines: 10,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 385,
                        height: 40,
                        child: RichText(
                          text: TextSpan(
                            text: " ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          ),
                          maxLines: 10,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 385,
                        child: RichText(
                          text: TextSpan(
                            text: " :حياته",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                                fontSize: 20,
                                fontFamily: "Amiri Regular"),
                          ),
                          maxLines: 10,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 385,
                        child: RichText(
                          text: TextSpan(
                            text:
                                " كان مولد هذا المجدد الغطمطم والمفرد الأعظم، يوم الخميس 15 رجب من عام 1318 من هجرته صلى الله عليه وسلم، الموافق: 08 نوفمبر 1900م، بالقرية المعروفة بطيبة من إقليم نياسين سين سالم شرقي الجمهورية السنغالية، من أب هو الحاج عبد الله نياس مرجعية هذا الإقليم الدينية والعلمية، جاهد الفرنسيين،  بينما كانت عائشة بنت السيد إبراهيم هي المحظية بحمل واحتضان وتنشئة هذا العلم الفذ الشيخ إبراهيم نياس ، مع العلم أن الأمير الرضى العربي من ذرية عقبة بن نافع الفهري القرشي هو أول أجداده توطنا بالسنغال.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                                fontSize: 20,
                                fontFamily: "Amiri Regular"),
                          ),
                          maxLines: 10,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 385,
                        height: 40,
                        child: RichText(
                          text: TextSpan(
                            text: " ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          ),
                          maxLines: 10,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 385,
                        child: RichText(
                          text: TextSpan(
                            text: " :نشأته",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                                fontSize: 20,
                                fontFamily: "Amiri Regular"),
                          ),
                          maxLines: 10,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 385,
                        child: RichText(
                          text: TextSpan(
                            text:
                                " نشأ الشيخ إبراهيم نياس محفوفا في كنه تربية علمية بحتة فريدة من نوعها، حيث كانت تنشئته دباغها القرآن العظيم وعلوم الآلة والفقه وشتى الفنون العربية الإسلامية التي كانت محظرة والده العلم المجاهد الحاج عبد الله نياس مهدا لإشعاعها في تيلك الأقاليم، بحيث كانت هذه الأسرة أسرة متعلمة ومن نوع أكاديمي.وقد خص الله هذا الشيخ من بين محيطه الذي يزخر بالنجباء، بخصوصية الشمس على الكواكب، حيث سمت به مواهب النبوغ الخارق للعوائد وأشرقت بطلعته منذ نعومة أظافره حتى ظهرت شمس تفرده وتميزه العلمي والدعوي والديني سريعا على المعمورة.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                                fontSize: 20,
                                fontFamily: "Amiri Regular"),
                          ),
                          maxLines: 10,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 385,
                        height: 40,
                        child: RichText(
                          text: TextSpan(
                            text: " ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          ),
                          maxLines: 10,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 385,
                        child: RichText(
                          text: TextSpan(
                            text: " :مكانته العلمية",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                                fontSize: 20,
                                fontFamily: "Amiri Regular"),
                          ),
                          maxLines: 10,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 385,
                        child: RichText(
                          text: TextSpan(
                            text:
                                " لم يمر الشيخ ببلد عبر رحلاته التي جاب فيها كوكبنا الأرضي من أقاصيه إلى دانيه، إلا وخلًّف فيه ذكرا ووسما وتأثيرا، فبعد أن التفَّت جموع إفريقية كثيرة عبر مختلف أقاليمها وبلدانها ودخول عشرات الملايين من الوثنيين والمشركين الإسلام على يديه، لم يقتصر نور هذا الشيخ وهديه وأثره في القلوب على القارة السمراء فقط، بل تجاوزها إلى قارات أخرى نسج فيها علاقات روحية وصلات أخوية إسلامية متميزة ألصقت به لقب بشيخ الإسلام.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                                fontSize: 20,
                                fontFamily: "Amiri Regular"),
                          ),
                          maxLines: 10,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 385,
                        child: RichText(
                          text: TextSpan(
                            text: " وقد تجلى تميز هذه الشخصية الفذة الفريدة في قرنها، في إذعان علماء العالم الإسلامي له وتقديمهم إياه وتعظيمه، بدءا بالجامع الأزهر الذي تم تشريفه بإمامة الجمعة به، وهو أول إفريقي يؤم صلاة الجمعة بالأزهر، وكان ذلك بتاريخ صفر من عام 1381هـ (21/7/1961م). وقد أكد مشايخ الأزهر أمثال الدكتور عبد الحليم محمود والشيخ شلتوت وهما رئيسان سابقان للأزهر وغيرهم كحافظ دهره الشيخ محمد الحافظ المصري على ذلك وصرحوا بمكانة الشيخ العملية، فقد قال الشيخ شلتوت " +
                                "إننا مطمئنون على مستقبل العالم الإسلامي ما دام في المسلمين أمثال ضيفنا العظيم شيخ الإسلام إبراهيم نياس" +
                                "، ثم لقبوه بشيخ الإسلام..",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                                fontSize: 20,
                                fontFamily: "Amiri Regular"),
                          ),
                          maxLines: 10,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 385,
                        child: RichText(
                          text: TextSpan(
                            text:
                                "مع أن الشيخ كان قدوة ودليلا وناصحا لكثير من رؤساء العالم الإسلامي وملوكه وكانت تربطه بهم صلات مناصحة قوية وودية أمثال الرئيس جمال عبد الناصر الذي نصحه برسالة مشهورة في قضية السيد قطب وزملائه، والسلطان زايد آل نهيان، والملك محمد الخامس والحسن الثاني وغيرهم...",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                                fontSize: 20,
                                fontFamily: "Amiri Regular"),
                          ),
                          maxLines: 10,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 385,
                        child: RichText(
                          text: TextSpan(
                            text: " وكان مجهود الشيخ إبراهيم نياس في التأليف مجهودا يرقى إلى مرتبة التجديد حقا، فقد أبطل أوهام جلامدة الفقهاء المتعصبين للفروع وأحيا السنة عبر مؤلفات معروفة منها " +
                                "، والحجة البالغة في كون إذاعة القرآن بالراديو سائغة، والصارم الأحمدي، و سبل السلام في إبقاء المقام ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                                fontSize: 20,
                                fontFamily: "Amiri Regular"),
                          ),
                          maxLines: 10,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 385,
                        child: RichText(
                          text: TextSpan(
                            text: " ثم إن الشيخ جدد التصوف، ويتجلى ذلك في تأليفه كاشف الإلباس الذي يعتبر بحق زبدة لكلام الصوفية القدماء والمتأخرين حيث ثمن آراءهم واستنطق مكنون أحوالهم ومواجيدهم ودل على عمق وغور في الحقيقة فاتهم، وليس تأليفه السر الأكبر والكبريت الأحمر إلا مظهرا من مظاهر الخصوصية المحمدية العظمى، لما كان مُجَلى فيضة الحقائق الربانية، وضع لها قانونا ودستورا يُعَرف بأحوالها ومعمعان تجلياتها وحقائقها وخصائصها وسلوك صراطها المستقيم حتى الإياب الكريم والاستقامة المُشرفة عن علم ودراية لا عن جهل وتقليد وعِمَاية..." +
                                "، ولقد ألف الشيخ إبراهيم نياس كذلك في جميع الفنون العلمية، ورد على الكنيسة، من ذلك رده على الأفيغر رئيس كنيسة إفريقيا، وعنوانه: إفريقيا للإفريقيين، ثم إن للشيخ رأيه المستنير البارز في كبريات أحداث زمنه كقضية فلسطين، ومسألة غزو الفضاء التي ألف فيها رسالته المسماة الإيمان بالقضاء في مسألة غزو الفضاء، إلى جانب كثير من الفتاوى النيرة المصيبة، ودواوين شعرية كثيرة في مدح سيد الأولين والآخرين طالت أكثر من ستة آلاف (6.000) بيت، كما ترك خطبا في كل المناسبات الدينية كانت جمعا لشتات القلوب وهداية للشاردين والضالين من أبناء المسلمين وسيفا قاطعا على أعداء دين محمد صلى الله عليه وسلم، ونبراسا يُهتدى به في محبة الله ورسوله، مع مجاميع من رسائل تتناول جميع الأغراض الدينية والشرعية والصوفية، إلخ.. مع أن الشيخ أولى تفسير القرآن الكريم عناية خاصة حيث فسره عدة مرات بالعربية الفصحى وباللغة السنغالية المحلية لغير العرب(الولوفية)، قام تلامذته بتسجيله من صوته مباشرة، وجمعه خليفة الشيخ عبد الله الشيخ محمد بن الشيخ عبد الله في مجلدات محققة ومطبوعة، تحت عنوان  في رياض التفسير.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                                fontSize: 20,
                                fontFamily: "Amiri Regular"),
                          ),
                          maxLines: 50,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                ],
              )
              // CardsListview(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget bar() {
  return Column(
    children: <Widget>[
      const Center(
        child: Text(
          "Home",
          style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 246, 246, 147)),
        ),
      ),
      Positioned(
        // To take AppBar Size only
        child: Container(
          color: Colors.white,
          // Add padding around the search bar
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          // Use a Material design search bar
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
              // Add a clear button to the search bar
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => _searchController.clear(),
              ),
              // Add a search icon or button to the search bar
              prefixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // Perform the search here
                },
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.white)),
            ),
          ),
        ),
      )
    ],
  );
}
