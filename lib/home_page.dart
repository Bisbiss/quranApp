import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
          backgroundColor: Colors.white,
          leading: Icon(
            Icons.dashboard,
            color: Colors.teal,
          ),
        ),
        body:
            // Column(
            // children: [
            //   Container(
            //     width: double.infinity,
            //     child: Padding(
            //       padding: EdgeInsets.all(13), //apply padding to all four sides
            //       child: Text("Assalamualaikum...",
            //           style: TextStyle(fontSize: 20, color: Colors.grey)),
            //     ),
            //   ),
            //   Container(
            //     width: double.infinity,
            //     child: Padding(
            //       padding: EdgeInsets.only(
            //           left: 15, bottom: 15), //apply padding to all four sides
            //       child: Text("Bisri Mustofa,",
            //           style: TextStyle(
            //               fontSize: 25,
            //               color: Colors.teal,
            //               fontWeight: FontWeight.bold)),
            //     ),
            //   ),
            RefreshIndicator(
          onRefresh: _getRefreshData,
          child: data == null
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: data == null ? 0 : data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: double.maxFinite,
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print(data![index]["nomor"]);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        data![index]["nama_latin"],
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          backgroundColor: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider()
                        ],
                      ),
                    );
                  }),
        )
        // ],
        // ),
        );
  }
}
