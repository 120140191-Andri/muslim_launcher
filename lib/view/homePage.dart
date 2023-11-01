// ignore_for_file: file_names

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim_launcher/view/bacaAlQuran.dart';
import 'package:muslim_launcher/view/menuApps.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/global_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(context) {
    final ukuranLayar = MediaQuery.of(context).size;

    const SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/wallpaper.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(
            top: ukuranLayar.height * 0.1,
            left: ukuranLayar.width * 0.05,
            right: ukuranLayar.width * 0.05,
          ),
          child: Container(
            margin: const EdgeInsets.only(top: 170),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 70,
                  // color: Colors.amber,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WidgetJamDanTgl(),
                      SizedBox(width: 30),
                      WidgetJumlahPoin()
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const WidgetCardHistoryAyat(),
                SizedBox(
                  height: ukuranLayar.height - 610,
                  width: ukuranLayar.width,
                ),
                const MenuBawah(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WidgetJamDanTgl extends StatelessWidget {
  const WidgetJamDanTgl({super.key});

  @override
  Widget build(BuildContext context) {
    final ControllerWaktu cWaktu = Get.put(ControllerWaktu());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Text(
            cWaktu.jamSekarang.value,
            style: GoogleFonts.montserrat(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF32B641),
            ),
            textAlign: TextAlign.right,
          ),
        ),
        Obx(
          () => Text(
            cWaktu.tglSekarang.value,
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF32B641),
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}

class WidgetJumlahPoin extends StatelessWidget {
  const WidgetJumlahPoin({super.key});

  @override
  Widget build(context) {
    // Access the updated count variable

    final ControllerListApps cApps = Get.put(ControllerListApps());

    return Center(
      child: Row(
        children: [
          Text(
            'Jumlah Poin: ',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF32B641),
            ),
            textAlign: TextAlign.center,
          ),
          Obx(
            () => Text(
              '${cApps.poinSt.value} Poin',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF32B641),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class WidgetCardHistoryAyat extends StatelessWidget {
  const WidgetCardHistoryAyat({super.key});

  @override
  Widget build(BuildContext context) {
    final ControllerListApps cApps = Get.put(ControllerListApps());

    return GestureDetector(
      onTap: () {
        cApps.ambilApp();
        Get.to(() => const BacaAlQuran());
      },
      child: Container(
        height: 140,
        width: 240,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF32B641),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/img/icon-arrow.png',
                  height: 22,
                  width: 22,
                ),
                const SizedBox(width: 10),
                Text(
                  "Baca Ayat Al - Qur’an",
                  style: GoogleFonts.montserrat(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const SizedBox(height: 28),
            Text(
              'Surat yang terakhir dibaca:',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Obx(
              () => cApps.suratSt.value != ''
                  ? Text(
                      '${cApps.suratSt.value}(${cApps.ayatSt.value})',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Belum Ada',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuBawah extends StatelessWidget {
  const MenuBawah({super.key});

  @override
  Widget build(BuildContext context) {
    final ControllerListApps cApps = Get.put(ControllerListApps());

    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () async {
              Uri phoneno = Uri.parse('tel:');
              if (await launchUrl(phoneno)) {
                //dialer opened
              } else {
                //dailer is not opened
              }
            },
            child: Container(
              height: 61,
              width: 61,
              decoration: BoxDecoration(
                color: const Color(0xFF32B641),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image.asset(
                'assets/img/phone-call.png',
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              Uri phoneno = Uri.parse('sms:');
              if (await launchUrl(phoneno)) {
                //dialer opened
              } else {
                //dailer is not opened
              }
            },
            child: Container(
              height: 61,
              width: 61,
              decoration: BoxDecoration(
                color: const Color(0xFF32B641),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image.asset(
                'assets/img/email.png',
              ),
            ),
          ),
          // ignore: unrelated_type_equality_checks
          Obx(
            () => cApps.waApps.value
                ? GestureDetector(
                    onTap: () => DeviceApps.openApp('com.whatsapp'),
                    child: Container(
                      height: 61,
                      width: 61,
                      decoration: BoxDecoration(
                        color: const Color(0xFF32B641),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Image.asset(
                        'assets/img/whatsapp.png',
                      ),
                    ),
                  )
                : const SizedBox(width: 0),
          ),
          GestureDetector(
            onTap: () {
              cApps.ambilApp();
              Get.to(() => const MenuApps());
            },
            child: Container(
              height: 61,
              width: 61,
              decoration: BoxDecoration(
                color: const Color(0xFF32B641),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image.asset(
                'assets/img/app.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
