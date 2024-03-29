// ignore_for_file: file_names

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muslim_launcher/controller/global_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuApps extends StatelessWidget {
  const MenuApps({super.key});

  @override
  Widget build(Object context) {
    final ControllerListApps cApps = Get.put(ControllerListApps());
    final ControllerQuran cQuran = Get.put(ControllerQuran());

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Obx(() => Text('Poinmu: ${cApps.poinSt.value}')),
            ),
            GestureDetector(
              onTap: () async {
                final Uri url = Uri.parse('https://saweria.co/TheDev');
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                child: const Row(
                  children: [
                    Icon(Icons.logo_dev),
                    SizedBox(width: 20),
                    Text('Donasi Ke Developer'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: cApps.apps.length,
                  itemBuilder: (BuildContext context, int i) {
                    return !cApps.notallowApps[i]
                        ? GestureDetector(
                            onTap: () {
                              if (cApps.apps[i].category
                                      .toString()
                                      .contains('productivity') ||
                                  cApps.allowApps[i]) {
                                DeviceApps.openApp(cApps.apps[i].packageName);
                              } else {
                                var poin = int.tryParse(cApps.poinSt.value)!;
                                if (poin >= 1) {
                                  cApps.poinSt.value = (poin - 1).toString();
                                  cApps.setPoin();
                                  DeviceApps.openApp(cApps.apps[i].packageName);
                                  cQuran.tambahRiwayatPoin(
                                      cApps.apps[i].appName.toString(),
                                      DateFormat("dd-MM-yyyy | hh:mm")
                                          .format(DateTime.now())
                                          .toString(),
                                      1);
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Poin Anda Kurang!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                }
                              }
                            },
                            child: ListTile(
                              leading: Icon(
                                (cApps.apps[i].category
                                            .toString()
                                            .contains('productivity')) ||
                                        cApps.allowApps[i]
                                    ? Icons.lock_open
                                    : Icons.lock,
                              ),
                              title: Text(cApps.apps[i].appName.toString()),
                              trailing: (cApps.apps[i].category
                                          .toString()
                                          .contains('productivity')) ||
                                      cApps.allowApps[i]
                                  ? const Text('')
                                  : const Text(
                                      '-1 Poin',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                            ),
                          )
                        : Container();
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
