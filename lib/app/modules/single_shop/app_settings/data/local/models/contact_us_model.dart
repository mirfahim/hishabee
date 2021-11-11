import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactUsInfo {
  String name;
  String iconPath;
  Color color;
  String data;
  Icon icon;
  ContactUsInfo({
    this.name,
    this.iconPath,
    this.color,
    this.data,
    this.icon,
  });
}

List<ContactUsInfo> contactUsInfoData = [
  ContactUsInfo(
    data: "https://www.facebook.com/HishaBee",
    icon: Icon(
      FontAwesomeIcons.facebook,
      color: Colors.white,
    ),
    name: "Follow us on Facebook",
    color: Colors.blue[900],
  ),
  ContactUsInfo(
    data: "https://www.instagram.com/hishabee/",
    icon: Icon(
      FontAwesomeIcons.instagram,
      color: Colors.white,
    ),
    name: "Follow us on Instagram",
    color: Colors.redAccent,
  ),
  ContactUsInfo(
    data: "https://www.youtube.com/channel/UCrFh9vK3wfo0kLwxlrEJYHQ",
    icon: Icon(
      FontAwesomeIcons.youtube,
      color: Colors.white,
    ),
    name: "Subscribe to our Youtube",
    color: Colors.red[900],
  ),
  ContactUsInfo(
    data: "mailto:support@hishabee.xyz",
    icon: Icon(
      FontAwesomeIcons.envelopeOpenText,
      color: Colors.white,
    ),
    name: "Send us an Email",
    color: Colors.purple[900],
  ),
];
