# Cloud Tasks

[![gcp_cloud_tasks](https://github.com/Morel-Tech/gcp_cloud_tasks/actions/workflows/gcp_cloud_tasks.yaml/badge.svg?branch=main&event=push)](https://github.com/Morel-Tech/gcp_cloud_tasks/actions/workflows/gcp_cloud_tasks.yaml)
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

A small package to make interacting with Google Cloud Tasks easier.

## Usage

```dart
  final cloudTasks = await CloudTasks.defaultCredentials();
  final secret = await cloudTasks.createTask(
    queue: 'my-queue',
    location: 'us-central1',
    url: 'https://morel.technology',
  );
```

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
