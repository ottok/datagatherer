#!/bin/bash

# Script for running tests. That's for specifying just one argument in QtCreator's configuration
/usr/bin/tst-harbour-datagatherer -input /usr/share/tst-harbour-datagatherer

# When you'll get some QML components in the main app, you'll need to import them to the test run
# /usr/bin/tst-harbour-datagatherer -input /usr/share/tst-harbour-datagatherer -import /usr/share/harbour-datagatherer/qml/components