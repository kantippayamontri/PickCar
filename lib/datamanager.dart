import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/models/chat.dart';
import 'package:pickcar/models/coupon.dart';
import 'package:pickcar/models/listcarslot.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/models/placelocation.dart';
import 'package:pickcar/page/admin/adminmenu.dart';
import 'package:pickcar/page/chatpage.dart';
import 'package:pickcar/page/homepage.dart';
import 'package:pickcar/page/listcarpage.dart';
import 'package:pickcar/page/profile/profilepage.dart';
import 'package:pickcar/page/searchpage/search.dart';
import 'package:pickcar/page/setting/settingpage.dart';
import 'dart:typed_data';

import 'models/booking.dart';
import 'models/boxlocation.dart';
import 'models/boxslotnumber.dart';
import 'models/boxslotrentshow.dart';
import 'models/history.dart';
import 'models/pincar.dart';
import 'models/universityplace.dart';
import 'models/user.dart';

class Datamanager {
  static String loginpage = "/loginpage";
  static String mainloginpage = "/";
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
  static String motorbooklistpage = "/motorbooklistpage";
  static String chooseadminserverpage = "/chooseadminserverpage";

  static String listcar = "/Listcar";
  static String detailsearch = "/Detailsearch";
  static String slottiempage = "/SlotTiemPage";
  static String confirmpage = "/ConfirmPage";
  static String boxselectadmin = "/Boxselectadmin";
  static String placeselectadmin = "/Placeselectadmin";
  static String mapaddmark = "/Mapaddmark";

  static String registerMap = "/RegisterMap";
  static String mapboxselect = "/Mapboxselect";
  static String mapplaceselect = "/Mapplaceselect";

  static String selectUniversity = "/SelectUniversity";
  static String receivecar = "/Receivecar";
  static String bookedmap = "/Bookedmap";
  static String openkey = "/Openkey";
  static String animatedContainerApp = "/AnimatedContainerApp";
  static String search = "/SearchPage";
  static String maplocation = "/Maplocation";
  static String receivekeymap = "/Receivekeymap";
  static String addlocation = "/Addlocation";
  static String historypage = "/HistoryPage";
  static String serverpage = "/serverpage";
  static String chatpage = "/Chatpage";
  static String messagepage = "/Messagepage";
  static String fullimage = "/Fullimage";
  static String adminmenu = "/Adminmenu";
  static String adminlicense = "/adminlicense";
  static String sendlicensepage = "/Sendlicensepage";
  static String sendregistation = "/Sendregistation";
  static String coupongpage = "/Coupongpage";
  

  static final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  static FirebaseUser firebaseuser = null;
  static Firestore firestore = Firestore.instance;
  static User user = null;
  static MotorcycleShow motorcycleShow;
  static Usershow usershow;
  static Listcarslot listcarslot;
  static Slottime slottime;
  static Pincar pincar;
  static Chatprofileshow chatprofileshow;
  static Bookingshow booking;
  static BoxlocationShow boxlocationshow;
  static PlacelocationShow placelocationshow;
  static Boxslotrentshow boxslotrentshow;
  static Boxslotnumbershow boxslotnumbershow;
  static Couponshow couponshow;
  static String imageusershow;
  static Motorcycle motorcycle;
  static HistoryShow historyshow;
  static List<Universityplaceshow> universityshow = [];
  static List<String> listUniversity = [];
  static List<String> universitylist = ['Choose University'];

  static FirebaseStorage firebasestorage = FirebaseStorage.instance;

  static Function gontosearchinHome;

  static FirebaseDatabase realtimedatabase = FirebaseDatabase.instance;

  static List<Map<String, Object>> pages = [
    {
      'page': HomePage(
        gotosearchinHome: gontosearchinHome,
      ),
      'title': 'Home'
    },
    // {'page': Adminmenu(), 'title': 'Chat'},
    {'page': Chatpage(), 'title': 'Chat'},
    {'page': ListCarPage(), 'title': 'ListCar'},
    {'page': ProfilePage(), 'title': 'Profile'},
    {'page': SettingPage(), 'title': 'setting'},
  ];

