import 'package:cloud_tasks/cloud_tasks.dart';
import 'package:current_gcp_project/current_gcp_project.dart';
import 'package:googleapis/cloudtasks/v2.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockCurrentGcpProject extends Mock implements CurrentGcpProject {}

class MockAutoRefreshingAuthClient extends Mock
    implements AutoRefreshingAuthClient {}

class MockCloudTasksApi extends Mock implements CloudTasksApi {}

void main() {
  group('CloudTasks', () {
    test('can be instantiated', () {
      expect(CloudTasks(MockCloudTasksApi(), ''), isNotNull);
    });
    test('can be created with defaultCredentials', () async {
      final proj = MockCurrentGcpProject();
      when(proj.currentProjectId).thenAnswer((_) async => 'proj');

      expect(
        await CloudTasks.defaultCredentials(
          currentGcpProject: proj,
          clientGetter: ({
            required List<String> scopes,
            Client? baseClient,
          }) async =>
              MockAutoRefreshingAuthClient(),
        ),
        isA<CloudTasks>(),
      );
    });
  });
}
