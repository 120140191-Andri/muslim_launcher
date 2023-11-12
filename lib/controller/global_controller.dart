// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'dart:async';
import 'package:get/get.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:diacritic/diacritic.dart';
import 'package:string_similarity/string_similarity.dart';
import 'dart:math';

class ControllerWaktu extends GetxController {
  var jamSekarang = DateFormat('h:mm a').format(DateTime.now()).obs;
  var tglSekarang = DateFormat('E, d MMM y').format(DateTime.now()).obs;

  var misiSurah = ''.obs;
  var poinSurah = 0.obs;
  var statusMisi = ''.obs;

  @override
  void onReady() {
    // Get called when controller is created
    super.onReady();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      jamSekarang.value = DateFormat('h:mm a').format(DateTime.now());
      tglSekarang.value = DateFormat('E, d MMM y').format(DateTime.now());

      if (jamSekarang.value == '12:00 AM') {
        final ControllerQuran cQuran = Get.put(ControllerQuran());
        Random random = Random();
        int randomNumber = random.nextInt(1);

        if (randomNumber == 1) {
          Random ran = Random();
          int rand = ran.nextInt(113);

          misiSurah.value = cQuran.listSurah[rand]['namaLatin'];
          poinSurah.value = cQuran.listSurah[rand]['jumlahAyat'];
          statusMisi.value = 'berjalan';
        } else {
          misiSurah.value = '';
          poinSurah.value = 0;
          statusMisi.value = '';
        }
      }
    });
  }
}

class ControllerListApps extends GetxController {
  RxList apps = [].obs;
  RxBool waApps = false.obs;
  RxString poinSt = '0'.obs;
  RxString ayatSt = ''.obs;
  RxString suratSt = ''.obs;
  RxList allowApps = [].obs;
  RxList notallowApps = [].obs;
  RxList riwayatBaca = [].obs;
  RxList riwayatPoin = [].obs;

  // @override
  // void onInit() {
  //   // Get called when controller is created
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();

    ambilApp();
    cekInstalledWA();
    cekAyatDanSuratTerakhir();
    cekPoin();
    cekRiwayatBaca();
    cekRiwayatPoin();
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

  Future<void> cekRiwayatBaca() async {
    const storage = FlutterSecureStorage();
    String? data = await storage.read(key: 'riwayatBaca');

    if (data == null) {
      await storage.write(key: 'riwayatBaca', value: jsonEncode([]));
    } else {
      riwayatBaca.value = jsonDecode(data);
    }
  }

  Future<void> cekRiwayatPoin() async {
    const storage = FlutterSecureStorage();
    String? data = await storage.read(key: 'riwayatPoin');

    if (data == null) {
      await storage.write(key: 'riwayatPoin', value: jsonEncode([]));
    } else {
      riwayatPoin.value = jsonDecode(data);
    }
  }

  Future<void> ambilApp() async {
    var allow = [
      'gojek',
      'meet',
      'rosalia',
      'mahasiswa',
      'maxim',
      'ojek',
      'google',
      'maps',
      'linkedin',
      'camera',
      'kamera',
      'foto',
      'play store',
      'classroom',
      'canva',
      'message',
      'satusehat',
      'setelan',
      'spotify',
      'whatsapp',
      'grab',
      'gopartner',
      'gobiz',
      'gopay',
      'goagent',
      'indrive',
      'mail',
      'radio',
    ];

    var notallow = [
      'vpn',
      'opera',
      'uc',
      'nekopoi',
      'yandex',
      'duckduckgo',
      'terabox',
      'vidmate',
      'launcher',
    ];

    apps.value = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeSystemApps: true,
    );

    apps.sort((a, b) => a.appName.compareTo(b.appName));
    allowApps.value = [];
    notallowApps.value = [];

    for (var i = 0; i < apps.length; i++) {
      allowApps.add(false);
      notallowApps.add(false);
      for (var n = 0; n < allow.length; n++) {
        if (apps[i]
            .appName
            .toString()
            .toUpperCase()
            .contains(allow[n].toString().toUpperCase())) {
          allowApps[i] = true;
        }
      }
      for (var x = 0; x < notallow.length; x++) {
        if (apps[i]
            .appName
            .toString()
            .toUpperCase()
            .contains(notallow[x].toString().toUpperCase())) {
          notallowApps[i] = true;
        }
      }
    }

    // print(notallowApps.length);
    // print(apps.length);
  }

  Future<bool> cekKategori(i) async {
    var kat = ['productivity', 'undefined'];
    var allow = false;

    kat.map(
      (e) => {
        if (apps[i].category.toString().contains(e)) {allow = true},
      },
    );

    return allow;
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

  final ControllerListApps cApps = Get.put(ControllerListApps());

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
    if (result.recognizedWords != '' && result.finalResult) {
      kataAkhir.value = result.recognizedWords;
      var ayat = listSuratDipilih[ayatDipilih.value]['teksLatin'];
      analisa(ayat);
    }
  }

  void tambahPoin() async {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'poin', value: cApps.poinSt.value);
  }

  void terakhirbaca() async {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'ayat', value: cApps.ayatSt.value);
    await storage.write(key: 'surat', value: cApps.suratSt.value);
  }

  void tambahRiwayatBaca(surat, ayat, poin) async {
    const storage = FlutterSecureStorage();
    var listAwal = cApps.riwayatBaca;

    var tambah = {
      'surat': surat,
      'ayat': ayat,
      'poin': poin,
    };

    listAwal.add(tambah);

    await storage.write(key: 'riwayatBaca', value: jsonEncode(listAwal));
  }

  void tambahRiwayatPoin(app, tgl, poin) async {
    const storage = FlutterSecureStorage();
    var listAwal = cApps.riwayatPoin;

    var tambah = {
      'app': app,
      'tgl': tgl,
      'poin': poin,
    };

    listAwal.add(tambah);

    await storage.write(key: 'riwayatPoin', value: jsonEncode(listAwal));
  }

  void analisa(ayat) {
    // replaceAll(RegExp('[^A-Za-z]'), '')
    var ayatProses = removeDiacritics(ayat)
        .toUpperCase()
        .replaceAll(RegExp('[^A-Za-z]'), '');
    var input =
        kataAkhir.value.toUpperCase().replaceAll(RegExp('[^A-Za-z]'), '');
    var hasil = input.similarityTo(ayatProses);
    prinhasil(hasil, input, ayatProses);
  }

  void prinhasil(has, input, ayat) {
    if (has >= 0.65) {
      var poin = int.tryParse(cApps.poinSt.value)! + 1;
      cApps.poinSt.value = (poin).toString();

      tambahPoin();
      terakhirbaca();

      Fluttertoast.showToast(
        msg: "Poin Berhasil Ditambah!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    //print("$has || $input || $ayat");
  }

  void stopListening() async {
    await speechToText.stop();
    //print('berhenti');
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
