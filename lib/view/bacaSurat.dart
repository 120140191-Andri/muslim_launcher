// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:muslim_launcher/controller/global_controller.dart';
import 'package:auto_size_text/auto_size_text.dart';

class BacaSurat extends StatelessWidget {
  const BacaSurat({super.key});

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
                      margin: const EdgeInsets.symmetric(vertical: 10),
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
                                    width: 350,
                                    child: AutoSizeText(
                                      cQuran.listSuratDipilih[i]['teksArab'],
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 3,
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
                                    width: 350,
                                    child: AutoSizeText(
                                      cQuran.listSuratDipilih[i]['teksLatin'],
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 3,
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
                                    width: 350,
                                    child: AutoSizeText(
                                      cQuran.listSuratDipilih[i]
                                          ['teksIndonesia'],
                                      style: const TextStyle(fontSize: 14),
                                      maxLines: 3,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: TextButton.icon(
                                  onPressed: () {
                                    cQuran.selesaiBaca(
                                      cQuran.nomorSuratDipilih,
                                      cQuran.listSuratDipilih[i]['nomorAyat'],
                                    );
                                    cApps.suratSt.value =
                                        cQuran.namaLatinSuratDipilih.value;
                                    cApps.ayatSt.value = cQuran
                                        .listSuratDipilih[i]['nomorAyat']
                                        .toString();
                                    var poin =
                                        int.tryParse(cApps.poinSt.value)! + 1;
                                    cApps.poinSt.value = (poin).toString();
                                    Fluttertoast.showToast(
                                      msg: "Poin Berhasil Ditambah!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  },
                                  icon: const Icon(Icons.mic_none_sharp),
                                  label: const Text('Baca'),
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