  static var univeresity = [
    {
      "university": "Chiang Mai University",
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
    "Chiang Mai University",
    "sdfasdfasd",
    "dfasdfsdfasdf",
  ];
  static var universityforadmin = [
    'Choose University',
    "Chiang Mai University",
  ];
  static Map<String, Object> universitydatabase = {
    'Universityname': 'Chiang Mai University',
    'latitude': 18.802587,
    'longitude': 98.951556,
    'docid': '',
    'listplacebox': null,
    'listplacelocation': null,
  };

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
  static String signin = "Sign In";
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
      "Pick-a-Bike has created for make the great experience when you rental motorcycle from another one and make your life is excited.";
  static String rentalbutton = "Rental Bike";
  static String registertitle =
      "The best way to make money from your Motorcycle via Pick-a-Bike. We will give your new experience to earn more income. Let you make money with your motorcycle.";
  static String registerbutton = "Register Bike";
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
  static String precautionsdetail =
      "\t\t\tYou have to return the motorcycle before time out. \n\t\t\tyou can always cancel for free until 30 minutes before you receive the motorcycle.";
  static String warnning =
      "If you do not do as described above you will pay fee.";
  static String location = "Location";
  static String locationdetail = "\t\t\tThe location of vehicle and key box.";
  static String booking = "BOOKING";
  static String selecttime = "Select Time";
  static String next = "NEXT";
  static String searching = "Searching...";
  static String notfound = "Result not found.";
  static String time = "Time";
  static String date = "Date";
  static String delete = "Delete";
  static String cancel = "Cancel";

  static String pin = "Pin Here";
  static String addlocation = "Add location";
  static String loading = "Loading...";
  static String selectbox = "Select box";
  static String selectplace = "Select place";
  static String confirmrent = "Confirm Rental";
  static String rentaldetail = "Rentail Detail";
  static String selectedcar = "Selected Bike";
  static String getkey = "Get the key";
  static String getcar = "Get the Bike";
  static String receivecar = "Receive Bike";
  static String returncar = "Return Bike";
  static String day = "Datetime";
  static String totalprice = "Total price";
  static String pricedetail = "Price details";
  static String userdetail = "User details";
  static String readandagree = "I have read and agree to the ";
  static String policy = "policy and terms";
  static String forpolicy = "for rent.";
  static String confirm = "Confirm";
  static String notaccept = "You have not accepted the policy and terms.";
  static String pricebegin = "Price";
  static String pricefee = "Fee 5 THB";
  static String pricevat = "VAT (7%)";
  static String pickabike = "PicKaBike";
  static String logo = "Logo";
  static String username = "Username";
  static String remember = "Remember Me";
  static String emailhint = "email@example.com";
  static String passwordhint = "********";
  static String nearby = "Nearby";
  static String search = "Search";
  static String selectuniversity = "Select University";
  static String selectlocation = "Select Location";
  static String universityhint = "University...";
  static String locationhint = "Location...";
  static String chooselo = "Please select a location.";
  static String chooseuni = "Please select a university.";
  static String choosetimeslot = "Please select time.";
  static String chooseuniandlo = "Please select a university and location.";
  static String reset = "Reset";
  static String find = "FIND";
  static String booked = "Booked list";
  static String registercar = "Register list";
  static String locationplace = "Location";
  static String key = "Key";
  static String motor = "Motorcycle";
  static String notavailable = "Not Available";
  static String available = "Available";
  static String carnotavai = "Bike Not Available";
  static String keynotavai = "Key Not Available";
  static String wait = "wait";
  static String openmap = "Open Map location";
  static String maploacation = "Map Location";
  static String slotnumber = "Box Slot Number";
  static String openlocker = "Open Locker";
  static String contactowner = "Contact Owner";
  static String typeforrent = "Type For Rent";
  static String rent1 = "rent 1 slot";
  static String rent2 = "rent 2 slot";
  static String rent3 = "rent 3 slot";
  static String notimeforrent = "No Time For Rent.";
  static String areyousure = "Are yor sure?";
  static String rentthis = "Are you confident that you will rent this car?";
  static String pickcar = "Pick-a-Bike";
  static String inuniversity = "in";
  static String notbooked = "You not have booked motorcycle";
  static String unlock = "Unlock";
  static String thisplace = "The Bike is This location.";
  static String thiscar = "This location Bike";
  static String takekey = "Are you take a key?";
  static String checktakekey = "Check you already get key from box.";
  static String dropkey = "Are you drop a key?";
  static String checkdropkey = "Check you already drop key to box.";
  static String working = "working";
  static String history = "History";
  static String bookedhistory = "Booked";
  static String renthistory = "Rented";
  static String donthavehistory = "You not have history";
  static String waitting = "Waiting";
  static String bookking = "Booking";
  static String workking = "Working";
  static String gas = "Gas";
  static String petrol = "Petrol";
  static String gasandpetrol = "Gas(Petrol)";
  static String gasandpetrolval = "Please Enter Gas(Petrol)";
  static String carregistration = "Bike Registration";
  static String carregistrationval = "Please Enter Bike Registration";
  static String carownercancle = "Your motorcycle is cancle";
  static String sayhi = "Say hi to";
  static String sentimage = "sent image to you";
  static String you = "You";
  static String chatprofile = "Chat Profile";
  static String chat = "Chat";
  static String menu = "Admin Menu";
  static String checkdetail = "Approve license";
  static String placebox = "Place & Box Location";
  static String license = "License";
  static String adduniversity = "Add University";
  static String approve = "Approve";
  static String reject = "Reject";
  static String areyou = "Are you sure to";
  static String pleaseselecttitle = "Please select object";
  static String pleaseselectdetail =
      "The object does not select. \nPlease select object below.";
  static String fill = "Please fill empty blank";
  static String pleasewaittitle = "Please wait for approve driver license";
  static String pleasewaitbody =
      "It take 1-2 day for approve your driver license. \nIt will take than 3 day a few case.";
  static String rejectalert = "You driver license is rejected";
  static String rejectalertbody =
      "Please send new driver license again before rent.";
  static String driverlicense = "Driver License";
  static String save = "Save";
  static String gallory = "Gallory";
  static String camara = "Camara";
  static String uploaddriver = 'Upload driver license';
  static String uploadding = 'Uploading';
  static String senddriverlicense = 'Already Send driver licesnse';
  static String pleaseupload = 'Please Upload \nyou driver license.';
  static String licenseplate = 'License plate';

  static String pleasewaittitlecar =
      "Please wait for approve Vehicle registration";
  static String rejectalertcar = "You Vehicle registration is rejected";
  static String rejectalertbodycar =
      "Please send new Vehicle registration again before rent.";
  static String vehicleregistration = "Vehicle Registration";
  static String sendregistration = 'Already Send Vehicle registration';
  static String pleaseuploadcar = 'Please Upload \nyou Vehicle registration.';
  static String uploadregistration = 'Upload Vehicle registration';

  static String bookinreport = 'Your order  booking is cancel';
  static String cancelrent = 'Your bike is cancel';
  static String cancelappbar = 'CANCEL';
  static String sendlongmessage = 'new messages';
  static String fullslot = "You can't rent this time because this slot is full";
  static String status = "Status";
  static String complete = "Complete";
  static String youcancel = "Cancel by";
  static String yousmall = "you";
  static String owner = "owner";
  static String renter = "renter";
  static String expired = "Expired/Used";
  static String expire = "Expiring Soon";
  static String apply = "APPLY";
  static String promo = "Coupon Code";
  static String dopromo = "Do you have a Coupon code?";
  static String selectcoupon = "Select Coupon";
  static String coupon = "coupon";
  static String applied = "applied";
  static String remove = "REMOVE";
  static String discount = "Discount";
  static String notfoundcoupon = "Coupon does not found.";
  static String offin = "off in your next renter";
  static String validexpaired = "Valid Until: ";
  static String notcoupon = "You don't have coupon";
  static String ok ="OK";
  static String coupondetail = "you can use one coupon per renter.";
  static String couponrule = "Coupon Rule";
  static String back = "BACK";
  static String fardetail = "you can't open the box when you far from it more than 20 meter.";
  static String fartitle = "from box: ";
  static String meters = "meters";
  static String server = "SERVER";
  static String plate = "License Plate";
  static String gastype = "Gas Type";
  
}

class Currency {
  static String thb = "THB";
}

class Checkpolicy {
  static bool checkpolicy;
}

class Realtime {
  static var timekey;
  static var timecar;
  static var checkkeymap;
  static Timer checkalert;
  static Timer servertimer;
}

class Checkopenkey {
  static bool checkkey = false;
  static bool checkcar = false;
}

class ImageProfiles {
  static Uint8List profileUrl;
  static Uint8List drimotorcard;
  static Uint8List idcard;
  static Uint8List universitycard;
}

class SearchString {
  static String university;
  static String location;
  static String type;
}

class SetUniversity {
  static String university;
  static String location;
}

enum authProblems { UserNotFound, PasswordNotValid, NetworkError }
enum chooseimgenum { CAMERA, GALLERY }

class PickCarColor {
  static var colormain = Color.fromARGB(255, 60, 179, 113);
  static var colorcmu = Color.fromARGB(255, 66, 26, 94);
  static var colorFont1 = Color.fromARGB(255, 69, 79, 99);
  static var colorFont2 = Color.fromARGB(255, 148, 145, 145);
  static var colorbuttom = Color.fromARGB(255, 33, 197, 155);
}

class Datasearch {
  static List<String> boxlocationname = [];
  static List<double> boxlocationlatitude = [];
  static List<double> boxlocationlogtitude = [];
  static int boxlocationindex;
  static List<String> placelocationname = [];
  static List<double> placelocationlatitude = [];
  static List<double> placelocationlogtitude = [];
  static int placelocationindex;
}

class GearMotor {
  static String auto = "AUTO";
  static String manual = "MANUAL";

