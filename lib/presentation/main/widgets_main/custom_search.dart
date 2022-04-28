import 'package:appwrite_incidence/app/dependency_injection.dart';
import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/domain/model/incidence_model.dart';
import 'package:appwrite_incidence/domain/model/user_model.dart';
import 'package:appwrite_incidence/presentation/global_widgets/area.dart';
import 'package:appwrite_incidence/presentation/global_widgets/incidence.dart';
import 'package:appwrite_incidence/presentation/global_widgets/user.dart';
import 'package:appwrite_incidence/presentation/main/main_viewmodel.dart';
import 'package:appwrite_incidence/presentation/main/pages_main/areas/areas_viewmodel.dart';
import 'package:appwrite_incidence/presentation/main/pages_main/areas/widgets_areas/area.dart';
import 'package:appwrite_incidence/presentation/main/pages_main/incidences/incidences_viewmodel.dart';
import 'package:appwrite_incidence/presentation/main/pages_main/incidences/widgets_incidence/incidence.dart';
import 'package:appwrite_incidence/presentation/main/pages_main/users/users_viewmodel.dart';
import 'package:appwrite_incidence/presentation/main/pages_main/users/widgets_users/user.dart';
import 'package:appwrite_incidence/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class CustomSearch extends SearchDelegate {
  final MainViewModel viewModel;
  final int index;

  CustomSearch(this.viewModel, this.index);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Limpiar',
        icon: const Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Cerrar',
      icon: const Icon(Icons.arrow_back_ios_rounded),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }
    if (index == 0) {
      viewModel.incidencesSearch(query.trim());
      return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.maxScrollExtent ==
                scrollInfo.metrics.pixels) {
              viewModel.incidencesSearch(query.trim());
            }
            return true;
          },
          child: Column(children: [
            StreamBuilder<List<Incidence>>(
                stream: viewModel.outputIncidencesSearch,
                builder: (_, snapshot) {
                  final incidences = snapshot.data;
                  return incidences != null
                      ? Expanded(
                          child: LayoutBuilder(builder: (context, constaints) {
                          final count = constaints.maxWidth ~/ AppSize.s200;
                          return GridView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: AppMargin.m6,
                                horizontal: AppMargin.m12),
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: count,
                                    childAspectRatio:
                                        AppSize.s200 / AppSize.s200,
                                    crossAxisSpacing: AppSize.s10,
                                    mainAxisSpacing: AppSize.s10),
                            itemBuilder: (_, index) {
                              final incidence = incidences[index];
                              return IncidenceItem(incidence, () {
                                final _viewModelInc =
                                    instance<IncidencesViewModel>();
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (_) => IncidenceDialog(
                                        incidence: incidence,
                                        viewModel: _viewModelInc,
                                        username: _viewModelInc.username));
                              });
                            },
                            itemCount: incidences.length,
                          );
                        }))
                      : const SizedBox();
                }),
            StreamBuilder<bool>(
                stream: viewModel.outputIsLoading,
                builder: (_, snapshot) {
                  final loading = snapshot.data;
                  return loading != null && loading
                      ? const CircularProgressIndicator()
                      : const SizedBox();
                })
          ]));
    } else if (index == 1) {
      viewModel.areasSearch(query.trim());
      return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.maxScrollExtent ==
                scrollInfo.metrics.pixels) {
              viewModel.areasSearch(query.trim());
            }
            return true;
          },
          child: Column(children: [
            StreamBuilder<List<Area>>(
                stream: viewModel.outputAreasSearch,
                builder: (_, snapshot) {
                  final areas = snapshot.data;
                  return areas != null
                      ? Expanded(
                          child: LayoutBuilder(builder: (context, constaints) {
                          final count = constaints.maxWidth ~/ AppSize.s200;
                          return GridView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: AppMargin.m6,
                                horizontal: AppMargin.m12),
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: count,
                                    childAspectRatio:
                                        AppSize.s200 / AppSize.s200,
                                    crossAxisSpacing: AppSize.s10,
                                    mainAxisSpacing: AppSize.s10),
                            itemBuilder: (_, index) {
                              final area = areas[index];
                              return AreaItem(area, () {
                                final _viewModelAre =
                                    instance<AreasViewModel>();
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (_) => AreaDialog(
                                        area: area, viewModel: _viewModelAre));
                              });
                            },
                            itemCount: areas.length,
                          );
                        }))
                      : const SizedBox();
                }),
            StreamBuilder<bool>(
                stream: viewModel.outputIsLoading,
                builder: (_, snapshot) {
                  final loading = snapshot.data;
                  return loading != null && loading
                      ? const CircularProgressIndicator()
                      : const SizedBox();
                })
          ]));
    } else {
      viewModel.usersSearch(query.trim());
      return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.maxScrollExtent ==
                scrollInfo.metrics.pixels) {
              viewModel.usersSearch(query.trim());
            }
            return true;
          },
          child: Column(children: [
            StreamBuilder<List<UsersModel>>(
                stream: viewModel.outputUsersSearch,
                builder: (_, snapshot) {
                  final users = snapshot.data;
                  return users != null
                      ? Expanded(
                          child: LayoutBuilder(builder: (context, constaints) {
                          final count = constaints.maxWidth ~/ AppSize.s200;
                          return GridView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: AppMargin.m6,
                                horizontal: AppMargin.m12),
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: count,
                                    childAspectRatio:
                                        AppSize.s200 / AppSize.s200,
                                    crossAxisSpacing: AppSize.s10,
                                    mainAxisSpacing: AppSize.s10),
                            itemBuilder: (_, index) {
                              final user = users[index];
                              return UserItem(user, () {
                                final _viewModelUse =
                                    instance<UsersViewModel>();
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (_) => UserDialog(
                                        users: user, viewModel: _viewModelUse));
                              });
                            },
                            itemCount: users.length,
                          );
                        }))
                      : const SizedBox();
                }),
            StreamBuilder<bool>(
                stream: viewModel.outputIsLoading,
                builder: (_, snapshot) {
                  final loading = snapshot.data;
                  return loading != null && loading
                      ? const CircularProgressIndicator()
                      : const SizedBox();
                })
          ]));
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }
}
