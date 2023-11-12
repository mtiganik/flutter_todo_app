// import 'package:intl/intl.dart';

  String previousTimeToString(String? date) {
    if(date == null) {return "";}
    DateTime inputDate = DateTime.parse(date);
    DateTime now = DateTime.now();

    if (now.year == inputDate.year &&
        now.month == inputDate.month &&
        now.day == inputDate.day) {
      return "Today";
    } else if (now.year == inputDate.year &&
        now.month == inputDate.month &&
        now.day == inputDate.day + 1) {
      return "Yesterday";
    } else {
      Duration difference = now.difference(inputDate);
      if (difference.inDays == 1) {
        return "2 days ago";
      } else if (difference.inDays == 2) {
        return "3 days ago";
      } else if (difference.inDays == 3) {
        return "4 days ago";
      } else if (difference.inDays <= 7) {
        return "about a week ago";
      } else if (difference.inDays <= 14) {
        return "about 2 weeks ago";
      } else if (difference.inDays <= 21) {
        return "about 3 weeks ago";
      } else if (difference.inDays <= 30) {
        return "about a month ago";
      } else if (difference.inDays <= 60) {
        return "about 2 months ago";
      } else if (difference.inDays <= 90) {
        return "about 3 months ago";
      } else {
        return "long time ago";
      }
    }
  }

  String futureTimeToString(String? date) {
    if(date == null) return "";
    DateTime inputDate = DateTime.parse(date);
    DateTime now = DateTime.now();

    if (now.isAfter(inputDate)) {
      return previousTimeToString(date);
    } else {
      Duration difference = inputDate.difference(now);
      if (difference.inDays == 0) {
        return "Today";
      } else if (difference.inDays == 1) {
        return "Tomorrow";
      } else if (difference.inDays == 2) {
        return "in 2 days";
      } else if (difference.inDays == 3) {
        return "in 3 days";
      } else if (difference.inDays == 4) {
        return "in 4 days";
      } else if (difference.inDays <= 7) {
        return "in about 1 week";
      } else if (difference.inDays <= 14) {
        return "in about 2 weeks";
      } else if (difference.inDays <= 21) {
        return "in about 3 weeks";
      } else {
        return "in about a month";
      }
    }
  }
