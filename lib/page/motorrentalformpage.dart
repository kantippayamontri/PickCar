import 'package:flutter/material.dart';
import 'package:pickcar/bloc/motorrentalform/motorrantalformbloc.dart';
import 'package:pickcar/models/motorcycle.dart';

import '../datamanager.dart';

class MotorRentalFormPage extends StatefulWidget {
  Motorcycle motorcycle;
  MotorRentalFormPage({@required this.motorcycle});
  @override
  _MotorRentalFormPageState createState() => _MotorRentalFormPageState();
}

class _MotorRentalFormPageState extends State<MotorRentalFormPage> {
  MotorRentalFormBloc _motorRentalFormBloc;

  @override
  void initState() {
    _motorRentalFormBloc = MotorRentalFormBloc(
        context: this.context, motorcycle: widget.motorcycle);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: LayoutBuilder(
            builder: (ctx, constraint) {
              return Form(
                key: _motorRentalFormBloc.formkey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: constraint.maxHeight * 0.05,
                    ),
                    //todo price
                    _container(
                        constraint.maxHeight * 0.2, constraint.maxWidth * 0.9, [
                      Text(
                        UseString.price,
                        style: _textstyle(),
                      ),
                      Text(
                        UseString.minimumprice +
                            " " +
                            CarPrice.motorminprice.toString() +
                            UseString.baht,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      TextFormField(
                        controller: _motorRentalFormBloc.pricecontroller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: UseString.price,
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 12)),
                      ),
                    ]),
                    SizedBox(
                      height: 20,
                    ),
                    _container(
                        constraint.maxHeight * 0.2, constraint.maxWidth * 0.9, [
                      Text(
                        UseString.choosedate,
                        style: _textstyle(),
                      ),
                    ])
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _container(double height, double width, List<Widget> wg) {
    return Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 15.0),
                  blurRadius: 15.0),
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, -10.0),
                  blurRadius: 10.0),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[...wg],
        ));
  }

  TextStyle _textstyle() {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: 'Pridi-Bold',
      color: PickCarColor.colormain,
    );
  }
}
