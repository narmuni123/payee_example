import 'package:flutter/material.dart';

Widget kLoadingWidget(){
  return const Scaffold(
    body: Center(
      child: CircularProgressIndicator(),
    ),);
}

Widget kErrorWidget(){
  return const Scaffold(
      body: Center(
        child: Text("Try again later"),
      ));
}