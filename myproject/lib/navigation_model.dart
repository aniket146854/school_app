import 'package:flutter/material.dart';

class NavigationModel {
  String title;
  IconData icon;

  NavigationModel({this.title, this.icon});
}

List<NavigationModel> navigationItems = [
  NavigationModel(title: "Home", icon: Icons.home),
  NavigationModel(title: "About school", icon: Icons.school),
  NavigationModel(title: "Events", icon:Icons.event),
  NavigationModel(title: "Log out", icon: Icons.exit_to_app),
];