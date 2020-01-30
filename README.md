# Installation

Application is using Carthage dependency management. Before compilation is necessary
download and rebuild this dependencies by following command:

`carthage bootstrap --platform ios --no-use-binaries --cache-builds`

For installation on physical device is necessary also change development team.

# Code structure

Application is divided into several independent units:

- AlphaVantage_Core contains definition of entities and use cases on business level. It should be platform independent.
- AlphaVantage_Core_iOS contains implementation of protocols defined in AlphaVantage_Core specific for iOS platform
- NovartisTest contains application it self for iOS platform.

# Limitations

At this moment missing only unit tests, which will be delivered during Thursday.