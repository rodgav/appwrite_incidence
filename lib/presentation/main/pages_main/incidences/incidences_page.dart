import 'package:appwrite_incidence/app/dependency_injection.dart';
import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/domain/model/incidence_model.dart';
import 'package:appwrite_incidence/domain/model/incidence_sel.dart';
import 'package:appwrite_incidence/domain/model/name_model.dart';
import 'package:appwrite_incidence/generated/l10n.dart';
import 'package:appwrite_incidence/presentation/common/state_render/state_render_impl.dart';
import 'package:appwrite_incidence/presentation/main/pages_main/incidences/incidences_viewmodel.dart';
import 'package:appwrite_incidence/presentation/main/pages_main/incidences/widgets_incidence/incidence.dart';
import 'package:appwrite_incidence/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class IncidencesPage extends StatefulWidget {
  const IncidencesPage({Key? key}) : super(key: key);

  @override
  State<IncidencesPage> createState() => _IncidencesPageState();
}

class _IncidencesPageState extends State<IncidencesPage> {
  final _viewModel = instance<IncidencesViewModel>();

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
              }, () {
                //_viewModel.login(context);
              }) ??
              _getContentWidget(size, s)),
      floatingActionButton: FloatingActionButton(
          tooltip: s.addIncidence,
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => IncidenceDialog(
                    viewModel: _viewModel, username: _viewModel.username));
          }),
    );
  }

  Widget _getContentWidget(Size size, S s) {
    return StreamBuilder<IncidenceSel>(
        stream: _viewModel.outputIncidenceSel,
        builder: (_, snapshot) {
          final incidenceSel = snapshot.data;
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.maxScrollExtent ==
                  scrollInfo.metrics.pixels) {
                if (incidenceSel?.area != null && incidenceSel?.area != '') {
                  if (incidenceSel?.priority != null &&
                      incidenceSel?.priority == '') {
                    _viewModel.incidencesArea(incidenceSel?.area ?? '');
                  } else {
                    if (incidenceSel?.active == null) {
                      _viewModel.incidencesAreaPriority(
                          incidenceSel?.area ?? '',
                          incidenceSel?.priority ?? '');
                    } else {
                      _viewModel.incidencesAreaPriorityActive(
                          incidenceSel?.area ?? '',
                          incidenceSel?.priority ?? '',
                          incidenceSel?.active ?? false);
                    }
                  }
                }
              }
              return true;
            },
            child: Column(
              children: [
                _filter(s),
                StreamBuilder<List<Incidence>>(
                    stream: _viewModel.outputIncidences,
                    builder: (_, snapshot) {
                      final incidences = snapshot.data;
                      return incidences != null && incidences.isNotEmpty
                          ? Expanded(child:
                              LayoutBuilder(builder: (context, constaints) {
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
                          : Center(
                              child: Text(s.noData),
                            );
                    }),
                StreamBuilder<bool>(
                    stream: _viewModel.outputIsLoading,
                    builder: (_, snapshot) {
                      final loading = snapshot.data;
                      return loading != null && loading
                          ? const CircularProgressIndicator()
                          : const SizedBox();
                    })
              ],
            ),
          );
        });
  }

  Widget _filter(S s) {
    return StreamBuilder<IncidenceSel>(
        stream: _viewModel.outputIncidenceSel,
        builder: (_, snapshot) {
          final incidenceSel = snapshot.data;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: AppSize.s10),
              SizedBox(
                height: AppSize.s40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: AppSize.s20),
                    SizedBox(
                      width: AppSize.s140,
                      child: StreamBuilder<List<Area>>(
                          stream: _viewModel.outputAreas,
                          builder: (_, snapshot) {
                            final areas = snapshot.data;
                            return areas != null && areas.isNotEmpty
                                ? DropdownButtonFormField<String?>(
                                    decoration:
                                        InputDecoration(label: Text(s.area)),
                                    hint: Text(s.area),
                                    items: areas
                                        .map((e) => DropdownMenuItem(
                                              child: Text(e.name),
                                              value: e.name,
                                            ))
                                        .toList(),
                                    value: incidenceSel?.area == ''
                                        ? null
                                        : incidenceSel?.area,
                                    onChanged: (value) {
                                      _viewModel.changeIncidenceSel(
                                          IncidenceSel(
                                              area: value,
                                              priority: '',
                                              active: null));
                                    })
                                : const SizedBox();
                          }),
                    ),
                    const SizedBox(width: AppSize.s10),
                    incidenceSel?.area != null && incidenceSel?.area != ''
                        ? SizedBox(
                            width: AppSize.s140,
                            child: StreamBuilder<List<Name>>(
                                stream: _viewModel.outputPrioritys,
                                builder: (_, snapshot) {
                                  final prioritys = snapshot.data;
                                  return prioritys != null &&
                                          prioritys.isNotEmpty
                                      ? DropdownButtonFormField<String?>(
                                          decoration: InputDecoration(
                                              label: Text(s.priority)),
                                          hint: Text(s.priority),
                                          items: prioritys
                                              .map((e) => DropdownMenuItem(
                                                    child: Text(e.name),
                                                    value: e.name,
                                                  ))
                                              .toList(),
                                          value: incidenceSel?.priority == ''
                                              ? null
                                              : incidenceSel?.priority,
                                          onChanged: (value) {
                                            _viewModel.changeIncidenceSel(
                                                IncidenceSel(
                                                    area: incidenceSel?.area,
                                                    priority: value,
                                                    active: null));
                                          })
                                      : const SizedBox();
                                }),
                          )
                        : const SizedBox(),
                    const SizedBox(width: AppSize.s10),
                    SizedBox(
                      width: AppSize.s140,
                      child: StreamBuilder<List<bool>?>(
                          stream: _viewModel.outputActives,
                          builder: (_, snapshot) {
                            final actives = snapshot.data;
                            return actives != null && actives.isNotEmpty
                                ? DropdownButtonFormField<bool?>(
                                    decoration:
                                        InputDecoration(label: Text(s.active)),
                                    hint: Text(s.active),
                                    items: actives
                                        .map((e) => DropdownMenuItem(
                                              child: Text(e.toString()),
                                              value: e,
                                            ))
                                        .toList(),
                                    value: incidenceSel?.active,
                                    onChanged: (value) {
                                      _viewModel.changeIncidenceSel(
                                          IncidenceSel(
                                              area: incidenceSel?.area,
                                              priority: incidenceSel?.priority,
                                              active: value));
                                    })
                                : const SizedBox();
                          }),
                    ),
                    const SizedBox(width: AppSize.s20),
                  ],
                ),
              ),
              const SizedBox(height: AppSize.s10),
            ],
          );
        });
  }
}
