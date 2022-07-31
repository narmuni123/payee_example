import 'dart:convert';

import 'package:altor_assignment/model/about_model.dart';
import 'package:altor_assignment/reusables/k_widget.dart';
import 'package:altor_assignment/services/rest_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AboutModel? aboutModel;

  final ScrollController _scrollController = ScrollController();

  late Future getAboutDataFuture;

  List<Rows> itemList = [];


  bool isLoading = false;

  RestApi restApi = RestApi();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<dynamic> getData() async {
    final response = await restApi.getData();

    if (response.statusCode == 200) {
      final newItems = json.decode(response.body);
      setState(() {
        aboutModel = AboutModel.fromJson(newItems);
        itemList = aboutModel!.rows;
      });
    }
  }

  Future refresh() async{
    setState(() {
      isLoading = false;
      itemList.clear();
    });
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (isLoading == false) {
      getAboutDataFuture = getData();
      isLoading = true;
      setState(() {});
    }
    return FutureBuilder(
      future: getAboutDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return kLoadingWidget();
        }
        if (snapshot.hasError) {
          return kErrorWidget();
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(aboutModel!.title),
              centerTitle: true,
            ),
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: refresh,
                child: ListView.separated(
                  itemCount: itemList.length,
                  separatorBuilder: (_, int idx) {
                    return const Divider(thickness: 2,);
                  },
                  shrinkWrap: true,
                  itemBuilder: (_, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: itemList[index].imageHref,
                            height: size.height * 0.2,
                            width: size.width * 0.2,
                            imageBuilder: (context, imageProvider) =>
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                            errorWidget: (context, url, error) =>
                            const Center(
                              child:  Icon(
                                Icons.person_outline,
                              ),
                            ),
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(itemList[index].title),
                            Text(itemList[index].description),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
