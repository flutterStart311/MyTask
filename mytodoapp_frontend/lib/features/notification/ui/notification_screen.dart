import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytodoapp_frontend/contants/colors.dart';
import 'package:mytodoapp_frontend/features/notification/bloc/notification_bloc.dart';
import 'package:mytodoapp_frontend/models/notification.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationBloc _notificationBloc = NotificationBloc();

  bool isLoading = true;

  List<NotificationModel> allNotifications = [];

  @override
  void initState() {
    super.initState();
    _notificationBloc.add(FetchAllNotificationsEvent());
  }

  Future<void> updateReadStatus(String notificationID) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Notifications")
        .doc(notificationID)
        .update({
      'isRead': true,
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        centerTitle: true,
        title: Text(
          'Notifications',
          style: TextStyle(
            color: AppColors.accentColor,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            fontSize: 20,
          ),
        ),
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 45,
                width: 45,
                margin: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                  color: AppColors.accentColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocConsumer<NotificationBloc, NotificationState>(
        bloc: _notificationBloc,
        listener: (context, state) {
          if (state is NotificationsFetchingState) {
            isLoading = true;
          } else if (state is NotificationFetchingSuccessState) {
            isLoading = false;
            allNotifications = state.notifications;
          } else if (state is NotificationFetchingErrorState) {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Container(
            height: screenHeight - 120,
            width: screenWidth,
            color: Colors.white,
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Container(
                        width: screenWidth,
                        height: 1,
                        color: AppColors.accentColor,
                      ),
                      SizedBox(
                        height: screenHeight - 145,
                        width: screenWidth,
                        child: ListView.builder(
                          itemCount: allNotifications.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                await updateReadStatus(
                                    allNotifications[index].id);
                                _notificationBloc
                                    .add(FetchAllNotificationsEvent());
                              },
                              child: Container(
                                height: 60,
                                width: screenWidth,
                                color: allNotifications[index].isRead
                                    ? Colors.white
                                    : AppColors.readTileColor,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      allNotifications[index].title,
                                      style: TextStyle(
                                        color: AppColors.fontColorBlack,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      allNotifications[index].body,
                                      style: TextStyle(
                                        color: AppColors.dateTextColor,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
