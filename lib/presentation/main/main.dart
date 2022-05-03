import 'package:appwrite_incidence/app/app_preferences.dart';
import 'package:appwrite_incidence/app/dependency_injection.dart';
import 'package:appwrite_incidence/domain/model/user_model.dart';
import 'package:appwrite_incidence/intl/generated/l10n.dart';
import 'package:appwrite_incidence/presentation/common/state_render/state_render_impl.dart';
import 'package:appwrite_incidence/presentation/main/pages_main/users/users_page.dart';
import 'package:appwrite_incidence/presentation/global_widgets/responsive.dart';
import 'package:appwrite_incidence/presentation/main/widgets_main/custom_search.dart';
import 'package:appwrite_incidence/presentation/main/widgets_main/drawer_main.dart';
import 'package:appwrite_incidence/presentation/resources/assets_manager.dart';
import 'package:appwrite_incidence/presentation/resources/color_manager.dart';
import 'package:appwrite_incidence/presentation/resources/language_manager.dart';
import 'package:appwrite_incidence/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

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
  final _appPreferences = instance<AppPreferences>();
  int _currentIndex = 0;
  List<Widget> pages = [
    const IncidencesPage(),
    const AreasPage(),
    const UsersPage()
  ];

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final s = S.of(context);
    return Scaffold(
        body: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) =>
                snapshot.data
                    ?.getScreenWidget(context, _getContentWidget(size, s), () {
                  _viewModel.inputState.add(ContentState());
                }, () {}) ??
                _getContentWidget(size, s)));
  }

  Widget _getContentWidget(Size size, S s) {
    return SafeArea(
      child: ResponsiveWid(
          largeScreen: Column(
            children: [
              const SizedBox(height: AppSize.s10),
              _searchBar(size, s, large: true),
              const SizedBox(height: AppSize.s5),
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
          smallScreen: Scaffold(
            drawer: DrawerWidget(_currentIndex,
                changePage: _changePage, small: true),
            body: Column(
              children: [
                const SizedBox(height: AppSize.s10),
                _searchBar(size, s),
                const SizedBox(height: AppSize.s5),
                const Divider(),
                Expanded(child: pages[_currentIndex])
              ],
            ),
          )),
    );
  }

  Widget _searchBar(Size size, S s, {bool large = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              large
                  ? SizedBox(
                      width: AppSize.s310,
                      height: AppSize.s40,
                      child: Image.asset(ImageAssets.logo),
                    )
                  : IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {},
                    ),
              const SizedBox(width: AppSize.s5),
              GestureDetector(
                child: Container(
                  width: large ? size.width * 0.4 : size.width * 0.7,
                  height: AppSize.s40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(AppSize.s2, AppSize.s2),
                            blurRadius: AppSize.s8,
                            color: Colors.grey)
                      ],
                      borderRadius: BorderRadius.circular(AppSize.s20)),
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.s20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(Icons.search),
                      const SizedBox(width: AppSize.s10),
                      Text('${s.search} '
                          '${_currentIndex == 0 ? s.incidences.toLowerCase() : _currentIndex == 1 ? s.areas.toLowerCase() : s.users.toLowerCase()}'),
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
          SizedBox(
            width: AppSize.s60,
            child: PopupMenuButton<String>(
              tooltip: s.changeLanguage,
              itemBuilder: (_) => LanguageType.values
                  .map((e) =>
                  PopupMenuItem(child: Text(e.name), value: e.getValue()))
                  .toList(),
              child: Center(
                  child: Text(
                    _appPreferences.getAppLanguage(),
                    style: Theme.of(context).textTheme.bodyText2,
                  )),
              onSelected: (value) {
                _appPreferences.setAppLanguage(value);
                Phoenix.rebirth(context);
              },
            ),
          ),
          const SizedBox(width: AppSize.s10),
          StreamBuilder<UsersModel>(
              stream: _viewModel.outputUser,
              builder: (_, snapshot) {
                final user = snapshot.data;
                return SizedBox(
                  width: AppSize.s60,
                  child: PopupMenuButton<String>(
                      tooltip: user?.name ?? s.user,
                      itemBuilder: (_) => [
                        PopupMenuItem(
                          padding: const EdgeInsets.symmetric(
                              vertical: AppPadding.p10, horizontal: 40),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${s.user}: ${user?.name ?? s.user}'),
                              Text(
                                  '${s.typeUser}: ${user?.typeUser ?? s.typeUser}'),
                              Text(
                                  '${s.active}: ${user?.active ?? s.active}'),
                              Text('${s.area}: ${user?.area ?? s.area}'),
                            ],
                          ),
                        )
                      ],
                      icon: Icon(Icons.person, color: ColorManager.black)),
                );
              }),
          const SizedBox(width: AppSize.s10)
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
