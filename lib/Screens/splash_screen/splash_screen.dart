
import '../../constants/const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashScreenMethod splashScreenMethod = SplashScreenMethod();
  @override
  void initState() {
    super.initState();
    splashScreenMethod.startTimer(context);
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
          child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              iconSplashBg,
              width: 299,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          appLogoWidget(),
          const SizedBox(
            height: 5,
          ),
          const Text(
            appName,
            style:
                TextStyle(color: Colors.white, fontFamily: bold, fontSize: 22),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            appVersion,
            style: TextStyle(color: golden, fontSize: 14),
          ),
        ],
      )),
    );
  }
}
