import 'package:emart/Screens/cart_screen/collection.dart';
import 'package:get/get.dart';

import '../../common/widgets/loading.dart';
import '../../constants/const.dart';
import '../../features/cotroller/auth/auth.dart';
import '../../features/cotroller/firestore/firestore_services.dart';
import '../../features/cotroller/profile/profile_controller.dart';
import '../chat screen/all_msg_screen.dart';
import '../order_screen/view_order_screen.dart';
import '../wishlist_screen/wish_list.dart';
import 'edit_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final authController = Get.put(AuthController());
  final fireStoreController = Get.put(FireStore());
  final profileControllerController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();

    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: fireStoreController.getUserData(currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Loading();
        } else {
          var data = snapshot.data!.docs[0];
          String name = '${data['name']}';
          // String image = '${data['imageUrl']}';

          return SafeArea(
            child: customBg(
                child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                profileController.nameController.text = name;

                                Get.to(() => EditScreen(data: data));
                              },
                              child: const Icon(
                                Icons.edit,
                                color: whiteColor,
                              ),
                            ),
                          ),
                          ListTile(
                            leading:
                                //image == ''
                                const CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.transparent,
                              child: Icon(Icons.person_2),
                            ),

                            // : CircleAvatar(
                            //     radius: size.width * .058,
                            //     backgroundImage: NetworkImage(image),
                            //   ),
                            title: Text(
                              name.substring(0, 1).toUpperCase() +
                                  name.substring(1),
                              style: const TextStyle(
                                  color: whiteColor,
                                  fontFamily: semibold,
                                  fontSize: 18),
                            ),
                            subtitle: Text(
                              '${data['email']}',
                              style: const TextStyle(
                                color: whiteColor,
                                fontSize: 16,
                                fontFamily: regular,
                              ),
                            ),
                            trailing: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: whiteColor)),
                              onPressed: () async {
                                await authController.signOut().then((value) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                  utils.flutterToast("Logout Successfully");
                                });
                              },
                              child: const Text(
                                'Logout',
                                style: TextStyle(
                                    color: whiteColor,
                                    fontFamily: semibold,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder<List<int>>(
                      future: fireStoreController.getAllCount(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<int>> snapshot) {
                        if (!snapshot.hasData) {
                          return const Loading();
                        } else {
                          var countdata = snapshot.data!;
                          return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                cartButton(
                                    count: '${countdata[0]}',
                                    width: size.width / 3.4,
                                    title: "in your cart"),
                                cartButton(
                                    count: '${countdata[1]}',
                                    width: size.width / 3.4,
                                    title: "in your wishlist"),
                                cartButton(
                                    count: '${countdata[2]}',
                                    width: size.width / 3.4,
                                    title: "in your order"),
                              ]);
                        }
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: redColor,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: cartList.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              color: lightGrey,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              onTap: () {
                                switch (index) {
                                  case 0:
                                    Get.to(() => ViewOrderScreen());

                                    break;
                                  case 1:
                                    Get.to(() => ViewWishListScreen());

                                    break;
                                  case 2:
                                    Get.to(() => MsgScreen());

                                    break;
                                  default:
                                }
                              },
                              leading: Image.asset(
                                cartIconList[index],
                                width: 20,
                              ),
                              title: Text(
                                cartList[index],
                                style: const TextStyle(
                                    color: darkFontGrey,
                                    fontFamily: regular,
                                    fontSize: 12),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
          );
        }
      },
    );
  }
}
