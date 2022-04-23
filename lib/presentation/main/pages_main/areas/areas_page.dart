import 'package:appwrite_incidence/app/dependency_injection.dart';
import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/generated/l10n.dart';
import 'package:appwrite_incidence/presentation/common/state_render/state_render_impl.dart';
import 'package:appwrite_incidence/presentation/main/pages_main/areas/areas_viewmodel.dart';
import 'package:appwrite_incidence/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class AreasPage extends StatefulWidget {
  const AreasPage({Key? key}) : super(key: key);

  @override
  State<AreasPage> createState() => _AreasPageState();
}

class _AreasPageState extends State<AreasPage> {
  final _viewModel = instance<AreasViewModel>();

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
          tooltip: s.addArea, child: const Icon(Icons.add), onPressed: () {}),
    );
  }

  Widget _getContentWidget(Size size, S s) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.maxScrollExtent == scrollInfo.metrics.pixels) {
          _viewModel.areas();
        }
        return true;
      },
      child: Column(
        children: [
          StreamBuilder<List<Area>>(
              stream: _viewModel.outputAreas,
              builder: (_, snapshot) {
                final users = snapshot.data;
                return users != null && users.isNotEmpty
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
                                  childAspectRatio: AppSize.s200 / AppSize.s200,
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
  }
}
