// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:tpra/components/crud.dart';
import 'package:tpra/constant/linkapi.dart';
import 'package:tpra/main.dart';

class SeeReports extends StatefulWidget {
  const SeeReports({super.key});

  @override
  State<SeeReports> createState() => _SeeReportsState();
}

class _SeeReportsState extends State<SeeReports> {
  Crud crud = Crud();
  @override
  void initState() {
    getMyreports();
    super.initState();
  }

  getMyreports() async {
    var responce = await crud.postRequests(linkshowReport,
        {"user_id": sharedPref.getString("user_id").toString()});
    return responce;
    // print(responce);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      // semanticsLabel: "Loading",
      onRefresh: () {
        setState(() {});
        return Future<void>.delayed(const Duration(seconds: 3));
      },
      child: ListView(
        // shrinkWrap: true,
        padding: EdgeInsets.all(10),
        children: [
          FutureBuilder(
              future: getMyreports(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data['status'] == 'Faild')
                    return Container(
                      margin: EdgeInsets.only(top: 150),
                      child: Center(
                        child: Text(
                          "NO REPORTS YET",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );

                  return ListView.builder(
                    itemCount: snapshot.data['data'].length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      return Card(
                        child: ListTile(
                          subtitle: Text(
                            " Details :" +
                                snapshot.data['data'][i]['report_details'],
                            style: TextStyle(fontSize: 8),
                          ),
                          title: Text(snapshot.data['data'][i]['post_details']),
                          leading: Container(
                            width: 50,
                            height: 50,
                            child: Image.network(
                              '$ImageLinkposts/' +
                                  snapshot.data['data'][i]['post_photo']
                                      .toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                          trailing:
                              snapshot.data['data'][i]['report_action'] == '0'
                                  ? Icon(Icons.pending_outlined)
                                  : Icon(
                                      Icons.done,
                                      color: Colors.green,
                                      size: 30,
                                    ),
                        ),
                      );
                    },
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    // child: Text("Loading ...."),
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
                return Center(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/nopost.png",
                        // height: 100,
                        // width: 100,
                      ),
                      // Text("No Comments Yet"),
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}
