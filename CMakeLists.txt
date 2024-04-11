cmake_minimum_required(VERSION 3.16)

project(Analog VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appAnalog
    main.cpp
)

qt_add_qml_module(appAnalog
    URI Analog
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES Clock.qml
        QML_FILES Hour.qml
        QML_FILES Minute.qml
        QML_FILES Second.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appAnalog PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appAnalog
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appAnalog
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appAnalog
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
