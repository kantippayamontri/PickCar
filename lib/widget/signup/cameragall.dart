import 'package:flutter/material.dart';

class CameraGall extends StatelessWidget {
  MediaQueryData mediaq;
  Function choosecamera;
  Function choosegall;
  CameraGall(this.mediaq, this.choosecamera, this.choosegall);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mediaq.size.height * 0.3,
      width: mediaq.size.width,
      child: Column(
        children: <Widget>[
          InkWell(
            child: Container(
              height: mediaq.size.height * 0.14,
              width: mediaq.size.width,
              child: Center(
                child: Text("camera"),
              ),
            ),
            onTap: (){
              choosecamera();
              Navigator.of(context).pop();
              },
          ),
          Divider()
          ,
          InkWell(
            child: Container(
              height: mediaq.size.height * 0.14,
              width: mediaq.size.width,
              child: Center(
                child: Text("gallery"),
              ),
            ),
            onTap: (){
              choosegall();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
