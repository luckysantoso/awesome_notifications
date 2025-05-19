import 'package:study_firebase_v2/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_firebase_v2/services/notification_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void logout(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, 'login');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Notifikasi Demo'),
              centerTitle: true,
              backgroundColor: Colors.teal.shade600,
              foregroundColor: Colors.white,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Selamat datang, ${snapshot.data?.email}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.2,
                      children: [
                        _notifButton(
                          context,
                          icon: Icons.notifications_active,
                          label: 'Default',
                          color: Colors.teal,
                          onPressed:
                              () => NotificationService.createNotification(
                                id: 1,
                                title: 'Default Notification',
                                body: 'This is the body of the notification',
                                summary: 'Small summary',
                              ),
                        ),
                        _notifButton(
                          context,
                          icon: Icons.list_alt_rounded,
                          label: 'Inbox',
                          color: Colors.blue,
                          onPressed:
                              () => NotificationService.createNotification(
                                id: 2,
                                title: 'Notification with Summary',
                                body: 'This is the body of the notification',
                                summary: 'Small summary',
                                notificationLayout: NotificationLayout.Inbox,
                              ),
                        ),
                        _notifButton(
                          context,
                          icon: Icons.linear_scale_rounded,
                          label: 'Progress',
                          color: Colors.orange,
                          onPressed:
                              () => NotificationService.createNotification(
                                id: 3,
                                title: 'Progress Bar Notification',
                                body: 'This is the body of the notification',
                                summary: 'Small summary',
                                notificationLayout:
                                    NotificationLayout.ProgressBar,
                              ),
                        ),
                        _notifButton(
                          context,
                          icon: Icons.message_rounded,
                          label: 'Message',
                          color: Colors.purple,
                          onPressed:
                              () => NotificationService.createNotification(
                                id: 4,
                                title: 'Message Notification',
                                body: 'This is the body of the notification',
                                summary: 'Small summary',
                                notificationLayout:
                                    NotificationLayout.Messaging,
                              ),
                        ),
                        _notifButton(
                          context,
                          icon: Icons.image,
                          label: 'Big Image',
                          color: Colors.green,
                          onPressed:
                              () => NotificationService.createNotification(
                                id: 5,
                                title: 'Big Image Notification',
                                body: 'This is the body of the notification',
                                summary: 'Small summary',
                                notificationLayout:
                                    NotificationLayout.BigPicture,
                                bigPicture: 'https://picsum.photos/300/200',
                              ),
                        ),
                        _notifButton(
                          context,
                          icon: Icons.touch_app_rounded,
                          label: 'Action Button',
                          color: Colors.amber,
                          onPressed:
                              () => NotificationService.createNotification(
                                id: 6,
                                title: 'Action Button Notification',
                                body: 'This is the body of the notification',
                                payload: {'navigate': 'true'},
                                actionButtons: [
                                  NotificationActionButton(
                                    key: 'SECOND_SCREEN',
                                    label: 'Go to Second Screen',
                                    actionType: ActionType.Default,
                                    autoDismissible: true,
                                  ),
                                ],
                              ),
                        ),
                        _notifButton(
                          context,
                          icon: Icons.schedule,
                          label: 'Scheduled',
                          color: Colors.indigo,
                          onPressed:
                              () => NotificationService.createNotification(
                                id: 7,
                                title: 'Scheduled Notification',
                                body: 'This is the body of the notification',
                                scheduled: true,
                                interval: const Duration(seconds: 5),
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () => logout(context),
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const LoginScreen();
        }
      },
    );
  }

  Widget _notifButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 4,
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32),
          const SizedBox(height: 10),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
