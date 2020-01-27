# Installation

Application is using Carthage dependency management. Before compilation is necessary
download and rebuild this dependencies by following command:

`carthage update --platform ios --no-use-binaries --cache-builds`

For installation on physical device is necessary also change development team.

# Limitations

Because of limited time I was not able to deliver complete solution. Current solution
has following limitations:

- not implemented support for comparing two different securities
- unit tests are not implemented
- current implementation does not correctly forcing rotation of detail view with list
of trades.