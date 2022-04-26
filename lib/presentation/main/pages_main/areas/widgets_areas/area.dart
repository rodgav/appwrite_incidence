import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/intl/generated/l10n.dart';
import 'package:appwrite_incidence/presentation/main/pages_main/areas/areas_viewmodel.dart';
import 'package:appwrite_incidence/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class AreaDialog extends StatefulWidget {
  final Area? area;
  final AreasViewModel viewModel;

  const AreaDialog({required this.viewModel,this.area, Key? key}) : super(key: key);

  @override
  State<AreaDialog> createState() => _AreaDialogState();
}

class _AreaDialogState extends State<AreaDialog> {
  final _nameTxtEditCtrl = TextEditingController();
  final _descrTxtEditCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final incidence = widget.area;
    if (incidence != null) {
      _nameTxtEditCtrl.text = incidence.name;
      _descrTxtEditCtrl.text = incidence.description;
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameTxtEditCtrl.dispose();
    _descrTxtEditCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s10)),
      elevation: 1,
      backgroundColor: Colors.white,
      child: SizedBox(
        width: AppSize.s250,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p14),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: AppSize.s10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${widget.area != null ? s.edit : s.add} ${s.area}'),
                      IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close))
                    ],
                  ),
                  const Divider(),
                  TextFormField(
                    controller: _nameTxtEditCtrl,
                    decoration: InputDecoration(
                        labelText: s.nameArea, hintText: s.nameArea),
                    validator: (value) =>
                        (value?.isNotEmpty ?? false) ? null : s.nameError,
                  ),
                  const SizedBox(height: AppSize.s10),
                  TextFormField(
                    controller: _descrTxtEditCtrl,
                    decoration: InputDecoration(
                        labelText: s.descriptionArea,
                        hintText: s.descriptionArea),
                    validator: (value) =>
                        (value?.isNotEmpty ?? false) ? null : s.descrError,
                  ),
                  const SizedBox(height: AppSize.s10),
                  _button(s),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _button(S s) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final area = Area(
                    name: _nameTxtEditCtrl.text.trim(),
                    description: _descrTxtEditCtrl.text.trim(),
                    read: [],
                    write: [],
                    id: widget.area?.id ?? '',
                    collection: '');
                if (widget.area != null) {
                  //update
                  widget.viewModel.updateArea(area, context);
                } else {
                  //save
                  widget.viewModel.createArea(area, context);
                }
              }
            },
            child: Text(s.save)));
  }
}
