import 'package:appwrite_incidence/domain/model/user_model.dart';
import 'package:appwrite_incidence/presentation/resources/assets_manager.dart';
import 'package:appwrite_incidence/presentation/resources/color_manager.dart';
import 'package:appwrite_incidence/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final UsersModel user;
  final VoidCallback openDialog;
  const UserItem(this.user,this.openDialog,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius:
            BorderRadius.circular(AppSize.s8),
            boxShadow: [
              BoxShadow(
                  color: ColorManager.grey,
                  offset: const Offset(
                      AppSize.s2, AppSize.s2),
                  blurRadius: AppSize.s8)
            ]),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Expanded(
              child:  Center(
                child: Image.asset(
                   user.typeUser == 'supervisor'
                        ? ImageAssets.supervisor
                        : ImageAssets.employe),
              ),
            ),
            const SizedBox(height: AppSize.s5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(user.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2),
            ),
            const SizedBox(height: AppSize.s5),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSize.s8),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Text(user.area,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1),
                  Text(user.typeUser,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1),
                ],
              ),
            ),
            const SizedBox(height: AppSize.s8),
          ],
        ),
      ),
      onTap: openDialog,
    );
  }
}
