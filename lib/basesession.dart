import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SessionManager {

  static Future<String> getPartnerId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String authpartnerid = prefs.getString('partnerId') ?? "";
    return authpartnerid;
  }

  static Future<String> getPartnerCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String authpartnercode = prefs.getString('partnerCode') ?? "";
    return authpartnercode;
  }

  static Future<String> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String authname = prefs.getString('name') ?? "";
    return authname;
  }

  static Future<String> getDescription() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String authdesc = prefs.getString('description') ?? "";
    return authdesc;
  }
}