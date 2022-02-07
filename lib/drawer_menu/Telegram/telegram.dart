import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TelegramJoin extends StatelessWidget {
  final String url = 'https://t.me/class12vs';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          Icon(
            Icons.send_sharp,
          ),
          SizedBox(
            width: 10,
          ),
          Text('Join Telegram',
              style: Theme.of(context).primaryTextTheme.bodyText1),
          SizedBox(
            width: 5,
          ),

//Uncomment on when adbmob is implemented

          Container(
            padding: EdgeInsets.only(left: 4.0, right: 4.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          print('not launch');
        }
      },
    );
  }
}
