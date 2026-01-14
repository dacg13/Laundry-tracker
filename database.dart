import 'package:flutter/material.dart';

class LaundryDatabase {
  static final LaundryDatabase _instance = LaundryDatabase._internal();
  factory LaundryDatabase() => _instance;
  LaundryDatabase._internal();

  // Active "Ready" Tags
  List<String> readyTags = ["101", "555", "888"];

  // History Data
  List<Map<String, dynamic>> history = [
    {
      "tag": "101",
      "date": "Today, 10:30 AM",
      "status": "Ready",
      "color": Colors.green
    },
    {
      "tag": "099",
      "date": "Yesterday",
      "status": "Collected",
      "color": Colors.grey
    },
    {
      "tag": "045",
      "date": "Oct 24",
      "status": "Collected",
      "color": Colors.grey
    },
  ];

  void markAsReady(String tag) {
    if (!readyTags.contains(tag)) {
      readyTags.insert(0, tag); // Add to top
      history.insert(0, {
        "tag": tag,
        "date": "Just Now",
        "status": "Ready",
        "color": Colors.green
      });
    }
  }

  void markAsCollected(String tag) {
    if (readyTags.contains(tag)) {
      readyTags.remove(tag);
      for (var item in history) {
        if (item["tag"] == tag && item["status"] == "Ready") {
          item["status"] = "Collected";
          item["color"] = Colors.grey;
          break;
        }
      }
    }
  }

  bool isReady(String tag) => readyTags.contains(tag);
}
