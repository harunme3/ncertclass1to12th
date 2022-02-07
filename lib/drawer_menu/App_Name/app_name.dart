import 'package:flutter_svg/flutter_svg.dart';
import 'package:ncertclass1to12th/config/appcolor.dart';
import 'package:ncertclass1to12th/theme/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Provider.of<ThemeProvider>(context).isDarkTheme;
    return Row(
      children: [
        CircleAvatar(
          child: SvgPicture.asset('assets/header/drawerheader.svg'),
          backgroundColor: isDarkTheme ? Colors.black : AppColor.first_color,
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('app_name1',
                    style: Theme.of(context).primaryTextTheme.bodyText1)
                .tr(),
            Text('app_name2',
                    style: Theme.of(context).primaryTextTheme.bodyText1)
                .tr(),
            Text('class', style: Theme.of(context).primaryTextTheme.bodyText1)
                .tr()
          ],
        )
      ],
    );
  }
}
