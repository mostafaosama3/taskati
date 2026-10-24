import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_ce/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati2/core/constants/appimages.dart';
import 'package:taskati2/core/functions/Navigations.dart';
import 'package:taskati2/core/functions/extensions.dart';
import 'package:taskati2/core/functions/toast.dart';
import 'package:taskati2/core/services/local/hive_provider.dart';
import 'package:taskati2/core/styles/appcolor.dart';
import 'package:taskati2/core/styles/text_styles.dart';
import 'package:taskati2/core/widgets/custom_textfield.dart';
import 'package:taskati2/core/widgets/main_button.dart';
import 'package:taskati2/core/widgets/my_scaffold.dart';
import 'package:taskati2/core/widgets/secondary_button.dart';
import 'package:taskati2/feature/home/page/home_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final controller = TextEditingController();
  String imagePath = '';
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Complete Your Profile",
          style: TextStyles.body.copyWith(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                SingleChildScrollView(
                  child: _buildprofile(),
                ),
              ],
            ),
          ),
          MainButton(
            title: "Let’s Start !",
            ontap: () {
              if (imagePath.isEmpty && controller.text.isEmpty) {
                showErrorDialog(
                  context,
                  'Please enter a name and select an image',
                );
              } else if (imagePath.isEmpty && controller.text.isNotEmpty) {
                showErrorDialog(context, 'Please select an image');
              } else if (imagePath.isNotEmpty && controller.text.isEmpty) {
                showErrorDialog(context, 'Please enter a name');
              } else {

               
              HiveProvider.cacheUserData(name: controller.text, imagepath: imagePath);
             
                 pushReplacement(context, HomeScreen());
              }
            },
          ),
        ],
      ),
    );
  }

  Column _buildprofile() {
    return Column(
                  children: [
                    Column(
                      children: [
                        Gap(32),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Profile Image",
                            style: TextStyles.body.copyWith(
                              color: context.colorScheme.tertiary,
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            if (imagePath.isNotEmpty)
                              ClipOval(
                                child: Image.file(
                                  File(imagePath),
                                  height: 180,
                                  width: 180,
                                  fit: BoxFit.cover,
                                ),
                              )
                            else
                              ClipOval(
                                child: Image.asset(
                                  AppImages.userEmpty,
                                  width: 180,
                                  height: 180,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: context.theme.colorScheme.inversePrimary,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      imagePath = '';
                                    });
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: LightPalette.redColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SecondaryButton(
                              width: 150,
                              text: "From Camera",
                              onPressed: () => pickImage(true),
                            ),
                            Gap(16),
                            SecondaryButton(
                              width: 150,
                              text: "From Gallery",
                              onPressed: () => pickImage(false),
                            ),
                          ],
                        ),
                        Gap(40),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Your Name",
                            style: TextStyles.body.copyWith(
                              color: context.colorScheme.tertiary,
                            ),
                          ),
                        ),
                        Gap(16),
                        CustomTextField(
                          controller: controller,
                          hintText: "Enter your name",
                        ),
                      ],
                    ),
                  ],
                );
  }

  Future<void> pickImage(bool isCamera) async {
    var imagepicker = ImagePicker();
    XFile? pickedimage = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (pickedimage != null) {
      setState(() {
        imagePath = pickedimage.path;
      });
    }
  }
}
