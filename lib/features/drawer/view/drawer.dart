import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_class/core/theme/theme_view_model.dart';
import 'package:todo_app_class/core/widgets/text_widgets.dart';
import 'package:todo_app_class/features/auth/view/sign_in_screen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late Stream<DocumentSnapshot> _userStream;

  @override
  void initState() {
    super.initState();
    _userStream = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots();
  }

  final String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: StreamBuilder(
        stream: _userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          Map<String, dynamic> userData =
              snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                color: Colors.grey.shade600,
                child: Column(
                  children: [
                    SizedBox(height: 70),
                    CircleAvatar(child: Icon(Icons.person)),
                    SizedBox(height: 20),
                    SmallTextWhite(text: userData['name']),
                    SizedBox(height: 12),
                    SmallTextWhite(text: userData['email'], myFontSize: 15),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey.shade500),
                  width: double.infinity,

                  child: Column(
                    children: [
                      ListTile(
                        title: SmallTextWhite(text: 'Dark Theme'),
                        trailing: Consumer<ThemeProvider>(
                          builder: (ctx, value, child) => Icon(
                            ctx.watch<ThemeProvider>().isDark
                                ? Icons.toggle_on_outlined
                                : Icons.toggle_off_outlined,
                            color: Colors.white,
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
                          await FirebaseAuth.instance.signOut().then(
                            (value) => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              ),
                              (route) => false,
                            ),
                          );

                          //Navigator.pop(context);
                        },
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SmallTextWhite(text: 'Logout'),
                            SizedBox(width: 10),
                            Icon(Icons.logout_outlined, color: Colors.white),
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
