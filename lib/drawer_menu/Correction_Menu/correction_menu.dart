import 'package:ncertclass1to12th/Correction_Form/correction_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CorrectionMenu extends StatelessWidget {
  const CorrectionMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          Icon(
            Icons.mail_outline_outlined,
          ),
          SizedBox(
            width: 10,
          ),
          Text('Correction ',
                  style: Theme.of(context).primaryTextTheme.bodyText1)
              .tr()
        ],
      ),
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CorrectionForm(),
          ),
        )
      },
    );
  }
}
