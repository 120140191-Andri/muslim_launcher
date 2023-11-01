// ignore_for_file: file_names

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:muslim_launcher/controller/global_controller.dart';
import 'package:muslim_launcher/view/bacaSurat.dart';

class BacaAlQuran extends StatelessWidget {
  const BacaAlQuran({super.key});

  @override
  Widget build(Object context) {
    final ControllerListApps cApps = Get.put(ControllerListApps());
    final ControllerQuran cQuran = Get.put(ControllerQuran());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF32B641),
        title: const Text('Baca Al-Quran'),
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
                  itemCount: cQuran.listSurah.length,
                  itemBuilder: (BuildContext context, int i) {
                    return GestureDetector(
                      onTap: () {
                        cQuran.setSuratDipilih(cQuran.listSurah[i]['nomor']);
                        Get.to(() => const BacaSurat());
                      },
                      child: ListTile(
                        isThreeLine: false,
                        minVerticalPadding: 2,
                        trailing: SizedBox(
                          width: 80,
                          child: Text(
                            cQuran.listSurah[i]['nama'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        title: Text(
                          cQuran.listSurah[i]['namaLatin'],
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          "${cQuran.listSurah[i]['tempatTurun']} - ${cQuran.listSurah[i]['jumlahAyat']} Ayat",
                          textAlign: TextAlign.start,
                        ),
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            shape: BoxShape.circle,
                            // You can use like this way or like the below line
                            //borderRadius: new BorderRadius.circular(30.0),
                          ),
                          child: Center(
                            child:
                                Text(cQuran.listSurah[i]['nomor'].toString()),
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
