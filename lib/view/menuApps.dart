// ignore_for_file: file_names

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:muslim_launcher/controller/global_controller.dart';

class MenuApps extends StatelessWidget {
  const MenuApps({super.key});

  @override
  Widget build(Object context) {
    // const SystemUiOverlayStyle systemUiOverlayStyle =
    //     SystemUiOverlayStyle(statusBarColor: Colors.black);
    // SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    final ControllerListApps cApps = Get.put(ControllerListApps());

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text('Poinmu: 10'),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: cApps.apps.length,
                  itemBuilder: (BuildContext context, int i) {
                    return GestureDetector(
                      onTap: () =>
                          DeviceApps.openApp(cApps.apps[i].packageName),
                      child: ListTile(
                        leading: Icon(
                          cApps.apps[i].category
                                  .toString()
                                  .contains('productivity')
                              ? Icons.lock_open
                              : Icons.lock,
                        ),
                        title: Text(cApps.apps[i].appName.toString()),
                        trailing: cApps.apps[i].category
                                .toString()
                                .contains('productivity')
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
