import 'package:appwrite_incidence/app/dependency_injection.dart';
import 'package:appwrite_incidence/generated/l10n.dart';
import 'package:appwrite_incidence/presentation/common/state_render/state_render_impl.dart';
import 'package:appwrite_incidence/presentation/main/pages_main/users/users_page.dart';
import 'package:appwrite_incidence/presentation/main/responsive.dart';
import 'package:appwrite_incidence/presentation/main/widgets_main/custom_search.dart';
import 'package:appwrite_incidence/presentation/main/widgets_main/drawer_main.dart';
import 'package:appwrite_incidence/presentation/resources/values_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'main_viewmodel.dart';
import 'pages_main/areas/areas_page.dart';
import 'pages_main/incidences/incidences_page.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _viewModel = instance<MainViewModel>();
  int _currentIndex = 0;
  List<Widget> pages = [
    const IncidencesPage(),
    const AreasPage(),
    const UsersPage('supervisors'),
    const UsersPage('employees')
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final s = S.of(context);
    return Scaffold(
        drawer: kIsWeb
            ? null
            : DrawerWidget(_currentIndex, changePage: _changePage),
        body: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) =>
                snapshot.data
                    ?.getScreenWidget(context, _getContentWidget(size, s), () {
                  _viewModel.inputState.add(ContentState());
                }, () {
                  //_viewModel.login(context);
                }) ??
                _getContentWidget(size, s)));
  }

  Widget _getContentWidget(Size size, S s) {
    return SafeArea(
      child: ResponsiveWid(
          largeScreen: Column(
            children: [
              const SizedBox(height: 10),
              _searchBar(size, large: true),
              const SizedBox(height: 5),
              const Divider(),
              Expanded(
                child: Row(
                  children: [
                    DrawerWidget(_currentIndex, changePage: _changePage),
                    Expanded(child: pages[_currentIndex])
                  ],
                ),
              ),
            ],
          ),
          smallScreen: Column(
            children: [
              const SizedBox(height: 10),
              _searchBar(size),
              const SizedBox(height: 5),
              const Divider(),
              Expanded(child: pages[_currentIndex])
            ],
          )),
    );
  }

  Widget _searchBar(Size size, {bool large = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              large
                  ? const SizedBox(
                      width: 310,
                      child: FlutterLogo(),
                    )
                  : IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {},
                    ),
              const SizedBox(width: AppSize.s5),
              GestureDetector(
                child: Container(
                  width: large ? size.width * 0.4 : size.width * 0.7,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(2, 2),
                            blurRadius: 8,
                            color: Colors.grey)
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.s20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(Icons.search),
                      const SizedBox(width: 10),
                      Text(
                          'Search ${_currentIndex == 0 ? 'incidences' : _currentIndex == 1 ? 'areas' : _currentIndex == 2 ? 'supervisors' : 'employees'}'),
                    ],
                  ),
                ),
                onTap: () {
                  showSearch(
                      context: context,
                      delegate: CustomSearch(_viewModel, _currentIndex));
                },
              ),
            ],
          ),
          IconButton(icon: const Icon(Icons.person), onPressed: () {}),
        ],
      ),
    );
  }

  _changePage(int index) {
    if (index == 4) {
      _viewModel.deleteSession(context);
    } else {
      _currentIndex = index;
      setState(() {});
    }
  }
}
