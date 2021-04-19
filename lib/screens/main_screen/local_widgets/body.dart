import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:spacex_latest_launch/models/launch_model.dart';
import 'package:spacex_latest_launch/utils/style_utils.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<Launch> fetchLatestLaunch() async {
    final response = await http
        .get(Uri.parse("https://api.spacexdata.com/v4/launches/latest"));

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return Launch.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: FutureBuilder<Launch>(
              future: fetchLatestLaunch(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      dividerContent(),
                      CachedNetworkImage(
                        imageUrl: snapshot.data.links.patch.small,
                        placeholder: (context, url) => Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, err) => Container(
                          child: Center(
                            child: Icon(Icons.error_outline_rounded),
                          ),
                        ),
                        fadeInCurve: Curves.easeIn,
                        fadeInDuration: Duration(milliseconds: 1000),
                        fit: BoxFit.none,
                      ),
                      dividerContent(),
                      Text(
                        "Latest Lauch Name",
                        style: headerTextStyle,
                      ),
                      Text(
                        "${snapshot.data.name}",
                        style: elementTextStyle,
                      ),
                      dividerContent(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "${snapshot.data.details}",
                          style: multiLineElementTextStyle,
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget dividerContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Divider(
        color: Colors.purple,
        thickness: 2,
      ),
    );
  }
}
