import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final int index;
  final Function(int index) changePage;

  const DrawerWidget(this.index,{required this.changePage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: kIsWeb ? 0 : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  !kIsWeb
                      ? const DrawerHeader(child: FlutterLogo())
                      : const SizedBox(),
                  ListTile(selected: index==0,
                    leading: const Icon(Icons.stream),
                    title: const Text('Incidence'),
                    onTap: () {
                      changePage(0);
                    },
                  ),
                  ListTile(selected: index==1,
                    leading: const Icon(Icons.stream),
                    title: const Text('Areas'),
                    onTap: () {
                      changePage(1);
                    },
                  ),
                  ListTile(selected: index==2,
                    leading: const Icon(Icons.stream),
                    title: const Text('Supervisors'),
                    onTap: () {
                      changePage(2);
                    },
                  ),
                  ListTile(selected: index==3,
                    leading: const Icon(Icons.stream),
                    title: const Text('Employees'),
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
            title: const Text('Close'),
            onTap: () {
              changePage(4);
            },
          ),
        ],
      ),
    );
  }
}
