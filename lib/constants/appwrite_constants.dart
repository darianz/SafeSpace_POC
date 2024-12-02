class AppwriteConstants {
  static const String databaseId = '671b68e5003d9122b879';
  static const String projectId = '671b66d4000e879ea16d';
  static const String endPoint = 'http://10.0.2.2/v1';

  static const String usersCollection = '67277c04000cc2ff3aec';
  static const String tweetsCollection = '672e07bc00347e213ad7';
  static const String notificationsCollection = '67498bb90030fce20557';

  static const String imagesBucket = '672e4da80027cf0adf78';

  static String imageUrl(String imageId) =>
      '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}
