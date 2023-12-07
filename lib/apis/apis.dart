import 'dart:convert';
import 'dart:developer';

import 'package:csv/csv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../helpers/my_dialog.dart';
import '../helpers/pref.dart';
import '../models/ip_details.dart';
import '../models/vpn.dart';



// my domain Url
String serverUrl = 'http://192.168.143.108:3000';
// String serverUrl = 'https://nodeapi-eta.vercel.app';


class APIs {
  static Future<List<Vpn>> getVPNServers() async {
    final List<Vpn> vpnList = [];
      final url = Uri.parse(serverUrl + '/proxy');
      final res  = await http.get(url);
      final csvString = res.body.split("#")[1].replaceAll('*', '');

      List<List<dynamic>> list = const CsvToListConverter().convert(csvString);
      // var list = jsonDecode(res.body);

      final header = list[0];

      for (int i = 1; i < list.length - 1; ++i) {
        Map<String, dynamic> tempJson = {};

        for (int j = 0; j < header.length; ++j) {
          
          tempJson.addAll({header[j].toString(): list[i][j]});
        }
        vpnList.add(Vpn.fromJson(tempJson));
      }
    
    // try {
    //   final res = await http.get(Uri.parse('http://www.vpngate.net/api/iphone/'));
      
    //   final csvString = res.body.split("#")[1].replaceAll('*', '');

    //   List<List<dynamic>> list = const CsvToListConverter().convert(csvString);

    //   final header = list[0];

    //   for (int i = 1; i < list.length - 1; ++i) {
    //     Map<String, dynamic> tempJson = {};

    //     for (int j = 0; j < header.length; ++j) {
    //       tempJson.addAll({header[j].toString(): list[i][j]});
    //     }
    //     vpnList.add(Vpn.fromJson(tempJson));
    //   }
    // } catch (e) {
    //   MyDialogs.error(msg: e.toString());
    //   log('\ngetVPNServersE: $e');
    // }
    vpnList.shuffle();

    if (vpnList.isNotEmpty) Pref.vpnList = vpnList;

    return vpnList;
  }

  static Future<void> getIPDetails({required Rx<IPDetails> ipData}) async {
    try {
      final res = await http.get(Uri.parse('http://ip-api.com/json/'));
      final data = jsonDecode(res.body);
      log(data.toString());
      ipData.value = IPDetails.fromJson(data);
    } catch (e) {
      MyDialogs.error(msg: e.toString());
      log('\ngetIPDetailsE: $e');
    }
  }
  static Future<bool> loginUser(String passStr) async {
    // var userPass = passController.text;
    var url = Uri.parse(serverUrl + '/client/login');
    var bodyData = {
      'email' : 'hogarden1135j@gmail.com',
      'password' : '111'
    };
    log(json.encode(bodyData));
    var res = await http.post(url, body: json.encode(bodyData));
    var decodeRes = jsonDecode(utf8.decode(res.bodyBytes));
    return decodeRes;
  }
}

