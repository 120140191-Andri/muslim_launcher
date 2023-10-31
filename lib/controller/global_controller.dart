import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'dart:async';
import 'package:get/get.dart';
import 'package:device_apps/device_apps.dart';

class ControllerWaktu extends GetxController {
  var jamSekarang = DateFormat('h:mm a').format(DateTime.now()).obs;
  var tglSekarang = DateFormat('E, d MMM y').format(DateTime.now()).obs;

  @override
  void onInit() {
    // Get called when controller is created
    super.onInit();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      jamSekarang.value = DateFormat('h:mm a').format(DateTime.now());
      tglSekarang.value = DateFormat('E, d MMM y').format(DateTime.now());
    });
  }
}

class ControllerListApps extends GetxController {
  RxList apps = [].obs;
  RxBool waApps = false.obs;

  @override
  void onInit() {
    // Get called when controller is created
    super.onInit();
    cekDefault();
    ambilApp();
    cekInstalledWA();
  }

  Future<void> cekDefault() async {
    // final intent = await DeviceApps.getAppLaunchIntentForPackageName('');
  }

  Future<void> ambilApp() async {
    apps.value = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeSystemApps: true,
    );
    apps.sort((a, b) => a.appName.compareTo(b.appName));
  }

  Future<void> cekInstalledWA() async {
    bool isInstalled = await DeviceApps.isAppInstalled('com.whatsapp');
    waApps.value = isInstalled;
  }
}

class Controller extends GetxController {
  var count = 0.obs;
  var listSurah = [].obs;

  @override
  void onInit() {
    // Get called when controller is created
    super.onInit();
    bacaJsonSurah();
  }

  void bacaJsonSurah() async {
    final String respon = await rootBundle.loadString('assets/surat.json');
    final data = await json.decode(respon);
    listSurah.value = data['data'];
  }

  void increment() {
    count++;
  }
}
