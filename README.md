# Minify Link

This project is a sample for a clean architecture model in my perspective

#### Please, if you are read this repository, give me feedback about my code. This help me to improve. Thank you

E-mail: felipe-not@hotmail.com
Or open an issue into this repo, thanks.

### Requirements

For run unit tests, this project need the 8080 port is free to use.
Please on build specify the profile with `--dart-define=PROFILE=dev`

### Libs

- [get_it](https://pub.dev/packages/get_it)
    - Lib for dependency injection
- [Dio](https://pub.dev/packages/dio)
    - Lib used to make HTTP requests
- [pretty_dio_logger](https://pub.dev/packages/pretty_dio_logger)
    - Lib for print logs of requests
- [mockserver](https://pub.dev/packages/mockserver)
    - Lib for create a fake server to test some endpoints
- [mockito](https://pub.dev/packages/mockito)
    - Lib for create mocked objects
- [build_runner](https://pub.dev/packages/build_runner)
    - The build_runner is used to generate some codes from annotations in project.
- [dartz](https://pub.dev/packages/dartz)
    - The dartz library is use for make some functional programming in project, like Error Handing
- [equatable](https://pub.dev/packages/equatable)
    - This Lib is to add ways to check if the objects are the same
- [logger](https://pub.dev/packages/logger)
    - Lib for centralize logs
- [url_launcher](https://pub.dev/packages/url_launcher)
    - Lib for open a link