import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/models/listcarslot.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/page/homepage.dart';
import 'package:pickcar/page/listcarpage.dart';
import 'package:pickcar/page/profile/profilepage.dart';
import 'package:pickcar/page/searchpage/search.dart';
import 'package:pickcar/page/setting/settingpage.dart';
import 'dart:typed_data';

import 'models/user.dart';

class Datamanager {
  static String loginpage = "/";
  static String signuppage = "/signuppage";
  static String tabpage = "/tabpage";
  static String registerpage = "/registerpage";
  static String motorregisterpage = "/motorregisterpage";
  static String carregisterpage = "/carregisterpage";
  static String rentalpage = "/rentalpage";
  static String listcarpage = "/listcarpage";
  static String editprofile = "/editprofile";
  static String editdetail = "/editdetail";
  static String changepassword = "/ChangePassword";
  static String newpassword = "/Newpassword";
  static String emailsend = "/Emailsend";

  static String listcar = "/Listcar";
  static String detailsearch = "/Detailsearch";
  static String slottiempage = "/SlotTiemPage";
  static String confirmpage = "/ConfirmPage";
  

  static final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  static FirebaseUser firebaseuser = null;
  static Firestore firestore = Firestore.instance;
  static User user = null;
  static MotorcycleShow motorcycleShow;
  static Usershow usershow;
  static Listcarslot listcarslot;
  static Slottime slottime;

  static FirebaseStorage firebasestorage = FirebaseStorage.instance;

  static List<Map<String, Object>> pages = [
    {'page': HomePage(), 'title': 'Home'},
    {'page': ChatPage(), 'title': 'Chat'},
    {'page': ListCarPage(), 'title': 'ListCar'},
    {'page': ProfilePage(), 'title': 'Profile'},
    {'page': SettingPage(), 'title': 'setting'},
  ];

  static var univeresity = [
    {
      "university": "Chaing Mai University",
      "faculty": ["Engineering", "Science", "Humantility"]
    },
    {
      "university": "sdfasdfasd",
      "faculty": ["sdfasdfas", "sdfasdfs", "sdfasdfasd"]
    },
    {
      "university": "dfasdfsdfasdf",
      "faculty": ["sdfasdfsd", "sdfasd", "sdfasdfsdfas"]
    }
  ];

  static var faculty = [
    {"faculty": "Engineering"},
    {"faculty": "Science"},
    {"faculty": "Humantility"}
  ];
  static var faculty2 = [
    "Engineering",
    "Science",
    "Humantility",
  ];
  static var univeresity2 = [
    "Chaing Mai University",
    "sdfasdfasd",
    "dfasdfsdfasdf",
  ];

  static var year = [
    {"year": "1"},
    {"year": "2"},
    {"year": "3"},
    {"year": "4"},
    {"year": "5"},
    {"year": "6"},
  ];
}

class UseString {
  static String name = "Name";
  static String nameemptyval = "Please Enter Name.";
  static String signup = "Sign Up";
  static String university = "University";
  static String chooseuniversity = "Please choose your University";
  static String faculty = "Faculty";
  static String choosefaculty = "Please choose your Faculty";
  static String profile = "Profile";
  static String email = "Email";
  static String emailtypeval = "Please Enter Email";
  static String password = "Password";
  static String passwordtypeval = "Please Enter Password";
  static String passworddontsame = "Your password doesn\'t match";
  static String confirmpassword = "Confirm Password";
  static String passwordlenght = "your password must be at least 6 characters";
  static String telnumber = "Telephone Number";
  static String telnumberval = "Please Enter Telephone Number";
  static String address = "Address";
  static String addressval = "Please Enter Address";
  static String idcard = "ID Card";
  static String universitycard = "University Card";
  static String driverliscensemotorcycle =
      "Driver Liscense Card(for motorcycle)";
  static String driverliscensecarcycle = "Driver Liscense Card(for car)";
  static String rentaltitle =
      "Pickcar has created for make the great experience when you rental car from another one and make your life is excited.";
  static String rentalbutton = "Rental Car";
  static String registertitle =
      "The best way to make money from your car via Pickcar. We will give your new experience to earn more income. Let you make money with your car.";
  static String registerbutton = "Register Car";
  static String motorcycle = "Motorcycle";
  static String car = "Car";
  static String brand = "Brand";
  static String brandval = "Please Enter Brand";
  static String generation = "Generation";
  static String generationval = "Please Enter Generation";
  static String cc = "CC";
  static String ccval = "Please Enter CC";
  static String gear = "Gear";
  static String gearval = "Please Enter Gear";
  static String color = "Color";
  static String colorval = "Please Enter Color";
  static String motorprofile = "Motorcycle Profile";
  static String motorprofileval = "Please choose Motorcycle Profile";
  static String ownerliscense = "Owner liscense (If you not an owner)";
  static String navhome = "Home";
  static String navsearch = "Search";
  static String navlist = "List";
  static String navprofile = "Profile";
  static String navsetting = "Setting";
  static String facultyof = "Facuty of";
  static String camera = "Camera";
  static String galley = "Gallery";
  static String detail = "Details";
  static String currentpass = "Your Current Password.";
  static String forgetpass = "if you forget password.";
  static String changepass = "Change password.";
  static String newpass = "New Password";
  static String repeatpass = "Repeat new Password";
  static String passwordinvalid = "Password is incorrect.";
  static String forgetpasspage = "Forget password";
  static String enteraccount = "Please enter the email account you.";
  static String send = "Send";
  static String emailinvalid = "Email is incorrect.";
  static String edit = "Edit";
  static String profileimg = "Profile Image";
  static String motorliscense = "Driveliscense Motorcycle";
  static String profilede = "Profile detail";
  static String logout = "Log Out";
  static String motorfront = "Motorcycle front picture";
  static String motorleft = "Motorcycle left picture";
  static String motorright = "Motorcycle right picture";
  static String motorback = "Motorcycle back picture";
  static String waiting = "Wait a few seconds";
  static String picuploadval = "Please select all images.";
  static String close = "Close";
  static String registermotorfail = "Fail to register motorcycle.";
  static String waitingforrent = "Waiting for rent";
  static String price = "Price (Baht)";
  static String minimumprice = "Minimum price is ";
  static String baht = "Baht";
  static String pleasechoosedate = "Please choose date";
  static String choosedate = "Choose Date";
  static String choosetime = "Choose Time";
  static String information = "Information";
  static String aroundmotorcycle = "Around the motorcycle";
  static String forrent = "For rent by";
  static String included = "Included in the price";
  static String freecancle = "Free cancellation before 30 minute.";
  static String insurancemotorcycle = "Free motorcycle insurance.";
  static String precautions = "Precautions";
  static String precautionsdetail = "\t\t\tYou have to return the motorcycle before time out. \n\t\t\tyou can always cancel for free until 30 minutes before you receive the motorcycle.";
  static String warnning = "If you do not do as described above you will pay fee.";
  static String location = "Location";
  static String locationdetail = "\t\t\tThe location of vehicle and key box.";
  static String booking = "BOOKING";
  static String selecttiem = "Select Time";
  static String next = "NEXT";
  static String searching = "Searching...";
}
class Currency{
  static String thb = "THB";
}
class ImageProfiles {
  static Uint8List profileUrl;
  static Uint8List drimotorcard;
  static Uint8List idcard;
  static Uint8List universitycard;
}

