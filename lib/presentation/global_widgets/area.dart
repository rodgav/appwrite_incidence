import 'dart:math';

import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/presentation/resources/color_manager.dart';
import 'package:appwrite_incidence/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class AreaItem extends StatelessWidget {
  final Area area;
  final VoidCallback openDialog;

  const AreaItem(this.area, this.openDialog, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(Random().nextInt(256), Random().nextInt(256),
                Random().nextInt(256), Random().nextInt(256)),
            borderRadius: BorderRadius.circular(AppSize.s8),
            boxShadow: [
              BoxShadow(
                  color: ColorManager.grey,
                  offset: const Offset(AppSize.s2, AppSize.s2),
                  blurRadius: AppSize.s8)
            ]),
        child: Center(
          child: Text(area.name),
        ),
      ),
      onTap: openDialog,
    );
  }
}
