// ignore_for_file: file_names

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:muslim_launcher/controller/global_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MenuApps extends StatelessWidget {
  const MenuApps({super.key});

  @override
  Widget build(Object context) {
    final ControllerListApps cApps = Get.put(ControllerListApps());

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
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: cApps.apps.length,
                  itemBuilder: (BuildContext context, int i) {
                    return GestureDetector(
                      onTap: () {
                        if (cApps.apps[i].category
                            .toString()
                            .contains('productivity')) {
                          DeviceApps.openApp(cApps.apps[i].packageName);
                        } else {
                          var poin = int.tryParse(cApps.poinSt.value)!;
                          if (poin >= 1) {
                            cApps.poinSt.value = (poin - 1).toString();
                            DeviceApps.openApp(cApps.apps[i].packageName);
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
                                  .contains('productivity'))
                              ? Icons.lock_open
                              : Icons.lock,
                        ),
                        title: Text(cApps.apps[i].appName.toString()),
                        trailing: (cApps.apps[i].category
                                .toString()
                                .contains('productivity'))
                            ? const Text('')
                            : const Text(
                                '-1 Poin',
                                style: TextStyle(
                                  color: Colors.red,
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
