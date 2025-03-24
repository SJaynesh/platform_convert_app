import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_convert_app/controllers/homepage_controller.dart';
import 'package:platform_convert_app/controllers/switch_controller.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<SwitchController>(context, listen: true);
    var providerFalse = Provider.of<SwitchController>(context, listen: false);
    var homePageControllerTrue =
        Provider.of<HomePageController>(context, listen: true);
    var homePageControllerFalse =
        Provider.of<HomePageController>(context, listen: false);
    return (!providerTrue.isIOS)
        ? Scaffold(
            appBar: AppBar(
              title: Text("Home Page"),
              centerTitle: true,
              actions: [
                // Consumer<SwitchController>(
                //   builder: (context, provider, _) => Switch(
                //     value: provider.isIOS,
                //     onChanged: (val) {
                //       provider.changePlatform();
                //     },
                //   ),
                // )
                Switch(
                  value: providerTrue.isIOS,
                  onChanged: (val) {
                    providerFalse.changePlatform();
                  },
                )
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text("Bottom Sheet"),
                        ),
                      );
                    },
                    child: Text("Show Bottom Sheet"),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async {
                        DateTime? dateTime = await showDatePicker(
                          context: context,
                          barrierColor: Colors.grey,
                          cancelText: "Close",
                          confirmText: "Done",
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2030),
                        );

                        log("DateTime : $dateTime");

                        homePageControllerFalse.setDateTime(date: dateTime);
                      },
                      icon: Icon(Icons.date_range),
                    ),
                    Text((homePageControllerTrue.currentDate != null)
                        ? "${homePageControllerTrue.currentDate?.day}/${homePageControllerTrue.currentDate?.month}/${homePageControllerTrue.currentDate?.year}"
                        : "DD/MM/YYYY"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async {
                        TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (time != null) {
                          homePageControllerFalse.setHourAndMinute(
                              h: time.hour, m: time.minute);
                          log("${time.hour % 12} : ${time.minute}");
                        }
                      },
                      icon: Icon(Icons.watch_later),
                    ),
                    Text(homePageControllerTrue.hour != 0 &&
                            homePageControllerTrue.minutes != 0
                        ? "${homePageControllerTrue.hour} : ${homePageControllerTrue.minutes}"
                        : "HH : MM"),
                  ],
                )
              ],
            ),
          )
        : CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text("Home Page"),
              trailing: CupertinoSwitch(
                value: providerTrue.isIOS,
                onChanged: (val) {
                  providerFalse.changePlatform();
                },
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CupertinoButton.filled(
                    // color: CupertinoColors.black,
                    child: Text("Action Sheet"),
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoActionSheet(
                          title: Text("Title"),
                          message: Text("This is cupertino action sheet"),
                          actions: [
                            CupertinoActionSheetAction(
                              onPressed: () {},
                              child: Text("First"),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: () {},
                              child: Text("Second"),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: () {},
                              child: Text("Third"),
                            ),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            isDefaultAction: true,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                CupertinoActivityIndicator(
                  radius: 20,
                  color: Colors.green,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => Container(
                            height: 300,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.date,
                              initialDateTime: DateTime.now(),
                              backgroundColor: Colors.transparent,
                              onDateTimeChanged: (dateTime) {
                                log("DateTime : $dateTime");
                                homePageControllerFalse.setDateTime(
                                    date: dateTime);
                              },
                            ),
                          ),
                        );
                      },
                      icon: Icon(CupertinoIcons.calendar),
                    ),
                    Text((homePageControllerTrue.currentDate != null)
                        ? "${homePageControllerTrue.currentDate?.day}/${homePageControllerTrue.currentDate?.month}/${homePageControllerTrue.currentDate?.year}"
                        : "DD/MM/YYYY"),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => SizedBox(
                        height: 300,
                        child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (dateAndTime) {
                              homePageControllerFalse.setHourAndMinute(
                                  h: dateAndTime.hour, m: dateAndTime.minute);
                              log("${dateAndTime.hour} : ${dateAndTime.minute}");
                            }),
                      ),
                    );
                  },
                  icon: Icon(CupertinoIcons.time),
                ),
                Text(homePageControllerTrue.hour != 0 &&
                        homePageControllerTrue.minutes != 0
                    ? "${homePageControllerTrue.hour} : ${homePageControllerTrue.minutes}"
                    : "HH : MM"),
                Center(
                  child: CupertinoButton.filled(
                    // color: CupertinoColors.black,
                    child: Text("Cupertino Alert Dialog"),
                    onPressed: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: Text("Alert"),
                          content: Text("This is a cupertino dialog box"),
                          actions: [
                            CircleAvatar(),
                            CupertinoDialogAction(
                              child: Text("Yes"),
                              onPressed: () {},
                            ),
                            CupertinoDialogAction(
                              child: Text("No"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
