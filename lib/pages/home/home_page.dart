import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/custom_app_bar.dart';
import '../../constants/string_constants.dart';
import '../../controllers/home_controller.dart';
import 'widgets/actions_section.dart';
import 'widgets/animated_text_widget.dart';
import 'widgets/content_textfield_widget.dart';
import 'widgets/encrypt_section.dart';
import 'widgets/home_ad_widget.dart';
import 'widgets/side_drawer_widget.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  String? get tag => homeControllerTag;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'TextCrypt',
          toolbarHeight: 60,
          leadingIcon: Icons.menu,
          leadingOnTap: () => scaffoldKey.currentState?.openDrawer(),
        ),
        key: scaffoldKey,
        drawer: SideDrawerWidget(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Color(0xff1e1e1f),
          child: Column(
            children: [
              ActionsSection(),
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  padding: EdgeInsets.all(15),
                  color: Color(0xff171717),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedTextWidget(),
                      Flexible(
                        fit: FlexFit.tight,
                        child: ContentTextfieldWidget(),
                      ),
                    ],
                  ),
                ),
              ),
              EncryptSection(),
              HomeAdWidget(),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
            ],
          ),
        ),
      ),
    );
  }
}
