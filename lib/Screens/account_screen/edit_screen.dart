// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:get/get.dart';

import '../../common/widgets/loading.dart';
import '../../constants/const.dart';
import '../../features/cotroller/firestore/firestore_services.dart';
import '../../features/cotroller/profile/profile_controller.dart';

class EditScreen extends StatefulWidget {
  final data;
  const EditScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var fireStoreController = Get.put(FireStore());
  var profileControllerController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var profilepic = Get.find<ProfileController>();

    return customBg(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: fireStoreController.getUserData(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Loading();
          } else {
            var data = snapshot.data!.docs[0];
            String name = '${data['name']}';

            String image = '${data['imageUrl']}';
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  top: size.height * .02,
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: EdgeInsets.all(
                    size.width * .05,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: whiteColor,
                  ),
                  child: Obx(
                    () => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        profileControllerController.profilePath.isEmpty &&
                                image == ' '
                            ? Image(
                                fit: BoxFit.cover,
                                width: size.width * .3,
                                height: 100,
                                image: const AssetImage(imgProfile),
                              )
                            : profileControllerController.profilePath.isEmpty &&
                                    image != ' '
                                ? CircleAvatar(
                                    radius: size.width * .15,
                                    backgroundImage: NetworkImage(image),
                                  )
                                : CircleAvatar(
                                    radius: size.width * .15,
                                    backgroundImage: FileImage(
                                      File(profileControllerController
                                          .profilePath.value),
                                    ),
                                  ),
                        const SizedBox(
                          height: 10,
                        ),
                        customButton(
                            textColor: whiteColor,
                            color: redColor,
                            title: "Change",
                            press: () async {
                              profilepic.changeImage();
                            }),
                        const Divider(),
                        customTextField(
                          title: name,
                          hintText: profilepic.nameController.text,
                          controller: profilepic.nameController,
                        ),
                        customTextField(
                            ispass: true,
                            title: oldpass,
                            hintText: oldpass,
                            controller: profilepic.oldpassController),
                        customTextField(
                            ispass: true,
                            title: newpass,
                            hintText: newpass,
                            controller: profilepic.newpassController),
                        profilepic.isLoading.value
                            ? utils.loading()
                            : SizedBox(
                                width: size.width - 30,
                                child: customButton(
                                    textColor: whiteColor,
                                    color: redColor,
                                    title: "Update",
                                    press: () async {
                                      profilepic.isLoading(true);
// when image is selected
                                      if (profilepic
                                          .profilePath.value.isNotEmpty) {
                                        await profileControllerController
                                            .updateImage();
                                      } else {
                                        // when image is not selected
                                        profilepic.profilePath.value = image;
                                      }

                                      if (data['password'] ==
                                          profilepic.oldpassController) {
                                        await profileControllerController
                                            .updateAuthPassword(
                                                oldPass: profilepic
                                                    .oldpassController.text,
                                                newPass: profilepic
                                                    .newpassController.text,
                                                email: data['email']);

                                        await profileControllerController
                                            .updateProfile(
                                                name: profilepic
                                                    .nameController.text,
                                                pass: profilepic
                                                    .newpassController.text,
                                                imageUrl: profilepic
                                                    .profileImageUrl
                                                    .toString())
                                            .then((value) {
                                          utils.flutterToast("Updated");
                                        });
                                      } else {
                                        utils.flutterToast(
                                            "please enter correct old password");
                                        profilepic.isLoading(false);
                                      }
                                    }),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    ));
  }
}
