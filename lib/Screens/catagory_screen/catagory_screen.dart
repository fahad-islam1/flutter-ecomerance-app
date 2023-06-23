import 'package:emart/Screens/catagory_screen/cateegory_details.dart';
import 'package:get/get.dart';

import '../../constants/const.dart';
import '../../features/cotroller/category/category_controller.dart';

class CatagoriesScreen extends StatelessWidget {
  CatagoriesScreen({super.key});
  final categoryController = Get.put(CategoryModelController());

  @override
  Widget build(BuildContext context) {
    return customBg(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            categoryTitle,
            style: TextStyle(
              color: lightGrey,
              fontFamily: bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 250),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                categoryController.getSubCategory(
                    title: categoryTitleList[index]);

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryDetails(
                          appBarTitle: categoryTitleList[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: whiteColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          categoryImgList[index],
                          fit: BoxFit.cover,
                          height: 120,
                          width: 100,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Flexible(
                          child: Text(
                            categoryTitleList[index],
                            style: const TextStyle(
                                color: darkFontGrey,
                                fontFamily: semibold,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
