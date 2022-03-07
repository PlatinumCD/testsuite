
set(CTEST_PROJECT_NAME "Trilinos")
set(CTEST_NIGHTLY_START_TIME "01:00:00 UTC")

set(CTEST_DROP_METHOD "https")
set(CTEST_DROP_SITE "cdash.e4s.io")
set(CTEST_DROP_LOCATION "/submit.php?project=Trilinos")
set(CTEST_DROP_SITE_CDASH TRUE)

IF ( NOT DEFINED CTEST_SITE )
    SET( CTEST_SITE "$ENV{CTEST_SITE_NAME}" )
ENDIF()
IF ( NOT DEFINED CTEST_SITE )
    SITE_NAME( HOSTNAME )
    SET( CTEST_SITE ${HOSTNAME} )
ENDIF()
site_name(CTEST_SITE)

IF ( NOT DEFINED CTEST_BUILD_NAME )
    SET( CTEST_BUILD_NAME "$ENV{CTEST_SUBMIT_NAME}" )
ENDIF()
IF ( NOT DEFINED CTEST_BUILD_NAME )
    SET( CTEST_BUILD_NAME ${CMAKE_HOST_SYSTEM_NAME} )
ENDIF()

set(CTEST_SOURCE_DIRECTORY "${CTEST_SCRIPT_DIRECTORY}")
set(CTEST_BINARY_DIRECTORY "${CTEST_SCRIPT_DIRECTORY}")
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
set(CTEST_CONFIGURATION_TYPE RelWithDebInfo)

ctest_start(Experimental)
ctest_test()
ctest_submit()
