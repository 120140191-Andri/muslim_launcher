import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'dart:async';
import 'package:get/get.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:string_similarity/string_similarity.dart';

class ControllerWaktu extends GetxController {
  var jamSekarang = DateFormat('h:mm a').format(DateTime.now()).obs;
  var tglSekarang = DateFormat('E, d MMM y').format(DateTime.now()).obs;

  @override
  void onReady() {
    // Get called when controller is created
    super.onReady();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      jamSekarang.value = DateFormat('h:mm a').format(DateTime.now());
      tglSekarang.value = DateFormat('E, d MMM y').format(DateTime.now());
    });
  }
}

class ControllerListApps extends GetxController {
  RxList apps = [].obs;
  RxBool waApps = false.obs;
  RxString poinSt = '0'.obs;
  RxString ayatSt = ''.obs;
  RxString suratSt = ''.obs;

  // @override
  // void onInit() {
  //   // Get called when controller is created
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();

    cekPoin();
    ambilApp();
    cekInstalledWA();
  }

  Future<void> cekAyatDanSuratTerakhir() async {
    const storage = FlutterSecureStorage();
    String? ayat = await storage.read(key: 'ayat');
    String? surat = await storage.read(key: 'surat');

    if (ayat == null) {
      await storage.write(key: 'ayat', value: '');
    } else {
      ayatSt.value = ayat;
    }

    if (surat == null) {
      await storage.write(key: 'surat', value: '');
    } else {
      suratSt.value = surat;
    }
  }

  Future<void> cekPoin() async {
    const storage = FlutterSecureStorage();
    String? poin = await storage.read(key: 'poin');

    if (poin == null) {
      await storage.write(key: 'poin', value: '0');
    } else {
      poinSt.value = poin;
    }
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

class ControllerQuran extends GetxController {
  var count = 0.obs;
  var listSurah = [].obs;
  var nomorSuratDipilih = 0.obs;
  var namaSuratDipilih = ''.obs;
  var namaLatinSuratDipilih = ''.obs;
  var tempatTurunSuratDipilih = ''.obs;
  var artiSuratDipilih = ''.obs;
  var deskripsiSuratDipilih = ''.obs;
  RxList listSuratDipilih = [].obs;
  var suratDipilih = 0.obs;
  var ayatDipilih = 0.obs;

  SpeechToText speechToText = SpeechToText();
  var speechEn = false.obs;
  var kataAkhir = ''.obs;

  @override
  void onInit() {
    // Get called when controller is created
    super.onInit();
    bacaJsonSurah();
    initSpeech();
  }

  void initSpeech() async {
    speechEn.value = await speechToText.initialize();
  }

  void startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    if (result.recognizedWords != '') {
      kataAkhir.value = result.recognizedWords;
      var ayat = listSuratDipilih[ayatDipilih.value -= 1]['teksLatin'];
      analisa(ayat);
    }
  }

  void analisa(ayat) {
    var hasil = kataAkhir.value.similarityTo(ayat);
    prinhasil(hasil);
  }

  void prinhasil(has) {
    print("$has || ${kataAkhir.value} ||");
  }

  void stopListening() async {
    await speechToText.stop();
    print('berhenti');
  }

  void bacaJsonSurah() async {
    final String respon = await rootBundle.loadString('assets/surat.json');
    final data = await json.decode(respon);
    listSurah.value = data['data'];
  }

  void setSuratDipilih(no) async {
    suratDipilih.value = no;
    final String respon =
        await rootBundle.loadString('assets/detail_surat/$no.json');
    final data = await json.decode(respon);

    nomorSuratDipilih.value = data['data']['nomor'];
    namaSuratDipilih.value = data['data']['nama'];
    namaLatinSuratDipilih.value = data['data']['namaLatin'];
    tempatTurunSuratDipilih.value = data['data']['tempatTurun'];
    artiSuratDipilih.value = data['data']['arti'];
    deskripsiSuratDipilih.value = data['data']['deskripsi'];

    listSuratDipilih.value = data['data']['ayat'];
  }

  void selesaiBaca(noSurat, noAyat) async {
    ayatDipilih.value = noAyat;
    startListening();
  }
}
