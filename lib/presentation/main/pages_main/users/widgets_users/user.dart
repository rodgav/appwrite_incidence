import 'package:appwrite/models.dart';
import 'package:appwrite_incidence/domain/model/area_model.dart';
import 'package:appwrite_incidence/domain/model/name_model.dart';
import 'package:appwrite_incidence/domain/model/user_model.dart';
import 'package:appwrite_incidence/domain/model/user_sel.dart';
import 'package:appwrite_incidence/generated/l10n.dart';
import 'package:appwrite_incidence/presentation/main/pages_main/users/users_viewmodel.dart';
import 'package:appwrite_incidence/presentation/resources/color_manager.dart';
import 'package:appwrite_incidence/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class UserDialog extends StatefulWidget {
  final Users? users;
  final UsersViewModel viewModel;

  const UserDialog({this.users, required this.viewModel, Key? key})
      : super(key: key);

  @override
  State<UserDialog> createState() => _UserDialogState();
}

class _UserDialogState extends State<UserDialog> {
  final _nameTxtEditCtrl = TextEditingController();
  final _emailTxtEditCtrl = TextEditingController();
  final _passwordTxtEditCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final users = widget.users;
    if (users != null) {
      _nameTxtEditCtrl.text = users.name;
      _emailTxtEditCtrl.text = '***************';
      _passwordTxtEditCtrl.text = '***************';
      widget.viewModel.changeUserSelUser(UserSel(
          area: users.area, typeUser: users.typeUser, active: users.active));
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameTxtEditCtrl.dispose();
    _emailTxtEditCtrl.dispose();
    _passwordTxtEditCtrl.dispose();
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
                          '${widget.users != null ? s.edit : s.add} ${s.user}'),
                      IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close))
                    ],
                  ),
                  const Divider(),
                  TextFormField(
                    controller: _nameTxtEditCtrl,
                    decoration: InputDecoration(
                        labelText: s.nameUser, hintText: s.nameUser),
                    validator: (value) =>
                    (value?.isNotEmpty ?? false) ? null : s.nameError,
                  ),
                  const SizedBox(height: AppSize.s10),
                  TextFormField(
                    controller: _emailTxtEditCtrl,
                    decoration: InputDecoration(
                        labelText: s.email,
                        hintText: s.email),
                    validator: (value) =>
                    (value?.isNotEmpty ?? false) ? null : s.emailError,
                  ),
                  const SizedBox(height: AppSize.s10),
                  TextFormField(
                    controller: _passwordTxtEditCtrl,obscureText: true,
                    decoration: InputDecoration(
                        labelText: s.password, hintText: s.password),
                    validator: (value) =>
                    (value?.isNotEmpty ?? false) ? null : s.passwordError,
                  ),
                  const SizedBox(height: AppSize.s10),
                  _userSelWid(s),
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
  Widget _userSelWid(S s){
    return StreamBuilder<UserSel>(
        stream: widget.viewModel.outputUserSelUser,
        builder: (_, snapshot) {
          final userSel = snapshot.data;
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
                      value: userSel?.area != ''
                          ? userSel?.area
                          : null,
                      onChanged: (value) {
                        _changeUserSel(UserSel(
                            area: value,
                            typeUser: userSel?.typeUser,
                            active: userSel?.active));
                      },
                      validator: (value) => (value?.isNotEmpty ?? false)
                          ? null
                          : s.areaError,
                    )
                        : const SizedBox();
                  }),
              const SizedBox(height: AppSize.s10),
              StreamBuilder<List<Name>>(
                  stream: widget.viewModel.outputTypeUsers,
                  builder: (_, snapshot) {
                    final prioritys = snapshot.data;
                    return prioritys != null && prioritys.isNotEmpty
                        ? DropdownButtonFormField<String?>(
                      decoration:
                      InputDecoration(label: Text(s.typeUser)),
                      hint: Text(s.typeUser),
                      items: prioritys
                          .map((e) => DropdownMenuItem(
                        child: Text(e.name),
                        value: e.name,
                      ))
                          .toList(),
                      value: userSel?.typeUser != ''
                          ? userSel?.typeUser
                          : null,
                      onChanged: (value) {
                        _changeUserSel(UserSel(
                            area: userSel?.area,
                            typeUser: value,
                            active: userSel?.active));
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
                      value: userSel?.active ?? false,
                      onChanged: (value) {
                        _changeUserSel(UserSel(
                            area: userSel?.area,
                            typeUser: userSel?.typeUser,
                            active: value));
                      })
                ],
              )
            ],
          );
        });
  }

  Widget _button(S s) {
    return StreamBuilder<UserSel>(
        stream: widget.viewModel.outputUserSelUser,
        builder: (_, snapshot) {
          final incidenceSel = snapshot.data;
          return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.users != null) {
                        //update
                        //widget.viewModel.updateIncidence(incidence, context);
                      } else {
                        //save
                        //widget.viewModel.createIncidence(incidence, context);
                      }
                    }
                  },
                  child: Text(s.save)));
        });
  }

  _changeUserSel(UserSel userSel) {
    widget.viewModel.changeUserSelUser(userSel);
  }
}
