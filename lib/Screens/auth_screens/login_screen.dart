import 'package:get/get.dart';

import '../../constants/const.dart';
import '../../features/cotroller/auth/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  var authController = Get.put(AuthController());

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
              login,
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
                      // isPass: false,
                      title: email,
                      hintText: hintEmail,
                      controller: emailController),
                  customTextField(
                      // isPass: true,
                      ispass: true,
                      title: pass,
                      hintText: hintPass,
                      controller: passController),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          forgetPassword,
                          style: TextStyle(
                            color: Colors.blue,
                            fontFamily: semibold,
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: size.width - 50,
                    child: customButton(
                        textColor: whiteColor,
                        color: redColor,
                        title: loginAccount,
                        press: () {
                          authController
                              .signIn(
                                  email: emailController.text,
                                  pass: passController.text,
                                  context: context)
                              .then((value) {
                            if (value != null) {
                              utils.flutterToast("Login Successfully");
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                            }
                          });
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    dontHaveAccount,
                    style: TextStyle(
                        color: fontGrey, fontFamily: semibold, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: size.width - 50,
                    child: customButton(
                        textColor: redColor,
                        color: lightGolden,
                        title: signUpAccount,
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    orLogin,
                    style: TextStyle(
                        color: fontGrey, fontFamily: semibold, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      socialIcon.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: lightGrey,
                          radius: 23,
                          child: Image.asset(
                            socialIcon[index],
                            width: 28,
                          ),
                        ),
                      ),
                    ),
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
