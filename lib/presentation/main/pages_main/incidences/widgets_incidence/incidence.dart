import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/domain/model/incidence_model.dart';
import 'package:appwrite_incidence/domain/model/incidence_sel.dart';
import 'package:appwrite_incidence/domain/model/name_model.dart';
import 'package:appwrite_incidence/intl/generated/l10n.dart';
import 'package:appwrite_incidence/presentation/main/pages_main/incidences/incidences_viewmodel.dart';
import 'package:appwrite_incidence/presentation/resources/color_manager.dart';
import 'package:appwrite_incidence/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class IncidenceDialog extends StatefulWidget {
  final Incidence? incidence;
  final IncidencesViewModel viewModel;
  final String username;

  const IncidenceDialog({this.incidence, required this.viewModel,required this.username, Key? key})
      : super(key: key);

  @override
  State<IncidenceDialog> createState() => _IncidenceDialogState();
}

class _IncidenceDialogState extends State<IncidenceDialog> {
  final _nameTxtEditCtrl = TextEditingController();
  final _descrTxtEditCtrl = TextEditingController();
  final _dateCreateTxtEditCtrl = TextEditingController();
  final _employeTxtEditCtrl = TextEditingController();
  final _supervisorTxtEditCtrl = TextEditingController();
  final _solutionTxtEditCtrl = TextEditingController();
  final _dateSolutionTxtEditCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final incidence = widget.incidence;
    if (incidence != null) {
      _nameTxtEditCtrl.text = incidence.name;
      _descrTxtEditCtrl.text = incidence.description;
      _dateCreateTxtEditCtrl.text = (incidence.dateCreate).toString();
      _employeTxtEditCtrl.text = incidence.employe;
      _supervisorTxtEditCtrl.text = incidence.supervisor;
      _solutionTxtEditCtrl.text = incidence.solution;
      _dateSolutionTxtEditCtrl.text = (incidence.dateSolution).toString();
      widget.viewModel.changeIncidenceSelIncidence(IncidenceSel(
          area: incidence.area,
          priority: incidence.priority,
          active: incidence.active));
    } else {
      _dateCreateTxtEditCtrl.text = (DateTime.now()).toString();
      _dateSolutionTxtEditCtrl.text = (DateTime.now()).toString();
      _employeTxtEditCtrl.text = widget.username;
      _supervisorTxtEditCtrl.text = widget.username;
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameTxtEditCtrl.dispose();
    _descrTxtEditCtrl.dispose();
    _dateCreateTxtEditCtrl.dispose();
    _employeTxtEditCtrl.dispose();
    _supervisorTxtEditCtrl.dispose();
    _solutionTxtEditCtrl.dispose();
    _dateSolutionTxtEditCtrl.dispose();
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
                      Text(
                          '${widget.incidence != null ? s.edit : s.add} ${s.incidence}'),
                      IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close))
                    ],
                  ),
                  const Divider(),
                  TextFormField(
                    controller: _nameTxtEditCtrl,
                    decoration: InputDecoration(
                        labelText: s.nameIncidence, hintText: s.nameIncidence),
                    validator: (value) =>
                        (value?.isNotEmpty ?? false) ? null : s.nameError,
                  ),
                  const SizedBox(height: AppSize.s10),
                  TextFormField(
                    controller: _descrTxtEditCtrl,
                    decoration: InputDecoration(
                        labelText: s.descriptionIncidence,
                        hintText: s.descriptionIncidence),
                    validator: (value) =>
                        (value?.isNotEmpty ?? false) ? null : s.descrError,
                  ),
                  const SizedBox(height: AppSize.s10),
                  TextFormField(
                    controller: _dateCreateTxtEditCtrl,
                    decoration: InputDecoration(
                        labelText: s.dateCreate, hintText: s.dateCreate),
                    enabled: false,
                  ),
                  const SizedBox(height: AppSize.s10),
                  TextFormField(
                    controller: _employeTxtEditCtrl,
                    decoration: InputDecoration(
                        labelText: s.employe, hintText: s.employe),
                    validator: (value) =>
                        (value?.isNotEmpty ?? false) ? null : s.employeError,
                  ),
                  const SizedBox(height: AppSize.s10),
                  TextFormField(
                    controller: _supervisorTxtEditCtrl,
                    decoration: InputDecoration(
                        labelText: s.supervisor, hintText: s.supervisor),
                    validator: (value) =>
                        (value?.isNotEmpty ?? false) ? null : s.supervisorError,
                  ),
                  const SizedBox(height: AppSize.s10),
                  TextFormField(
                    controller: _solutionTxtEditCtrl,
                    decoration: InputDecoration(
                        labelText: s.solution, hintText: s.solution),
                    validator: (value) =>
                        (value?.isNotEmpty ?? false) ? null : s.solutionError,
                  ),
                  const SizedBox(height: AppSize.s10),
                  TextFormField(
                    controller: _dateSolutionTxtEditCtrl,
                    decoration: InputDecoration(
                        labelText: s.dateSolution, hintText: s.dateSolution),
                    enabled: false,
                  ),
                  const SizedBox(height: AppSize.s10),
                  _incidenceSelWid(s),
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

  Widget _incidenceSelWid(S s) {
    return StreamBuilder<IncidenceSel>(
        stream: widget.viewModel.outputIncidenceSelIncidence,
        builder: (_, snapshot) {
          final incidenceSel = snapshot.data;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StreamBuilder<List<Area>>(
                  stream: widget.viewModel.outputAreas,
                  builder: (_, snapshot) {
                    final areas = snapshot.data;
                    return areas != null && areas.isNotEmpty
                        ? DropdownButtonFormField<String?>(
                            decoration: InputDecoration(label: Text(s.area)),
                            hint: Text(s.area),
                            items: areas
                                .map((e) => DropdownMenuItem(
                                      child: Text(e.name),
                                      value: e.name,
                                    ))
                                .toList(),
                            value: incidenceSel?.area != ''
                                ? incidenceSel?.area
                                : null,
                            onChanged: (value) {
                              _changeIncidenceSel(IncidenceSel(
                                  area: value,
                                  priority: incidenceSel?.priority,
                                  active: incidenceSel?.active));
                            },
                            validator: (value) => (value?.isNotEmpty ?? false)
                                ? null
                                : s.areaError,
                          )
                        : const SizedBox();
                  }),
              const SizedBox(height: AppSize.s10),
              StreamBuilder<List<Name>>(
                  stream: widget.viewModel.outputPrioritys,
                  builder: (_, snapshot) {
                    final prioritys = snapshot.data;
                    return prioritys != null && prioritys.isNotEmpty
                        ? DropdownButtonFormField<String?>(
                            decoration:
                                InputDecoration(label: Text(s.priority)),
                            hint: Text(s.priority),
                            items: prioritys
                                .map((e) => DropdownMenuItem(
                                      child: Text(e.name),
                                      value: e.name,
                                    ))
                                .toList(),
                            value: incidenceSel?.priority != ''
                                ? incidenceSel?.priority
                                : null,
                            onChanged: (value) {
                              _changeIncidenceSel(IncidenceSel(
                                  area: incidenceSel?.area,
                                  priority: value,
                                  active: incidenceSel?.active));
                            },
                            validator: (value) => (value?.isNotEmpty ?? false)
                                ? null
                                : s.priorityError,
                          )
                        : const SizedBox();
                  }),
              const SizedBox(height: AppSize.s10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(s.active),
                  Checkbox(
                      activeColor: ColorManager.primary,
                      value: incidenceSel?.active ?? false,
                      onChanged: (value) {
                        _changeIncidenceSel(IncidenceSel(
                            area: incidenceSel?.area,
                            priority: incidenceSel?.priority,
                            active: value));
                      })
                ],
              )
            ],
          );
        });
  }

  _changeIncidenceSel(IncidenceSel incidenceSel) {
    widget.viewModel.changeIncidenceSelIncidence(incidenceSel);
  }

  Widget _button(S s) {
    return StreamBuilder<IncidenceSel>(
        stream: widget.viewModel.outputIncidenceSelIncidence,
        builder: (_, snapshot) {
          final incidenceSel = snapshot.data;
          return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final incidence = Incidence(
                          name: _nameTxtEditCtrl.text.trim(),
                          description: _descrTxtEditCtrl.text.trim(),
                          dateCreate:
                              DateTime.parse(_dateCreateTxtEditCtrl.text),
                          image: 'image',
                          priority: incidenceSel?.priority ?? '',
                          area: incidenceSel?.area ?? '',
                          employe: _employeTxtEditCtrl.text.trim(),
                          supervisor: _supervisorTxtEditCtrl.text.trim(),
                          solution: _solutionTxtEditCtrl.text.trim(),
                          dateSolution: _dateSolutionTxtEditCtrl.text != 'null'
                              ? DateTime.parse(_dateSolutionTxtEditCtrl.text)
                              : DateTime.now(),
                          active: incidenceSel?.active ?? false,
                          read: [],
                          write: [],
                          id: widget.incidence?.id??'',
                          collection: '');
                      if (widget.incidence != null) {
                        //update
                        widget.viewModel.updateIncidence(incidence, context);
                      } else {
                        //save
                        widget.viewModel.createIncidence(incidence, context);
                      }
                    }
                  },
                  child: Text(s.save)));
        });
  }
}
