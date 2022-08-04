
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:atticadesign/Api/api.dart';
import 'package:atticadesign/Helper/Session.dart';
import 'package:atticadesign/Helper/myAccount.dart';
import 'package:atticadesign/Model/EditProfileModel.dart';
import 'package:atticadesign/Utils/ApiBaseHelper.dart';
import 'package:atticadesign/Utils/Common.dart';
import 'package:atticadesign/Utils/Session.dart';
import 'package:atticadesign/Utils/colors.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:atticadesign/Utils/widget.dart';
import 'package:atticadesign/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import '../HomePage.dart';
import 'package:http/http.dart' as http;
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isChecked = false;
  final imagec = TextEditingController();
  final nameC = TextEditingController();
  final mobileC = TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  TextEditingController emailController = new TextEditingController();

  TextEditingController nameController = new TextEditingController();

  TextEditingController addController = new TextEditingController();

  bool status = false;

  bool selected = false, enabled = false, edit1 = false;



  @override
  void initState() {
    super.initState();
    getSaved();
  }

  getSaved() async {
    await App.init();
    if (App.localStorage.getString("address") != null) {
      setState(() {
        addController.text = App.localStorage.getString("address").toString();
      });
    }
    if (App.localStorage.getString("image") != null) {
      setState(() {
        image = App.localStorage.getString("image").toString();
      });
    }
    if (App.localStorage.getString("name") != null) {
      setState(() {
        nameController.text = App.localStorage.getString("name").toString();
      });
    }
    if (App.localStorage.getString("email") != null) {
      setState(() {
        emailController.text = App.localStorage.getString("email").toString();
      });
    }
    if (App.localStorage.getString("phone") != null) {
      setState(() {
        phoneController.text = App.localStorage.getString("phone").toString();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15654F),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF15654F),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            "assets/images/newbackss.png",
            height: 8,
            width: 8,
          ),
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white54),
        ),
      ),
      body: firstSign(context),
    );
  }
  Widget firstSign(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 4.92.h,
            ),
            InkWell(
              onTap: (){
                requestPermission(context);
              },
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      height: getHeight(120),
                      width: getWidth(120),
                      child: _image!=null?Image.file(_image!,  height: getHeight(120),
                        width: getWidth(120),fit: BoxFit.fill,):commonHWImage(
                          image,
                          120.0,
                          120.0,
                          "assets/images/manuser.png",
                          context,
                          "assets/images/manuser.png"),
                    ),
                  ),
                  Positioned(
                    right: getWidth1(10),
                      bottom: getWidth1(10),
                    child: Container(
                      height: 4.39.h,
                      width: 4.39.h,
                      decoration: boxDecoration(
                          radius: 100, bgColor: MyColorName.primaryDark),
                      child: Center(
                        child: Icon(
                          Icons.edit_outlined,
                          size: 2.39.h,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            boxHeight(20),
            Container(
              width: getWidth1(590),
              child: TextFormField(
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  fillColor: MyColorName.colorTextFour.withOpacity(0.3),
                  filled: true,
                  prefixIcon: Container(
                      height: getHeight1(16),
                      width: getWidth1(16),
                      padding: EdgeInsets.all(getWidth1(15)),
                      child: Icon(
                        Icons.person_outline,
                        color: MyColorName.primaryDark,
                      )),
                  label: text("User Name"),
                ),
              ),
            ),
            boxHeight(53),
           /* Container(
              width: getWidth1(590),
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.name,
                enabled: true,
                decoration: InputDecoration(
                  fillColor: MyColorName.colorTextFour.withOpacity(0.3),
                  filled: true,
                  prefixIcon: Container(
                      height: getHeight1(16),
                      width: getWidth1(16),
                      padding: EdgeInsets.all(getWidth1(15)),
                      child: Image.asset(
                        "images/our_gurantees/mail.png",
                        color: MyColorName.primaryDark,
                      )),
                  label: text("Email"),
                ),
              ),
            ),
            boxHeight(53),*/
            Container(
              width: getWidth1(590),
              child: TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  fillColor: MyColorName.colorTextFour.withOpacity(0.3),
                  filled: true,
                  enabled: false,
                  prefixIcon: Container(
                      height: getHeight1(16),
                      width: getWidth1(16),
                      padding: EdgeInsets.all(getWidth1(15)),
                      child: Icon(
                        Icons.call_outlined,
                        color: MyColorName.primaryDark,
                      )),
                  label: text("Mobile"),
                ),
              ),
            ),
          /*  boxHeight(53),
            Container(
              width: getWidth1(590),
              child: TextFormField(
                controller: addController,
                keyboardType: TextInputType.name,
                minLines: 3,
                maxLines: 3,
                decoration: InputDecoration(
                  fillColor: MyColorName.colorTextFour.withOpacity(0.3),
                  filled: true,
                  prefixIcon: Container(
                      height: getHeight1(16),
                      width: getWidth1(16),
                      padding: EdgeInsets.all(getWidth1(15)),
                      child: Image.asset(
                        "images/our_gurantees/location.png",
                        color: MyColorName.primaryDark,
                      )),
                  label: text("Address"),
                ),
              ),
            ),*/
            boxHeight(53),
            SizedBox(
              height: 3.02.h,
            ),
            NewButton(
                width: getWidth1(625),
                textContent: "Save",
                onPressed: () {
                  if (nameController.text == "") {
                    setSnackbar("Please Enter Name", context);
                    return;
                  }
                  setState(() {
                    selected = true;
                  });
                  submitSubscription();
                },
                selected: selected),
          ],
        ),
      ),
    );
  }
  File? _image;
  Future getImage(ImgSource source, BuildContext context) async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      cameraIcon: Icon(
        Icons.add,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    setState(() {
      _image = File(image.path);
      getCropImage(context);
    });
  }

  void getCropImage(BuildContext context) async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: _image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    setState(() {
      _image = croppedFile;
    });
  }

  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  Future<void> submitSubscription() async {
    await App.init();

    ///MultiPart request
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        if (_image != null) {
          var request = http.MultipartRequest(
            'POST',
            Uri.parse(baseUrl + "update_profile"),
          );
          Map<String, String> headers = {
            "token": App.localStorage.getString("token").toString(),
            "Content-type": "multipart/form-data"
          };
          request.files.add(
            http.MultipartFile(
              'image',
              _image!.readAsBytes().asStream(),
              _image!.lengthSync(),
              filename: _image!.path != null ? path.basename(_image!.path) : path.basename("assets/images/manuser.png"),
              contentType: MediaType('image', 'jpeg'),
            ),
          );
          request.headers.addAll(headers);
          request.fields.addAll({
            "username": nameController.text,
            "mobile": phoneController.text,
            "id": curUserId.toString(),
            "type": "upload_profile",
          });
          print("request: " + request.toString());
          var res = await request.send();
          print("This is response:" + res.toString());
          setState(() {
            selected = false;
          });
          if (res.statusCode == 200) {
            final respStr = await res.stream.bytesToString();
            print(respStr.toString());
            Map data = jsonDecode(respStr.toString());

            if (!data['error']) {
              setState(() {
                App.localStorage.setString("image", data['data']['image']);
                App.localStorage.setString("name", nameController.text);
              /*  App.localStorage.setString("email", emailController.text);
                App.localStorage.setString("address", addController.text);*/
                name = nameController.text;
             ///   email =emailController.text;
                image = data['data']['image'];
                setSnackbar(data['message'].toString(), context);
                Navigator.pop(context,"yes");
              });
            } else {
              setSnackbar(data['message'].toString(), context);
            }
          }
        }       else {
          Map data;
          data = {
            "profile" : "",
            "name": nameController.text,
            "id": curUserId.toString(),
            "mobile": phoneController.text.trim().toString(),
            "address": addController.text,
            "type": "upload_profile",
          };
          print(data);
          Map response = await apiBase.postAPICall(Uri.parse(baseUrl + "update_profile"),data);
          print(response);
          bool status = true;
          String msg = response['message'];
          if (!response['error']) {
            setState(() {
              App.localStorage.setString("name", nameController.text);
              App.localStorage.setString("email", emailController.text);
              App.localStorage.setString("address", addController.text);
              name = nameController.text;
              email =emailController.text;
              setSnackbar(response['message'].toString(), context);
              Navigator.pop(context,"yes");
            });
          } else {
            setSnackbar(response['message'].toString(), context);
          }

        }
      } on TimeoutException catch (_) {
        setSnackbar("Something Went Wrong", context);
        setState(() {
          selected = true;
        });
      }
    } else {
      setSnackbar("No Internet Connection", context);
      setState(() {
        selected = true;
      });
    }
  }
  void requestPermission(BuildContext context) async{
    if (await Permission.camera.isPermanentlyDenied||await Permission.storage.isPermanentlyDenied) {

      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      openAppSettings();
    }
    else{
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        Permission.storage,
      ].request();
// You can request multiple permissions at once.

      if(statuses[Permission.camera]==PermissionStatus.granted&&statuses[Permission.storage]==PermissionStatus.granted){
        getImage(ImgSource.Gallery, context);

      }else{
        if (await Permission.camera.isDenied||await Permission.storage.isDenied) {

          // The user opted to never again see the permission request dialog for this
          // app. The only way to change the permission's status now is to let the
          // user manually enable it in the system settings.
          openAppSettings();
        }else{
          setSnackbar("Oops you just denied the permission", context);
        }

      }
    }

  }
}

Widget imageProfile() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: AssetImage('assets/images/profileUser.jpeg'),
          // child: Image.asset('assets/images/editprofile.png',height: 150,),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: (){
              bottomsheet();
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        )
      ]),
    ),
  );
}

Widget bottomsheet(){
  return Container(
    height: 100.0,
    width: 50,
    // width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 20.0,
    ),
    child: Column(
      children: <Widget>[
        Text("Choose Profile photo",style: TextStyle(fontSize: 20.0),),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                  onPressed: (){},
                  icon: Icon(Icons.camera),
                  label: Text("Camera")
              ),
              TextButton.icon(
                  onPressed: (){},
                  icon: Icon(Icons.photo),
                  label: Text("Gallery")
              )
            ]
        )
      ],
    ),
  );
}
