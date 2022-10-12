import 'dart:convert';

import 'package:current_gcp_project/current_gcp_project.dart';
import 'package:googleapis/cloudtasks/v2.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';

/// {@template cloud_tasks}
/// A wrapper around the [CloudTasksApi] that is easier to use.
/// {@endtemplate}
class CloudTasks {
  /// {@macro cloud_tasks}
  const CloudTasks(this._cloudTasksApi, this._projectId);

  /// /// Creates a new [CloudTasks] with
  /// [clientViaApplicationDefaultCredentials]
  static Future<CloudTasks> defaultCredentials({
    CurrentGcpProject currentGcpProject = const CurrentGcpProject(),
    Future<AutoRefreshingAuthClient> Function({
      required List<String> scopes,
      Client? baseClient,
    })
        clientGetter = clientViaApplicationDefaultCredentials,
  }) async {
    final client = await clientGetter(
      scopes: [
        CloudTasksApi.cloudPlatformScope,
      ],
    );
    final api = CloudTasksApi(client);
    final currentProjectId = await currentGcpProject.currentProjectId();
    return CloudTasks(api, currentProjectId!);
  }

  final CloudTasksApi _cloudTasksApi;
  final String _projectId;

  /// Creates a task and adds it to a queue.
  Future<Task> createTask({
    required String queue,
    required String location,
    required String url,
    String httpMethod = 'POST',
    Object? body,
    Map<String, String>? headers,
    OidcToken? oidcToken,
    OAuthToken? oAuthToken,
    String? taskId,
    DateTime? scheduleTime,
  }) {
    return _cloudTasksApi.projects.locations.queues.tasks.create(
      CreateTaskRequest(
        task: Task(
          httpRequest: HttpRequest(
            body: body != null ? jsonEncode(body) : null,
            headers: headers,
            url: url,
            httpMethod: httpMethod,
            oidcToken: oidcToken,
            oauthToken: oAuthToken,
          ),
          scheduleTime: scheduleTime?.toIso8601String(),
          name: taskId != null
              ? 'projects/$_projectId/locations/$location/queues/$queue/tasks/$taskId'
              : null,
        ),
      ),
      'projects/$_projectId/locations/$location/queues/$queue',
    );
  }
}
