configure_lit_site_cfg(
        ${CMAKE_CURRENT_SOURCE_DIR}/lit.site.cfg.py.in
        ${CMAKE_CURRENT_BINARY_DIR}/lit.site.cfg.py
        MAIN_CONFIG
        ${CMAKE_CURRENT_SOURCE_DIR}/lit.cfg.py
)

set(EQUEUE_OPT_TEST_DEPENDS
        FileCheck count not
        equeue-opt
        )

add_lit_testsuite(check-equeue-opt "Running the equeue-opt regression tests"
        ${CMAKE_CURRENT_BINARY_DIR}
        DEPENDS ${EQUEUE_OPT_TEST_DEPENDS}
        )
set_target_properties(check-equeue-opt PROPERTIES FOLDER "Tests")

add_lit_testsuites(EQUEUE_OPT ${CMAKE_CURRENT_SOURCE_DIR} DEPENDS ${EQUEUE_OPT_TEST_DEPENDS})
