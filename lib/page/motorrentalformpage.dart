import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pickcar/bloc/motorrentalform/motorrantalformbloc.dart';
import 'package:pickcar/bloc/motorrentalform/motorrentalformevent.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:transparent_image/transparent_image.dart';

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

  void setstate() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: LayoutBuilder(
          builder: (ctx, constraint) {
            return SingleChildScrollView(
              child: Form(
                key: _motorRentalFormBloc.formkey,
                child: Column(
                  children: <Widget>[
                    //todo profile
                    SizedBox(
                      height: 20,
                    ),

                    _container(
                        constraint.maxHeight * 0.35, constraint.maxWidth * 0.9, [
                      Text(
                        UseString.profile,
                        style: _textstyle(),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          height: constraint.maxHeight * 0.2,
                          width: constraint.maxWidth * 0.8,
                          child: Stack(
                            children: <Widget>[
                              Center(child: CircularProgressIndicator()),
                              Center(
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: _motorRentalFormBloc
                                      .motorcycle.motorprofilelink,
                                  fit: BoxFit.fill,
                                ),
                              )
                            ],
                          )),
                      // Stack(children: <Widget>[
                      //   Center(child: CircularProgressIndicator()),
                      //   Center(
                      //     child: FadeInImage.memoryNetwork(
                      //         placeholder: kTransparentImage,
                      //         image: _motorRentalFormBloc.motorcycle.motorprofilelink,
                      //         fit: BoxFit.fill,
                      //       ),
                      //   )
                      // ],)
                    ]),

                    SizedBox(
                      height: constraint.maxHeight * 0.05,
                    ),
                    //todo price
                    _container(
                        constraint.maxHeight * 0.275, constraint.maxWidth * 0.9, [
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
                        constraint.maxHeight * 0.25, constraint.maxWidth * 0.9, [
                      Text(
                        UseString.pleasechoosedate,
                        style: _textstyle(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(Jiffy([
                            _motorRentalFormBloc.dateTime.year,
                            _motorRentalFormBloc.dateTime.month,
                            _motorRentalFormBloc.dateTime.day
                          ]).yMMMMd)
                        ],
                      ),
                      _button(UseString.choosedate, () {
                        setState(() {
                          _motorRentalFormBloc.datepicker(setstate);
                        });
                      })
                    ]),
                    SizedBox(
                      height: 20,
                    ),
                    _container(
                        constraint.maxHeight * 0.25, constraint.maxWidth * 0.9, [
                      Text(
                        UseString.choosetime,
                        style: _textstyle(),
                      ),
                      Tags(
                        key: UniqueKey(),
                        itemCount: TimeSlot.toList(_motorRentalFormBloc.dateTime).length,
                        itemBuilder: (int index) {
                          final String timeslot = TimeSlot.toList(
                              _motorRentalFormBloc.dateTime)[index];
                          return ItemTags(
                            key: Key(timeslot),
                            index: index,
                            title: timeslot,
                            active: false,
                            removeButton: null,
                            onPressed: (ts) {
                              print("click is ${ts.title}");
                              _motorRentalFormBloc.checkitemtimeslot(ts);
                            },
                            color: Colors.white,
                            activeColor: PickCarColor.colormain,
                          );
                        },
                      ),
                    ]),
                    SizedBox(
                      height: 20,
                    ),
                    _submitbutton(this.context, () {
                      _motorRentalFormBloc
                          .add(MotorRentalFormSubmitFormEvent());
                    })
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _submitbutton(BuildContext context, Function onclick) {
    return ButtonTheme(
      height: 75,
      minWidth: MediaQuery.of(context).size.width * 0.9,
      child: GradientButton(
        elevation: 5,
        callback: () {
          onclick();
        },
        gradient: LinearGradient(colors: [
          PickCarColor.colormain,
          PickCarColor.colormain.withOpacity(0.7),
          Colors.yellow
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Center(
          child: Text(
            UseString.signup,
            style: TextStyle(fontSize: 24),
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

  Widget _button(
    String txt,
    Function onpress,
  ) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(color: PickCarColor.colormain)),
          onPressed: () {
            onpress();
          },
          color: PickCarColor.colormain,
          textColor: Colors.white,
          child: Text(txt),
        ),
      ),
    );
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
