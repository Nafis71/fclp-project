import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

AppBar customAppBar(BuildContext context,{String? title, PreferredSizeWidget? preferredSizeWidget}) {
  return AppBar(
    centerTitle: false,
    title: (title == null) ? const Text("FCLP") : Text(title),
    actions: [
      IconButton(onPressed: (){
        int index = -1;
        showMenu(
            color: Colors.white,
            context: context, position: const RelativeRect.fromLTRB(100, 100, 0, 100), items:
          List.generate(10, (context){
            index++;
            return PopupMenuItem(child: Slidable(
              key: Key(index.toString()),
              endActionPane: ActionPane(motion: DrawerMotion(), openThreshold: 0.1, children: [
                SlidableAction(
                    onPressed: (context) {},icon: Icons.delete,
                  backgroundColor: AppColors.themeColor,
                  label: "Remove",
                ),
              ]),
              child:  ListTile(
                leading: Icon(Icons.notifications_active_outlined,color: AppColors.themeColor,),
                title:  Text("Delivery Cost Paid Request Accepted"),
                subtitle: Text( textAlign: TextAlign.justify,"Delivery Cost Paid Request Admin verify and your order to be delivered. Thanks to with us."),
              ),
            ));
          })
        );
      }, icon: const Icon(EvaIcons.bellOutline))
    ],
    bottom: preferredSizeWidget,
  );
}
