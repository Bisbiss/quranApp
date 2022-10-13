import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class detailSurah extends StatefulWidget {
  const detailSurah({super.key});

  @override
  State<detailSurah> createState() => _detailSurahState();
}

class _detailSurahState extends State<detailSurah> {
  String? api = "https://equran.id/api/surat/";
  int? nomor = Get.arguments[0];
  List? data;
  @override
  void initState() {
    _getRefreshData();
    super.initState();
  }

  Future<void> _getRefreshData() async {
    this.getJsonData(context);
  }

  Future<void> getJsonData(BuildContext context) async {
    var response = await http.get(Uri.parse(api! + nomor.toString()),
        headers: {"Accept": "application/json"});
    print(response.body);
    setState(() {
      var full = jsonDecode(response.body);
      data = full['ayat'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Get.arguments[1]),
        ),
        body: RefreshIndicator(
            onRefresh: _getRefreshData,
            child: data == null
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: data == null ? 0 : data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          child: ListTile(
                        title: Text(data![index]["ar"],
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        subtitle: Text(data![index]["idn"]),
                        leading: CircleAvatar(
                          child: Text(
                              data![index]["nomor"]
                                  .toString(), // ambil karakter pertama text
                              style: TextStyle(fontSize: 20)),
                        ),
                      ));
                    })));
  }
}
