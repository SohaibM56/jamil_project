import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:jamil_project/src/models/card_model.dart';
import 'package:jamil_project/src/repos/card_repository.dart';
import 'package:jamil_project/src/repos/storage_repository.dart';
import 'package:jamil_project/src/widgets/app_snackbar.dart';

class DashboardController extends GetxController {
  DashboardController(this._cardRepository, this._storageRepository);

  final CardRepository _cardRepository;
  final StorageRepository _storageRepository;

  final currentIndex = 1.obs;
  final isSocialMediaExpanded = true.obs;
  final card = Rxn<CardModel>();
  final isUpdatingPhoto = false.obs;
  final isSavingCard = false.obs;
  final pendingLinkPlatforms = <String>{}.obs;
  final hasLoadError = false.obs;

  String? cardId;
  StreamSubscription<CardModel>? _cardSubscription;

  @override
  void onInit() {
    super.onInit();
    _loadCard();
  }

  @override
  void onClose() {
    _cardSubscription?.cancel();
    super.onClose();
  }

  Future<void> retryLoadCard() => _loadCard();

  Future<void> _loadCard() async {
    hasLoadError.value = false;
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      cardId = await _cardRepository.fetchCardId(uid);
      await _cardSubscription?.cancel();
      _cardSubscription = _cardRepository.watchCard(cardId!).listen((value) {
        card.value = value;
      });
    } catch (error) {
      hasLoadError.value = true;
      AppSnackbar.error(
        'Error',
        error.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  void selectTab(int index) {
    currentIndex.value = index;
  }

  void toggleSocialMediaExpanded() {
    isSocialMediaExpanded.value = !isSocialMediaExpanded.value;
  }

  Future<void> updateTitle(String title) async {
    if (title.isEmpty || cardId == null || isSavingCard.value) return;

    isSavingCard.value = true;
    await _guard(
      () => _cardRepository.updateTitle(cardId!, title),
      successTitle: 'Updated',
      successMessage: 'Title updated successfully.',
    );
    isSavingCard.value = false;
  }

  Future<void> updateAccountInfo({
    required String name,
    required String title,
    required String phone,
  }) async {
    if (cardId == null || isSavingCard.value) return;

    isSavingCard.value = true;
    await _guard(
      () => _cardRepository.updateAccountInfo(
        cardId!,
        name: name.isNotEmpty ? name : card.value?.name ?? '',
        title: title.isNotEmpty ? title : card.value?.title ?? '',
        phone: phone.isNotEmpty ? phone : card.value?.phone ?? '',
      ),
      successTitle: 'Updated',
      successMessage: 'Card details updated successfully.',
    );
    isSavingCard.value = false;
  }

  Future<void> updatePhoto(File file) async {
    if (cardId == null || isUpdatingPhoto.value) return;

    isUpdatingPhoto.value = true;
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final url = await _storageRepository.uploadAvatar(uid: uid, file: file);
      await _cardRepository.updateProfileImage(cardId!, url);
      AppSnackbar.success('Updated', 'Profile photo updated successfully.');
    } catch (error) {
      AppSnackbar.error(
        'Error',
        error.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      isUpdatingPhoto.value = false;
    }
  }

  Future<void> toggleLinkVisibility(String platform, bool value) async {
    if (cardId == null ||
        card.value?.links[platform] == null ||
        pendingLinkPlatforms.contains(platform)) {
      return;
    }

    pendingLinkPlatforms.add(platform);
    await _guard(
      () => _cardRepository.setLinkVisibility(cardId!, platform, value),
      successTitle: 'Updated',
      successMessage: value
          ? 'Link is now visible on your card.'
          : 'Link is now hidden.',
    );
    pendingLinkPlatforms.remove(platform);
  }

  Future<void> upsertLink(String platform, String url) async {
    if (cardId == null || url.isEmpty || pendingLinkPlatforms.contains(platform)) {
      return;
    }

    pendingLinkPlatforms.add(platform);
    final isNew = card.value?.links[platform] == null;
    await _guard(
      () => _cardRepository.upsertLink(cardId!, platform, url, isNew: isNew),
      successTitle: 'Saved',
      successMessage: 'Link saved successfully.',
    );
    pendingLinkPlatforms.remove(platform);
  }

  Future<void> removeLink(String platform) async {
    if (cardId == null || pendingLinkPlatforms.contains(platform)) return;

    pendingLinkPlatforms.add(platform);
    await _guard(
      () => _cardRepository.removeLink(cardId!, platform),
      successTitle: 'Removed',
      successMessage: 'Link removed successfully.',
    );
    pendingLinkPlatforms.remove(platform);
  }

  Future<void> _guard(
    Future<void> Function() action, {
    required String successTitle,
    required String successMessage,
  }) async {
    try {
      await action();
      AppSnackbar.success(successTitle, successMessage);
    } catch (error) {
      AppSnackbar.error(
        'Error',
        error.toString().replaceFirst('Exception: ', ''),
      );
    }
  }
}
