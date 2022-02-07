import 'package:ncertclass1to12th/notificationlist/pushmessage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NotificationMenu extends StatelessWidget {
  const NotificationMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          Icon(
            Icons.notifications_active_outlined,
          ),
          SizedBox(
            width: 10,
          ),
          Text('Notification',
                  style: Theme.of(context).primaryTextTheme.bodyText1)
              .tr()
        ],
      ),
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PushMessagePage(),
          ),
        )
      },
    );
  }
}
