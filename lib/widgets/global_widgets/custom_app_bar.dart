import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fclp_app/Controllers/notification_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

AppBar customAppBar(BuildContext buildContext,
    {String? title, PreferredSizeWidget? preferredSizeWidget}) {
  return AppBar(
    centerTitle: false,
    title: (title == null) ? const Text("FCLP") : Text(title),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<NotificationController>(
            builder: (_, notificationController, __) {
          return Badge(
            label: Text(notificationController.totalNotification),
            isLabelVisible: (notificationController.totalNotification == "0" ||
                !notificationController.isNotificationSeen),
            child: InkWell(
              splashColor: AppColors.transparent,
              onTap: () {
                notificationController.setIsNotificationSeen = true;
                int index = -1;
                if (buildContext
                    .read<NotificationController>()
                    .notificationList
                    .isEmpty) {
                  showEmptyNotificationMenu(buildContext);
                  return;
                }
                showMenu(
                  elevation: 10,
                  popUpAnimationStyle: AnimationStyle(
                      curve: Curves.easeInCirc,
                      duration: const Duration(milliseconds: 500)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  color: Colors.white,
                  context: buildContext,
                  position: const RelativeRect.fromLTRB(60, 100, 0, 100),
                  items: List.generate(
                    buildContext
                        .read<NotificationController>()
                        .notificationList
                        .length,
                    (context) {
                      index++;
                      return PopupMenuItem(
                        child: Slidable(
                          key: Key(index.toString()),
                          endActionPane: ActionPane(
                              motion: const DrawerMotion(),
                              openThreshold: 0.1,
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    Navigator.pop(context);
                                    buildContext
                                        .read<NotificationController>()
                                        .removeNotification(
                                          buildContext
                                              .read<ProfileController>()
                                              .token,
                                          buildContext
                                              .read<NotificationController>()
                                              .notificationList[index]
                                              .id!,
                                        );
                                  },
                                  icon: Icons.delete,
                                  backgroundColor: AppColors.themeColor,
                                  label: "Remove",
                                  spacing: 1,
                                ),
                              ]),
                          child: Material(
                            color: Colors.white,
                            child: ListTile(
                              leading: Icon(
                                Icons.notifications_active_outlined,
                                color: AppColors.themeColor,
                              ),
                              title: Text(
                                buildContext
                                    .read<NotificationController>()
                                    .notificationList[index]
                                    .title!,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    textAlign: TextAlign.justify,
                                    buildContext
                                        .read<NotificationController>()
                                        .notificationList[index]
                                        .details!,
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    buildContext
                                        .read<NotificationController>()
                                        .notificationList[index]
                                        .createdAt!,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              child: const Icon(
                EvaIcons.bellOutline,
              ),
            ),
          );
        }),
      )
    ],
    bottom: preferredSizeWidget,
  );
}

void showEmptyNotificationMenu(BuildContext buildContext) {
  showMenu(
    elevation: 10,
    popUpAnimationStyle: AnimationStyle(
        curve: Curves.easeInCirc, duration: const Duration(milliseconds: 500)),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    color: Colors.white,
    context: buildContext,
    position: const RelativeRect.fromLTRB(100, 100, 0, 100),
    items: [
      PopupMenuItem(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Icon(
                Icons.notifications_active_outlined,
                color: AppColors.themeColor,
                size: 35,
              ),
              Text("You don't have any new notification")
            ],
          ),
        ),
      ),
    ],
  );
}
