import 'package:dwaween/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class share extends StatelessWidget {
  const share({super.key});

  final String _content =
      'جل فكري في معالي أعني على التهيام وا لبُرَحَاءِ بحب الإمام الهاشميِّ أتقربُ تذكرت والأشواق والذكرات';

  void _shareContent() {
    Share.share(_content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 3.5,
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 6,
              child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 7,
                      margin: EdgeInsets.all(10),
                      child: Center(
                        child: Image.asset("assets/img/share-img$index.jpg"),
                      ),
                      color: Colors.white)),
            ),
            Text(
              _content,
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