  static var gearmotormap = [
    {'gear': GearMotor.auto},
    {'gear': GearMotor.manual}
  ];
}

class Imagesoom {
  static var image;
  static var width;
  static var height;
}
class Activate{
  static bool activatecoupon =false;
  static bool pressed = false;
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

class DataFetch {
  static int fetchmotor = 0;
  static int fetchpiority = 0;
  static int checkhavedata = 0;
  static int checknotsamenoresult = 0;
  static int checknothaveslottime = 0;
  static int search = 0;
  static int waitplace = 0;
  static int waitlocation = 0;
  static int checkhavepin = 0;
  static int checkkey = 0;
  static int checkkeymap = 0;
  static int fetchhavecar = 0;
  static int fetchcancelalert = 0;
  static int waitloaddata = 0;
  static int logincancelshow = 0;
}

class TimeSlotSingle {
  static const String sub1 = "8.00 - 9.15";
  static const String sub2 = "9.30 - 10.45";
  static const String sub3 = "11.00 - 12.15";
  static const String sub4 = "13.00 - 14.15";
  static const String sub5 = "14.30 - 15.45";
  static const String sub6 = "16.00 - 17.15";

  static List<String> tolist() {
    return [sub1, sub2, sub3, sub4, sub5, sub6];
  }
}

class TimeslotDouble {
  static const String sub1 = "8.00 - 10.45";
  static const String sub2 = "9.30 - 12.15";
  static const String sub3 = "13.00 - 15.45";
  static const String sub4 = "14.30 - 17.15";
  static List<String> tolist() {
    return [sub1, sub2, sub3, sub4];
  }
}

class TypeRental {
  static String singleslot = "Single Slot";
  static String doubleslot = "Double Slot";

