import 'package:get/get.dart';

import '../../constants/const.dart';
import '../../features/cotroller/auth/auth.dart';
import '../../features/cotroller/firestore/firestore_services.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isCheck = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController conformPassController = TextEditingController();
  var authController = Get.put(AuthController());
  var fireStoreController = Get.put(FireStore());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return customBg(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: size.height * .07,
            ),
            appLogoWidget(),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Sign up to e-Mart",
              style: TextStyle(color: fontGrey, fontFamily: bold, fontSize: 22),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: size.width - 70,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  customTextField(
                      //  isPass:false,
                      title: name,
                      hintText: hintName,
                      controller: nameController),
                  customTextField(
                      //  isPass: false,
                      title: email,
                      hintText: hintEmail,
                      controller: emailController),
                  customTextField(
                      ispass: true,
                      title: pass,
                      hintText: hintPass,
                      controller: passController),
                  customTextField(
                      ispass: true,
                      title: conformPass,
                      hintText: hintPass,
                      controller: conformPassController),
                  Row(
                    children: [
                      Checkbox(
                          checkColor: whiteColor,
                          activeColor: redColor,
                          value: isCheck,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue!;
                            });
                          }),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 250,
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                            text: agree,
                            style: TextStyle(
                                color: fontGrey, fontFamily: semibold),
                          ),
                          TextSpan(
                            text: termsAndConditions,
                            style: TextStyle(
                                color: redColor, fontFamily: semibold),
                          ),
                          TextSpan(
                            text: privacyPolicy,
                            style: TextStyle(
                              color: redColor,
                              fontFamily: semibold,
                            ),
                          ),
                        ])),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: size.width - 50,
                    child: customButton(
                        textColor: whiteColor,
                        color: isCheck == true ? redColor : lightGrey,
                        title: signUpAccount,
                        press: () {
                          if (isCheck == true) {
                            try {
                              authController
                                  .signUp(
                                      email: emailController.text,
                                      pass: passController.text,
                                      context: context)
                                  .then((value) {
                                return fireStoreController.storeUser(
                                    name: nameController.text,
                                    email: emailController.text,
                                    pass: passController.text);
                              }).then((value) {
                                utils.flutterToast("sign up Successfully");
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              });
                            } catch (e) {
                              utils.flutterToast(e.toString());
                            }
                          }
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        alreadyHaveAccount,
                        style: TextStyle(
                            color: fontGrey,
                            fontFamily: semibold,
                            fontSize: 15),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: const Text(
                          loginAccount,
                          style: TextStyle(
                              color: redColor,
                              fontFamily: semibold,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
