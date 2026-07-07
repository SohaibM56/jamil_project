import 'package:get/get.dart';

class DashboardController extends GetxController {
  final currentIndex = 0.obs;
  final isDarkMode = false.obs;
  final isSocialMediaExpanded = true.obs;
  final cardName = 'Abdullah Jamil'.obs;
  final cardTitle = 'Engineer'.obs;
  final cardPhone = '0501829941'.obs;
  final cardEmail = 'othermm5@gmail.com'.obs;
  final profileLinks = <String, bool>{'Whatsapp': true, 'Instagram': true}.obs;
  final socialLinks = <String, bool>{
    'Whatsapp': false,
    'Instagram': false,
    'TikTok': false,
  }.obs;
  final socialLinkUrls = <String, String>{}.obs;

  void selectTab(int index) {
    currentIndex.value = index;
  }

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
  }

  void toggleSocialMediaExpanded() {
    isSocialMediaExpanded.value = !isSocialMediaExpanded.value;
  }

  void toggleProfileLink(String label, bool value) {
    profileLinks[label] = value;
  }

  void updateCard({
    required String name,
    required String title,
    required String phone,
  }) {
    if (name.isNotEmpty) cardName.value = name;
    if (title.isNotEmpty) cardTitle.value = title;
    if (phone.isNotEmpty) cardPhone.value = phone;
  }

  void toggleSocialLink(String label) {
    socialLinks[label] = !(socialLinks[label] ?? false);
  }

  void addSocialLink(String label, String url) {
    socialLinkUrls[label] = url;
    socialLinks[label] = true;
  }

  void removeSocialLink(String label) {
    socialLinkUrls.remove(label);
    socialLinks[label] = false;
  }
}
