// ignore_for_file: file_names

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:muslim_launcher/controller/global_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:muslim_launcher/view/bacaAlQuran.dart';
import 'package:muslim_launcher/view/riwayatbaca.dart';
import 'package:muslim_launcher/view/riwayatpenggunaan.dart';

class HomeQuran extends StatelessWidget {
  const HomeQuran({super.key});

  @override
  Widget build(context) {
    final ControllerListApps cApps = Get.put(ControllerListApps());
    final ukuranLayar = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/bgs.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/img/Group35.png'),
              SizedBox(height: ukuranLayar.height * 0.1 + 30),
              GestureDetector(
                onTap: () {
                  cApps.ambilApp();
                  Get.to(() => const BacaAlQuran());
                },
                child: Image.asset('assets/img/Group 36.png'),
              ),
              SizedBox(height: ukuranLayar.height * 0.04),
              GestureDetector(
                onTap: () {
                  cApps.ambilApp();
                  Get.to(() => const RiwayatBaca());
                },
                child: Image.asset('assets/img/Group 37.png'),
              ),
              SizedBox(height: ukuranLayar.height * 0.04),
              GestureDetector(
                onTap: () {
                  cApps.ambilApp();
                  Get.to(() => const RiwayatPenggunaan());
                },
                child: Image.asset('assets/img/Group 38.png'),
              ),
              SizedBox(height: ukuranLayar.height * 0.04),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset('assets/img/Group 39.png'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