enum authProblems { UserNotFound, PasswordNotValid, NetworkError }
enum chooseimgenum { CAMERA, GALLERY }

class PickCarColor {
  static var colormain = Color.fromARGB(255, 60, 179, 113);
  static var colorcmu = Color.fromARGB(255, 66, 26, 94);
  static var colorFont1 = Color.fromARGB(255, 69, 79, 99);
  static var colorFont2 = Color.fromARGB(255, 148, 145, 145);
}

class GearMotor {
  static String auto = "AUTO";
  static String manual = "MANUAL";

  static var gearmotormap = [
    {'gear': GearMotor.auto},
    {'gear': GearMotor.manual}
  ];
}

class CarStatus {
  static const String nothing = "NOTHING";
  static const String waiting = "WAITING";
  static const String booked = "BOOKED";
  static const String working = "WORKING";
  static const String waitbook = "WAITING  BOOKED";
  static const String waitwork = "WAIT  WORKING";
  static const String bookwork = "BOOKED  WORK";
  static const String waitbookwork = "WAITING  BOOKED  WORKING";

  static String checkcarstatus(Motorcycle motorcycle) {
    bool iswait = motorcycle.iswaiting;
    bool isbook = motorcycle.isbook;
    bool iswork = motorcycle.isworking;

    if (isbook && iswait && iswork) {
      return CarStatus.waitbookwork;
    }

    if (isbook && iswait) {
      return CarStatus.waitbook;
    }

    if (iswait && iswork) {
      return CarStatus.waitwork;
    }

    if (isbook && iswork) {
      return CarStatus.bookwork;
    }

    if (isbook) {
      return CarStatus.booked;
    }

    if (iswait) {
      return CarStatus.waiting;
    }

    if (iswork) {
      return CarStatus.working;
    }

    return CarStatus.nothing;
  }
}
class CarPrice {
  static const double motorminprice = 50.0;
}
class DataFetch{
  static int fetchmotor = 0; 
  static int fetchpiority = 0; 
}

class TimeSlot {
  //TimeSlot();

  static const String sub1 = "8.00 - 9.30";
  static const String sub2 = "9.30 - 11.00";
  static const String sub3 = "11.00 - 12.30";
  static const String sub4 = "13.00 - 14.30";
  static const String sub5 = "14.30 - 16.00";
  static const String sub6 = "16.00 - 17.30";

  static List<String> timeslotlist = List<String>();
  static DateTime now = DateTime.now();
  static int year = now.year;
  static int month = now.month;
  static int day = now.day;
  static int hr = now.hour;
  static int min = now.minute;

  static List<String> loadlist(DateTime timecheck) {
    timeslotlist = List<String>();
    bool check = !((year == timecheck.year) &&
        (month == timecheck.month) &&
        (day == timecheck.day));
    if (now.isBefore(DateTime(year, month, day, 8, 0)) || check) {
      timeslotlist.add(sub1);
    }
    if (now.isBefore(DateTime(year, month, day, 9, 30)) || check) {
      timeslotlist.add(sub2);
    }
    if (now.isBefore(DateTime(year, month, day, 11, 0)) || check) {
      timeslotlist.add(sub3);
    }

    if (now.isBefore(DateTime(year, month, day, 13, 0)) || check) {
      timeslotlist.add(sub4);
    }
    if (now.isBefore(DateTime(year, month, day, 14, 30)) || check) {
      timeslotlist.add(sub5);
    }
    if (now.isBefore(DateTime(year, month, day, 16, 0)) || check) {
      timeslotlist.add(sub6);
    }

    return timeslotlist;
  }

  static List<String> toList(DateTime date) {
    return loadlist(date);
  }

}
