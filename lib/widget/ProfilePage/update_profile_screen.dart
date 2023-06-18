
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:travel_app/pages/profile_page.dart';
import 'package:travel_app/values/custom_snackbar.dart';
import 'package:travel_app/values/custom_text.dart';

import '../../model/users.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key, required this.users}) : super(key: key);

  final Users users;

  Future updateFavoriteDetails(
      String idUser, String name, int numberPhone, String address) async {
    final docUser = FirebaseFirestore.instance.collection("User").doc(idUser);
    await docUser.update({
      'name': name,
      'numberPhone': numberPhone,
      'address': address,
    });
  }

  Future updateImageUser(String idUser, String imageUser) async {
    final docUser = FirebaseFirestore.instance.collection("User").doc(idUser);
    await docUser.update({
      'imageUser': imageUser,
    });
  }

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  File? image;

  late String path_to_images;
  late File imagesFile;
  late Image images;

  @override
  void initState() {
    super.initState();
    path_to_images = widget.users.imageUser;
    imagesFile = File(path_to_images);
    images = Image.file(imagesFile);
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  final fullNameController = TextEditingController();
  final numberPhoneController = TextEditingController();
  // final emailController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    numberPhoneController.dispose();
    // emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                LineAwesomeIcons.angle_left,
                color: Colors.black,
              )),
        ),
        title:
            Text(EditProfile, style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Stack(children: [
                (image != null) //Avata
                    ? ClipOval(
                        child: Image.file(
                          image!,
                          width: 140,
                          height: 140,
                          fit: BoxFit.cover,
                        ),
                      )
                    : (image == null)
                        ? FlutterLogo(size: 130)
                        : (images.toString() == '')
                            ? FlutterLogo(size: 130)
                            : ClipOval(
                                child: Image.file(
                                  imagesFile,
                                  width: 140,
                                  height: 140,
                                  fit: BoxFit.cover,
                                ),
                              ),
                Positioned(
                    //Camera
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: ((builder) => bottomSheet()));
                      },
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                        size: 38,
                        shadows: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(0, 2),
                            blurRadius: 5.0,
                            spreadRadius: 1.0,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(0, 4),
                            blurRadius: 15.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                    )),
              ]),
              const SizedBox(height: 20),
              Form(
                  child: Column(
                children: [
                  QrImageView(
                    data: widget.users.idUser.toString(),
                    version: QrVersions.auto,
                    size: 100.0,
                  ),
                  TextFormField(
                    controller: fullNameController,
                    decoration: const InputDecoration(
                        labelText: "Full Name",
                        prefixIcon: Icon(Icons.person_outline_rounded)),
                  ),
                  // const SizedBox(height: 20),
                  // TextFormField(
                  //   controller: emailController,
                  //   decoration: const InputDecoration(
                  //       labelText: "Email",
                  //       prefixIcon: Icon(Icons.email_outlined)),
                  // ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: numberPhoneController,
                    decoration: const InputDecoration(
                        labelText: "Phone Number",
                        prefixIcon: Icon(Icons.phone_android_outlined)),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(
                        labelText: "Address",
                        prefixIcon: Icon(Icons.fingerprint)),
                  ),
                  const SizedBox(height: 35),

                  //Nút Edit Profile
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 35, left: 200), //Xem lại
                    child: SizedBox(
                        width: 230,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              // widget.updateFavoriteDetails(
                              //   widget.users.idUser.toString(),
                              //   fullNameController.text,
                              //   int.parse(numberPhoneController.text),
                              //   addressController.text,
                              // );
                              // final str = image.toString();
                              // final result = str.replaceAll("'", "").replaceAll("File: ", "");
                              // widget.updateImageUser(
                              //     widget.users.idUser, result);
                              Navigator.pop(context);
                              CustomSnackbar.show(context, 'Update thành công. Ảnh sẽ được \ncập nhật cho lần đăng nhập sau');
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffffd500),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40))),
                            child: const CustomText(
                                text: 'Edit',
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                                height: 1.3))),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: 150,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo from",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  pickImage(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text('Camera'),
              ),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    pickImage(ImageSource.gallery);
                  });
                  // takePhoto(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text('Gallery'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

InputDecoration decoration(String labelText) {
  return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white70),
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: Colors.white70)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(color: Colors.white70),
      ),
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.white70));
}