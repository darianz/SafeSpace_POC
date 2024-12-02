import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safe_space_01/common/error_page.dart';
import 'package:safe_space_01/common/loading_page.dart';
import 'package:safe_space_01/constants/appwrite_constants.dart';
import 'package:safe_space_01/features/auth/controller/auth_controller.dart';
import 'package:safe_space_01/features/notifications/controller/notification_controller.dart';
import 'package:safe_space_01/features/notifications/widgets/notification_tile.dart';
import 'package:safe_space_01/models/notification_model.dart' as model;

class NotificationView extends ConsumerWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserDetailsProvider).value!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: currentUser == null
          ? const Loader()
          : ref.watch(getNotificationsProvider(currentUser.uid)).when(
                data: (notifications) {
                  return ref.watch(getLatestNotificationProvider).when(
                        data: (data) {
                          if (data.events.contains(
                            'databases.*.collections.${AppwriteConstants.notificationsCollection}.documents.*.create',
                          )) {
                            final latestNotifications =
                                model.Notification.fromMap(data.payload);
                            if (latestNotifications.uid == currentUser.uid) {
                              notifications.insert(0, latestNotifications);
                            }
                          }

                          return ListView.builder(
                            itemCount: notifications.length,
                            itemBuilder: (BuildContext context, int index) {
                              final notification = notifications[index];
                              return NotificationTile(
                                notification: notification,
                              );
                            },
                          );
                        },
                        error: (error, stackTrace) =>
                            ErrorText(error: error.toString()),
                        loading: () {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: notifications.length,
                              itemBuilder: (BuildContext context, int index) {
                                final notification = notifications[index];
                                return NotificationTile(
                                  notification: notification,
                                );
                              },
                            ),
                          );
                        },
                      );
                },
                error: (error, stackTrace) =>
                    ErrorText(error: error.toString()),
                loading: () => const Loader(),
              ),
    );
  }
}
