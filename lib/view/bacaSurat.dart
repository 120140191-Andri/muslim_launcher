// ignore_for_file: file_names, unused_import

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:muslim_launcher/controller/global_controller.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BacaSurat extends StatelessWidget {
  const BacaSurat({super.key});

  Future<void> _bacaDalamHati() {
    final ControllerQuran cQuran = Get.put(ControllerQuran());

    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AlertDialog(
                title: Text('Baca ${cQuran.namaLatinSuratDipilih}'),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(11))),
                content: Column(
                  children: [
                    Text(
                      cQuran.listSuratDipilih[cQuran.nomorSuratDipilih.value]
                          ['teksArab'],
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                      maxLines: 3,
                      textAlign: TextAlign.end,
                    ),
                    const Divider(),
                    Image.asset(
                      'assets/img/tutor.jpg',
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(Object context) {
    final ControllerListApps cApps = Get.put(ControllerListApps());
    final ControllerQuran cQuran = Get.put(ControllerQuran());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF32B641),
        title: Obx(() => Text("Baca ${cQuran.namaLatinSuratDipilih}")),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Obx(() => Text('Poinmu: ${cApps.poinSt.value}')),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: cQuran.listSuratDipilih.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 0, // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2),
                              shape: BoxShape.circle,
                              // You can use like this way or like the below line
                              //borderRadius: new BorderRadius.circular(30.0),
                            ),
                            child: Center(
                              child: Text(
                                cQuran.listSuratDipilih[i]['nomorAyat']
                                    .toString(),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 80,
                                    child: AutoSizeText(
                                      cQuran.listSuratDipilih[i]['teksArab'],
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1000,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 80,
                                    child: AutoSizeText(
                                      cQuran.listSuratDipilih[i]['teksLatin'],
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1000,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 80,
                                    child: AutoSizeText(
                                      cQuran.listSuratDipilih[i]
                                          ['teksIndonesia'],
                                      style: const TextStyle(fontSize: 14),
                                      maxLines: 1000,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Obx(
                                () => cQuran.mendengarkan.value == true &&
                                        cApps.ayatSt.value ==
                                            cQuran.listSuratDipilih[i]
                                                    ['nomorAyat']
                                                .toString()
                                    ? Container(
                                        margin:
                                            const EdgeInsets.only(right: 60),
                                        child: Center(
                                          child: TextButton.icon(
                                            onPressed: () {
                                              cQuran.selesaiBaca(
                                                cQuran.nomorSuratDipilih,
                                                cQuran.listSuratDipilih[i]
                                                        ['nomorAyat'] -
                                                    1,
                                              );
                                              cApps.suratSt.value = cQuran
                                                  .namaLatinSuratDipilih.value;
                                              cApps.ayatSt.value = cQuran
                                                  .listSuratDipilih[i]
                                                      ['nomorAyat']
                                                  .toString();
                                            },
                                            icon: const Icon(
                                              Icons.mic_none_sharp,
                                              color: Colors.white,
                                            ),
                                            label: const Text(
                                              'Mendengarkan...',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.red),
                                            ),
                                          ),
                                        ),
                                      )
                                    : cQuran.dalamHati.value &&
                                            cApps.ayatSt.value ==
                                                cQuran.listSuratDipilih[i]
                                                        ['nomorAyat']
                                                    .toString()
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                                right: 60),
                                            child: Row(
                                              children: [
                                                Center(
                                                  child: TextButton.icon(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.read_more_sharp,
                                                      color: Colors.white,
                                                    ),
                                                    label: const Text(
                                                      'Tunggu & Baca Dalam Hati...',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  Colors.red),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                CircularPercentIndicator(
                                                  radius: 20.0,
                                                  lineWidth: 5.0,
                                                  percent: cQuran
                                                      .persentaseDalamHati
                                                      .value,
                                                  center: const Text(''),
                                                  progressColor: cQuran
                                                              .persentaseDalamHati
                                                              .value >=
                                                          .68
                                                      ? Colors.green
                                                      : cQuran.persentaseDalamHati
                                                                  .value >=
                                                              33
                                                          ? Colors.orange
                                                          : Colors.red,
                                                )
                                              ],
                                            ),
                                          )
                                        : Center(
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  right: 30),
                                              child: Row(
                                                children: [
                                                  TextButton.icon(
                                                    onPressed: () {
                                                      cQuran.selesaiBaca(
                                                        cQuran
                                                            .nomorSuratDipilih,
                                                        cQuran.listSuratDipilih[
                                                                    i]
                                                                ['nomorAyat'] -
                                                            1,
                                                      );
                                                      cApps.suratSt.value = cQuran
                                                          .namaLatinSuratDipilih
                                                          .value;
                                                      cApps.ayatSt.value =
                                                          cQuran
                                                              .listSuratDipilih[
                                                                  i]
                                                                  ['nomorAyat']
                                                              .toString();
                                                    },
                                                    icon: const Icon(
                                                      Icons.mic_none_sharp,
                                                      color: Colors.white,
                                                    ),
                                                    label: const Text(
                                                      'Baca dengan mic',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  Colors.blue),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  TextButton.icon(
                                                    onPressed: () {
                                                      cQuran
                                                          .selesaiBacaDalamHati(
                                                        cQuran
                                                            .nomorSuratDipilih,
                                                        cQuran.listSuratDipilih[
                                                                    i]
                                                                ['nomorAyat'] -
                                                            1,
                                                      );
                                                      cApps.suratSt.value = cQuran
                                                          .namaLatinSuratDipilih
                                                          .value;
                                                      cApps.ayatSt.value =
                                                          cQuran
                                                              .listSuratDipilih[
                                                                  i]
                                                                  ['nomorAyat']
                                                              .toString();
                                                    },
                                                    icon: const Icon(
                                                      Icons.read_more,
                                                      color: Colors.white,
                                                    ),
                                                    label: const Text(
                                                      'Baca Dalam Hati',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  Colors.blue),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
