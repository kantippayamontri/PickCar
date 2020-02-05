import 'package:flutter/material.dart';
import 'package:pickcar/bloc/login/loginevent.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/page/signuppage.dart';
import 'package:pickcar/ui/uisize.dart';
import 'package:pickcar/widget/login/signupbnt.dart';
import 'package:pickcar/widget/pickcar_login_widget.dart';
import '../bloc/login/loginbloc.dart';

class LoginPage extends StatefulWidget {
  int indicatorpage = 0;
  int i =0;
  // const LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin{
  // var username = 'g@g.com';
  // var password = '1234567';
  var username = 'f@f.com';
  var password = '1111111';

  //todo initusername and pass
  
  

  final _scaffoldkey = GlobalKey<ScaffoldState>();
  var _showloginstatus = false;

  void _summitSingInEmail() {
    final form = loginbloc.formkey.currentState;
    if (form.validate()) {
      form.save();
      loginbloc.add(SignInwithEmailEvent(loginbloc.emailcontroller.text,
          loginbloc.passcontroller.text, _checkerrorsignin));
    }
  }

  void _checkerrorsignin() {
    setState(() {
      _showloginstatus = loginbloc.showloginstatus();
    });
  }

  void _signup(){
    print('press sign up ja');
    Navigator.of(context).pushNamed(Datamanager.signuppage);
  }


  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    loginbloc.context = context;
    //todo test user
    loginbloc.emailcontroller.text = this.username;//"g@g.com";
    loginbloc.passcontroller.text = this.password; //"1234567";

    final List<Tab> myTabs = <Tab>[
      new Tab(
        child: Container(
          // width: double.infinity,
          // color: Colors.blue,
          child: Text(UseString.signin,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colormain), 
            ),
        ),
      ),
      new Tab(
        child: Container(
          // width: double.infinity,
          // margin: EdgeInsets.only(top: 10),
          child: Text(UseString.signup,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colormain), 
          ),
        ),
      ),
    ];
    TabController _tabController;
    _tabController = new TabController(vsync: this, length: myTabs.length,initialIndex: widget.indicatorpage);

    // @override
    // void dispose() {
    //   _tabController.dispose();
    //   super.dispose();
    // }

    // List<Widget> _titlewidget() {
    //   return [
    //     Text(
    //       'Welcome to',
    //       style: TextStyle(
    //         fontSize: 48,
    //         fontWeight: FontWeight.bold,
    //         fontFamily: 'Pridi-Bold',
    //         color: PickCarColor.colormain,
    //       ),
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //       'PickCar',
    //       style: TextStyle(
    //         fontSize: 48,
    //         fontWeight: FontWeight.bold,
    //         fontFamily: 'Pridi-Bold',
    //         color: PickCarColor.colormain,
    //       ),
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //       'The best way to make money. and make life\neasier from car.Let\'s get started! ',
    //       style: TextStyle(
    //           color: Colors.black, fontFamily: 'Pridi-Regular', fontSize: 18),
    //       textAlign: TextAlign.center,
    //     ),
    //     SizedBox(
    //       height: MediaQuery.of(context).size.height * (1 / 10.0),
    //     )
    //   ];
    // }
    Widget _horizontalLine() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );
    }
    body(BuildContext context){
      SizeConfig().init(context);
      if(widget.indicatorpage ==0){
        return Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                // ..._titlewidget(),
                _showloginstatus
                    ? loginbloc.signinsuccess
                        ? Container(
                            child: Text('Success'),
                          )
                        : Container(
                            child: Text('Fail to login'),
                          )
                    : SizedBox(height: 0,width: 0),
                PickCarLogin(loginbloc.emailcontroller, loginbloc.passcontroller,
                    _summitSingInEmail, loginbloc.formkey),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      }else{
        return SignUpPage();
      }
    }
    return Scaffold(
      backgroundColor:Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: Image(
            image: AssetImage('assets/images/imagesprofile/appbar/background.png'),
            fit: BoxFit.cover,
          ),
        centerTitle: true,
        bottom: TabBar(
            controller: _tabController,
            labelColor: PickCarColor.colormain,
            tabs: myTabs,
            indicatorColor: PickCarColor.colormain,
            onTap: (data){
              setState(() {
                widget.indicatorpage=data;
                print(widget.indicatorpage);
                widget.i =0;
              });
            },
          ),
        title: Container(
          width: SizeConfig.blockSizeHorizontal*20,
          child: Image.asset('assets/images/imagelogin/logo.png',fit: BoxFit.fill,)
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left,
          color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      key: _scaffoldkey,
      body:  body(context),
    );
  }
}
