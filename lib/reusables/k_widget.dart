import 'package:cached_network_image/cached_network_image.dart';
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

Widget displayImage(String image, double height, double width){
  return CachedNetworkImage(
    imageUrl: image,
    height: height,
    width: width,
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
  );
}

showErrorDialog(BuildContext context, String errorMessage) {

  // set up the button
  Widget okButton =  Padding(
    padding: const EdgeInsets.only(left: 70, right: 70,),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      width: 250,
      child: TextButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueAccent)),
        child: const Text(
          "Ok",
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ),
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    contentPadding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
    title: const Text(
      "Alert" ,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    ),

    content: Text(errorMessage, textAlign: TextAlign.center, style:  const TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: Colors.black),),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}