// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import '../../../../imports.dart';
import '../login_controller.dart';

class FxLoginSliderMaster extends GetView<FxLoginController> {
  final Widget? child;
  final String? title;
  final Function? onBackPressed;
  const FxLoginSliderMaster({Key? key, this.child, this.title, this.onBackPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
          child: Column(
            children: [
              SizedBox(height: 8),
              Stack(
                children: [
                  if (onBackPressed != null)
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_rounded),
                        onPressed: onBackPressed as void Function()?,
                      ),
                    ),
                  Align(
                    alignment: Alignment.center,
                    heightFactor: 2,
                    child: Text(
                      title!,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              child!
            ],
          ),
        ));
  }
}
