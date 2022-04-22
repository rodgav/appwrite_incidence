import 'package:flutter/material.dart';

class IncidencesPage extends StatefulWidget {
  const IncidencesPage({Key? key}) : super(key: key);

  @override
  State<IncidencesPage> createState() => _IncidencesPageState();
}

class _IncidencesPageState extends State<IncidencesPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constaints) {
          final count =
              constaints.maxWidth ~/ 200;
          return GridView.builder(
            padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              bottom: 20),
            physics: const BouncingScrollPhysics(),
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: count,
                childAspectRatio:
                200 / 200,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (_, index) {
              return Container(color: Colors.grey);
            },
            itemCount: 100,
          );
        });
  }
}
