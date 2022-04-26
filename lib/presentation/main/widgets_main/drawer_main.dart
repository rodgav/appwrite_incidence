import 'package:appwrite_incidence/intl/generated/l10n.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final int index;
  final bool small;
  final Function(int index) changePage;

  const DrawerWidget(this.index,{required this.changePage,this.small=false, Key? key}) : super(key: key);

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
                      ? const DrawerHeader(child: FlutterLogo())
                      : const SizedBox(),
                  ListTile(selected: index==0,
                    leading: const Icon(Icons.stream),
                    title:  Text(s.incidences),
                    onTap: () {
                      changePage(0);
                    },
                  ),
                  ListTile(selected: index==1,
                    leading: const Icon(Icons.stream),
                    title:  Text(s.areas),
                    onTap: () {
                      changePage(1);
                    },
                  ),
                  ListTile(selected: index==2,
                    leading: const Icon(Icons.stream),
                    title:  Text(s.supervisors),
                    onTap: () {
                      changePage(2);
                    },
                  ),
                  ListTile(selected: index==3,
                    leading: const Icon(Icons.stream),
                    title: Text(s.employees),
                    onTap: () {
                      changePage(3);
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
