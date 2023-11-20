import 'dart:io';
import 'package:dog_breed_app/ui/shared/uicolor.dart';
import 'package:dog_breed_app/ui/shared/uipath.dart';
import 'package:dog_breed_app/ui/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

List<Map> settings = [
  {
    "icon": UIPath.helpIcon,
    "text": "Help",
    "type": "link",
    "url": "www.dogbreedapp.com/help"
  },
  {
    "icon": UIPath.rateIcon,
    "text": "Rate Us",
    "type": "link",
    "url": "https://play.google.com/store/apps/dog-breed-app"
  },
  {
    "icon": UIPath.shareIcon,
    "text": "Share with Friends",
    "type": "share",
    "url": ""
  },
  {
    "icon": UIPath.termsIcon,
    "text": "Terms of Use",
    "type": "link",
    "url": "www.dogbreedapp.com/terms-of-use"
  },
  {
    "icon": UIPath.privacyIcon,
    "text": "Privacy Policy",
    "type": "link",
    "url": "www.dogbreedapp.com/privacy-policy"
  },
  {
    "icon": UIPath.versionIcon,
    "text": "OS Version",
    "type": "version",
    "url": ""
  },
];

expandableSettingsBottomSheet(context) {
  showModalBottomSheet(
    backgroundColor: UIColor.systemGray6,
    useSafeArea: true,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Column(
        children: [
          SizedBox(height: 8),
          Container(
            width: 32,
            height: 3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: UIColor.systemGray5),
          ),
          SizedBox(height: 48),
          ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: settings.length,
              itemBuilder: (BuildContext context, int index) {
                return settingsPageItems(index);
              }),
        ],
      );
    },
  );
}

settingsPageItems(int index) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            SvgPicture.asset(
              settings[index]["icon"],
              width: 32,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 8),
            TextBasic(
              text: settings[index]["text"],
              fontSize: 16,
              color: UIColor.black,
              letterSpacing: 2,
            ),
            Spacer(),
            settings[index]["type"] != "version"
                ? SvgPicture.asset(UIPath.goArrowIcon)
                : TextBasic(
                    text: getOsVersion(),
                    color: UIColor.secondartColor.withOpacity(.6),
                    fontSize: 13,
                  )
          ],
        ),
      ),
      index == settings.length - 1
          ? SizedBox()
          : Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Divider(
                color: UIColor.systemGray5,
                height: 0,
                thickness: 2,
              ),
            )
    ],
  );
}

String getOsVersion() {
  if (Platform.isAndroid) {
    String versionNumber = Platform.version.split(' ').first;
    return 'Android ${versionNumber}';
  } else if (Platform.isIOS) {
    // get only version number
    String versionNumber = Platform.operatingSystemVersion.split('(').first;
    return 'iOS ${versionNumber}';
  } else {
    return '-';
  }
}
