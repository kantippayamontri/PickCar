import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

Widget imageProfile(Uint8List image) {
  if(image == null){
    return Container();
  }else{
    return Image.memory(image,fit: BoxFit.fill,
    );
  }
}