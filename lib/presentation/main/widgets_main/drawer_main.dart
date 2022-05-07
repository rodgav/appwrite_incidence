import 'package:appwrite_incidence/intl/generated/l10n.dart';
import 'package:appwrite_incidence/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final int index;
  final bool small;
  final Function(int index) changePage;
  final VoidCallback? closeDrawer;

  const DrawerWidget(this.index,
      {required this.changePage,
      this.small = false,
      this.closeDrawer,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Drawer(
      elevation: small ? null : 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  small
                      ? DrawerHeader(child: Image.asset(ImageAssets.logo))
                      : const SizedBox(),
                  ListTile(
                    selected: index == 0,
                    leading: const Icon(Icons.stream),
                    title: Text(s.incidences),
                    onTap: () {
                      changePage(0);
                      closeDrawer?.call();
                    },
                  ),
                  ListTile(
                    selected: index == 1,
                    leading: const Icon(Icons.stream),
                    title: Text(s.areas),
                    onTap: () {
                      changePage(1);closeDrawer?.call();
                    },
                  ),
                  ListTile(
                    selected: index == 2,
                    leading: const Icon(Icons.stream),
                    title: Text(s.users),
                    onTap: () {
                      changePage(2);closeDrawer?.call();
                    },
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.close),
            title: Text(s.close),
            onTap: () {
              changePage(4);
            },
          ),
        ],
      ),
    );
  }
}
