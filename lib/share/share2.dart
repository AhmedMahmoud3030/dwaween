import 'package:dwaween/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class share2 extends StatelessWidget {
  share2({super.key, required this.kasyeda});
  String kasyeda;
  //final String _content =
  //  'جل فكري في معالي أعني على التهيام وا لبُرَحَاءِ بحب الإمام الهاشميِّ أتقربُ تذكرت والأشواق والذكرات';

  void _shareContent() {
    Share.share(kasyeda);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 3.5,
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 6,
                child: ListView.builder(
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height / 7,
                        margin: EdgeInsets.all(2),
                        child: Center(
                          child: Image.asset("assets/img/share-img$index.jpg"),
                        ),
                        color: Colors.white)),
              ),
            ),
            Text(
              kasyeda,
              style: TextStyle(color: Constants.primary, fontFamily: "Cairo"),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
                onPressed: _shareContent,
                icon: const Icon(Icons.share),
                label: const Text('شارك الاصدقاء'))
          ]),
        ),
      ),
    );
  }
}
