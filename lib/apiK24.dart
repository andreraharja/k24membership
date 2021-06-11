import 'package:flutter_k24_membership/modellogin.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<AccessK24?> getAccessK24({required Map body}) async {
  var url = 'https://api-membership.k24.co.id:3121/member/login/loginbeta';
  try {
    http.Response response = await http.post(Uri.parse(url), body: body);
    final int statusCode = response.statusCode;
    final jsonData = json.decode(response.body);
    if (statusCode == 200) {
      return AccessK24.fromJson(jsonData['user']);
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<List<MembershipK24>> getMembershipK24({required Map body}) async {
  var url = 'https://api-membership.k24.co.id:3121/member/list';
  http.Response response = await http.post(Uri.parse(url), body: body);
  final jsonData = json.decode(response.body);
  List<MembershipK24> listMember = [];
  jsonData['members']
      .map((i) => listMember.add(MembershipK24.fromJson(i)))
      .toList();
  return listMember;
}
