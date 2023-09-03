import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Ouiacsh_app/core/utils/dimensions.dart';
import 'package:Ouiacsh_app/core/utils/my_color.dart';
import 'package:Ouiacsh_app/core/utils/my_strings.dart';
import 'package:Ouiacsh_app/data/controller/account/profile_controller.dart';
import 'package:Ouiacsh_app/data/repo/account/profile_repo.dart';
import 'package:Ouiacsh_app/data/services/api_service.dart';
import 'package:Ouiacsh_app/view/components/app-bar/custom_appbar.dart';
import 'package:Ouiacsh_app/view/components/custom_loader/custom_loader.dart';
import 'package:Ouiacsh_app/view/screens/Profile/widget/profile_top_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find()));
    final controller = Get.put(ProfileController(profileRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadProfileInfo();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.screenBgColor,
          appBar: CustomAppBar(
            title: MyStrings.profile.tr,
            bgColor: MyColor.getAppBarColor(),
          ),
          body: controller.isLoading ? const CustomLoader() : Stack(
            children: [
              Positioned(
                top: -10,
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  color: MyColor.primaryColor,
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: Dimensions.space15, right: Dimensions.space15, top: Dimensions.space20, bottom: Dimensions.space20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      ProfileTopSection(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
