import 'package:get/get.dart';

import '../../constants/const.dart';
import '../../features/cotroller/home/home_controller.dart';
import '../account_screen/profile_screen.dart';
import '../cart_screen/cart_screen.dart';


class Home extends StatelessWidget {
  Home({super.key});

  final homeController = Get.put(HomeController());

  final bottomItem = [
    BottomNavigationBarItem(
        icon: Image.asset(
          iconHome,
          width: 27,
        ),
        label: home),
    BottomNavigationBarItem(
        icon: Image.asset(iconCategories, width: 27), label: catagories),
    BottomNavigationBarItem(
        icon: Image.asset(iconCart, width: 27), label: cart),
    BottomNavigationBarItem(
        icon: Image.asset(iconProfile, width: 27), label: account),
  ];

  final bottomNavBar = [
     HomeScreen(),
    CatagoriesScreen(),
     CartScreen(),
    
    ProfileScreen(),
  ];

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: bottomNavBar.elementAt(homeController.currentIndex.value),
            ),
          ),
        ],
      ),
      bottomNavigationBar: StreamBuilder<int>(
        stream: homeController.currentIndex.stream,
        builder: (context, snapshot) {
          final currentIndex = snapshot.data ?? 0;
          return BottomNavigationBar(
            selectedItemColor: redColor,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (value) {
              homeController.currentIndex.value = value;
            },
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            backgroundColor: whiteColor,
            items: bottomItem,
          );
        },
      ),
    );
  }
}
