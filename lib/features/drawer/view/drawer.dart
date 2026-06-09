import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_class/data/models/user_model.dart';
import 'package:todo_app_class/core/theme/theme_view_model.dart';
import 'package:todo_app_class/core/widgets/text_widgets.dart';
import 'package:todo_app_class/features/auth/view/sign_in_screen.dart';
import 'package:todo_app_class/features/drawer/view_model/custom_drawer_viewmodel.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final providerInstance = context.watch<CustomDrawerViewmodel>();
    return Drawer(
      child: StreamBuilder(
        stream: providerInstance.getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final UserModel user = snapshot.data!;
          return Column(
            children: [
              DrawerHeader(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  //color: Colors.grey.shade600,
                  child: Column(
                    children: [
                      //SizedBox(height: 70),
                      CircleAvatar(child: Icon(Icons.person)),
                      SizedBox(height: 15),
                      Text(user.name),
                      SizedBox(height: 8),
                      SmallText(
                        text: user.email,
                        myFontSize: 14,
                        myTextAlign: TextAlign.center,
                      ),
                      // SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    //color: Colors.grey.shade500
                  ),
                  width: double.infinity,

                  child: Column(
                    children: [
                      ListTile(
                        title: SmallText(text: 'Dark Theme'),
                        trailing: Consumer<ThemeProvider>(
                          builder: (ctx, value, child) => Icon(
                            value.isDark
                                ? Icons.toggle_on_outlined
                                : Icons.toggle_off_outlined,

                            size: 40,
                          ),
                        ),
                        onTap: () {
                          context.read<ThemeProvider>().toggleTheme();
                        },
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () async {
                          await providerInstance.signOut();
                          if (context.mounted) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              ),
                              (route) => false,
                            );
                          }
                        },
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SmallTextWhite(text: 'Logout'),
                            SizedBox(width: 10),
                            Icon(Icons.logout_outlined),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
