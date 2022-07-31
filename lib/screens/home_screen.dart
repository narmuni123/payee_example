import 'dart:convert';

import 'package:altor_assignment/model/about_model.dart';
import 'package:altor_assignment/services/rest_api.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  AboutModel? aboutModel;

  final ScrollController _scrollController = ScrollController();

  List itemList = [];

  bool hasMore = true;

  bool isLoading = false;

  RestApi restApi = RestApi();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<dynamic> getData() async{
    if(isLoading) return ;
    isLoading = true;

    final response = await restApi.getData();

    if(response.statusCode == 200){
      final newItems = json.decode(response.body);
      setState(() {
        isLoading = false;
        aboutModel = AboutModel.fromJson(newItems);
        itemList = aboutModel!.rows;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(),
    );
  }
}
