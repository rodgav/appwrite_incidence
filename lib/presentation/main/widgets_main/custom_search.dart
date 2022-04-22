import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/domain/model/incidence_model.dart';
import 'package:appwrite_incidence/domain/model/user_model.dart';
import 'package:appwrite_incidence/presentation/main/main_viewmodel.dart';
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
        icon: const Icon(Icons.clear),
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
      icon: const Icon(Icons.close),
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
                              return Container(color: Colors.grey);
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
                              return Container(color: Colors.grey);
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
    } else if (index == 2) {
      viewModel.usersSearch(query.trim(), 'supervisors');
      return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.maxScrollExtent ==
                scrollInfo.metrics.pixels) {
              viewModel.usersSearch(query.trim(), 'supervisors');
            }
            return true;
          },
          child: Column(children: [
            StreamBuilder<List<Users>>(
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
                              return Container(color: Colors.grey);
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
    } else if (index == 3) {
      viewModel.usersSearch(query.trim(), 'employees');
      return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.maxScrollExtent ==
                scrollInfo.metrics.pixels) {
              viewModel.usersSearch(query.trim(), 'employees');
            }
            return true;
          },
          child: Column(children: [
            StreamBuilder<List<Users>>(
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
                              return Container(color: Colors.grey);
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
    } else {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(AppSize.s10),
          child: Text('No data'),
        ),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column(
      children: const [Text('Suggestions')],
    );
  }
}
