import 'package:appwrite_incidence/app/dependency_injection.dart';
import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/domain/model/user_model.dart';
import 'package:appwrite_incidence/domain/model/user_sel.dart';
import 'package:appwrite_incidence/generated/l10n.dart';
import 'package:appwrite_incidence/presentation/common/state_render/state_render_impl.dart';
import 'package:appwrite_incidence/presentation/main/pages_main/users/users_viewmodel.dart';
import 'package:appwrite_incidence/presentation/main/pages_main/users/widgets_users/user.dart';
import 'package:appwrite_incidence/presentation/resources/strings_manager.dart';
import 'package:appwrite_incidence/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  final String typeUser;

  const UsersPage(this.typeUser, {Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final _viewModel = instance<UsersViewModel>();

  _bind() {
    _viewModel.start();
    _viewModel.users(widget.typeUser);
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
          tooltip:
              '${s.add} ${widget.typeUser == AppStrings.employe ? s.employe : s.supervisor}',
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => UserDialog(viewModel: _viewModel));
          }),
    );
  }

  Widget _getContentWidget(Size size, S s) {
    return StreamBuilder<UserSel>(
        stream: _viewModel.outputUserSel,
        builder: (_, snapshot) {
          final userSel = snapshot.data;
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.maxScrollExtent ==
                  scrollInfo.metrics.pixels) {
                if (userSel?.area != null && userSel?.area != '') {
                  if (userSel?.active == null) {
                    _viewModel.usersArea(widget.typeUser, userSel?.area ?? '');
                  } else {
                    _viewModel.usersAreaActive(widget.typeUser,
                        userSel?.area ?? '', userSel?.active ?? false);
                  }
                }
              }
              return true;
            },
            child: Column(
              children: [
                _filter(s),
                StreamBuilder<List<Users>>(
                    stream: _viewModel.outputUsers,
                    builder: (_, snapshot) {
                      final users = snapshot.data;
                      return users != null && users.isNotEmpty
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
                                  final user = users[index];
                                  return Container(color: Colors.grey);
                                },
                                itemCount: users.length,
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
    return StreamBuilder<UserSel>(
        stream: _viewModel.outputUserSel,
        builder: (_, snapshot) {
          final userSel = snapshot.data;
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
                                    value: userSel?.area == ''
                                        ? null
                                        : userSel?.area,
                                    onChanged: (value) {
                                      _viewModel.changeUserSel(
                                          UserSel(area: value, active: null),
                                          widget.typeUser);
                                    })
                                : const SizedBox();
                          }),
                    ),
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
                                    value: userSel?.active,
                                    onChanged: (value) {
                                      _viewModel.changeUserSel(
                                          UserSel(
                                              area: userSel?.area,
                                              active: value),
                                          widget.typeUser);
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