  static int waitplace = 0;
}

class TimeSearch {
  static bool time1 = false;
  static bool time2 = false;
  static bool time3 = false;
  static bool time4 = false;
  static bool time5 = false;
  static bool time6 = false;
  static DateTime today = DateTime.now();
  static DateTime yesterday = today.add(new Duration(days: -1));
  static DateTime nextmonth = today.add(new Duration(days: 30));
}

class TimeSlot {
  //TimeSlot();

  static const String sub1 = "8.00 - 9.30";
  static const String sub2 = "9.30 - 11.00";
  static const String sub3 = "11.00 - 12.30";
  static const String sub4 = "13.00 - 14.30";
  static const String sub5 = "14.30 - 16.00";
  static const String sub6 = "16.00 - 17.15";

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

class PickCarOil {
  static String gasoline91 = "Gasoline 91";
  static String gasoline95 = "Gasoline 95";
  static String gassohol91 = "Gassohol 91";
  static String gassohol95 = "Gassohol 95";
  static String gassohole20 = "Gassohol E20";
  static String gassohole85 = "Gassohol E85";

  static List<String> tolist() {
    return [
      gasoline91,
      gasoline95,
      gassohol91,
      gassohol95,
      gassohole20,
      gassohole85,
    ];
  }

  static var todropdpwnmap = [
    {'gas': PickCarOil.gasoline91},
    {'gas': PickCarOil.gasoline95},
    {'gas': PickCarOil.gassohol91},
    {'gas': PickCarOil.gassohol95},
    {'gas': PickCarOil.gassohole20},
    {'gas': PickCarOil.gassohole85},
  ];
}
