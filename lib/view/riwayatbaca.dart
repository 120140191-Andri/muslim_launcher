// ignore_for_file: file_names

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:muslim_launcher/controller/global_controller.dart';

class RiwayatBaca extends StatelessWidget {
  const RiwayatBaca({super.key});

  @override
  Widget build(Object context) {
    final ControllerListApps cApps = Get.put(ControllerListApps());
    final ControllerQuran cQuran = Get.put(ControllerQuran());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF32B641),
        title: const Text('Riwayat Baca'),
        actions: [
          Row(
            children: [
              Image.asset('assets/img/Vector.png'),
              const SizedBox(width: 4),
              Obx(
                () => Text(
                  cApps.poinSt.value,
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(width: 18),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: cQuran.listSurah.length,
                  itemBuilder: (BuildContext context, int i) {
                    return GestureDetector(
                      onTap: () {
                        // cQuran.setSuratDipilih(cQuran.listSurah[i]['nomor']);
                        // Get.to(() => const BacaSurat());
                      },
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Color(0xFF32B641),
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                        ),
                        child: ListTile(
                          isThreeLine: false,
                          minVerticalPadding: 2,
                          trailing: const SizedBox(
                            width: 80,
                            child: Column(
                              children: [
                                Text(
                                  "3",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                Text(
                                  "Poin",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ),
                          title: Text(
                            cQuran.listSurah[i]['namaLatin'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            "${cQuran.listSurah[i]['tempatTurun']} - ${cQuran.listSurah[i]['jumlahAyat']} Ayat",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              shape: BoxShape.circle,
                              // You can use like this way or like the below line
                              //borderRadius: new BorderRadius.circular(30.0),
                            ),
                            child: Center(
                              child: Text(
                                cQuran.listSurah[i]['nomor'].toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
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
