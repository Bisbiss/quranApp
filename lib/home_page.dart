import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quranapp/detail_surah.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final String url = "https://equran.id/api/surat";
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
    var response =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    print(response.body);
    setState(() {
      data = jsonDecode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Al-Quran"),
          backgroundColor: Colors.teal,
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
                          onTap: (() {
                            Get.to(detailSurah(), arguments: [
                              data![index]["nomor"],
                              data![index]["nama_latin"]
                            ]);
                            print(data![index]['nomor']);
                          }),
                          title: Text(data![index]["nama_latin"],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          subtitle: Text(data![index]["arti"]),
                          leading: CircleAvatar(
                            child: Text(
                                data![index]["nomor"]
                                    .toString(), // ambil karakter pertama text
                                style: TextStyle(fontSize: 20)),
                          )),
                    );
                  },
                ),
        ));
  }
}
