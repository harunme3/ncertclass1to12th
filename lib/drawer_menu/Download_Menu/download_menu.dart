import 'package:ncertclass1to12th/downloadedBook/downloadedbook.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class DownloadMenu extends StatelessWidget {
  const DownloadMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          Icon(
            Icons.download_done_outlined,
          ),
          SizedBox(
            width: 10,
          ),
          Text('downloded_book',
                  style: Theme.of(context).primaryTextTheme.bodyText1)
              .tr()
        ],
      ),
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DownloadedBook(),
          ),
        )
      },
    );
  }
}
