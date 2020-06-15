if(WIN32)
    set( CMAKE_DEBUG_POSTFIX d )
endif()


MACRO( ADD_SHARED_LIBRARY_INTERNAL TRGTNAME )
    ADD_LIBRARY( ${TRGTNAME} SHARED ${ARGN} )
    IF( WIN32 )
        SET_TARGET_PROPERTIES( ${TRGTNAME} PROPERTIES DEBUG_POSTFIX d )
    ENDIF( WIN32 )
    SET_TARGET_PROPERTIES( ${TRGTNAME} PROPERTIES PROJECT_LABEL "Lib ${TRGTNAME}" )
ENDMACRO( ADD_SHARED_LIBRARY_INTERNAL TRGTNAME )

MACRO( ADD_OSGPLUGIN TRGTNAME )
    if( BUILD_SHARED_LIBS )
        add_library( ${TRGTNAME} MODULE ${ARGN} )
    else()
        add_library( ${TRGTNAME} STATIC ${ARGN} )
    endif()

    IF( WIN32 )
        #set( RELATIVE_LIB_PATH  ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/\${CMAKE_INSTALL_CONFIG_NAME}/ )
        SET_TARGET_PROPERTIES( ${TRGTNAME} PROPERTIES DEBUG_POSTFIX d )
    ENDIF( WIN32 )
    SET_TARGET_PROPERTIES( ${TRGTNAME} PROPERTIES PREFIX "" )
    SET_TARGET_PROPERTIES( ${TRGTNAME} PROPERTIES PROJECT_LABEL "Plugin ${TRGTNAME}" )

    link_internal( ${TRGTNAME}
        osgwQuery
        osgwControls
        osgwTools
        osgwMx
    )
    target_link_libraries( ${TRGTNAME}
        ${OSG_LIBRARIES}
    )
ENDMACRO( ADD_OSGPLUGIN TRGTNAME )


MACRO( MAKE_EXECUTABLE EXENAME )
    ADD_EXECUTABLE_INTERNAL( ${EXENAME}
        ${ARGN}
    )

    #if( WIN32 )
    #    set( RELATIVE_LIB_PATH ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/\${CMAKE_INSTALL_CONFIG_NAME}/ )
    #endif()

    LINK_INTERNAL( ${EXENAME}
        osgwQuery
        osgwControls
        osgwTools
        osgwMx
    )
    TARGET_LINK_LIBRARIES( ${EXENAME}
        ${OSG_LIBRARIES}
        ${OPENGL_gl_LIBRARY}
    )
    if( ${CATEGORY} STREQUAL "App" )
        install(
            TARGETS ${EXENAME}
            RUNTIME DESTINATION bin COMPONENT libosgworks
        )
    else()
        install(
            TARGETS ${EXENAME}
            RUNTIME DESTINATION share/${CMAKE_PROJECT_NAME}/bin COMPONENT libosgworks
        )
    endif()
    # Requires ${CATAGORY}
    SET_TARGET_PROPERTIES( ${EXENAME} PROPERTIES PROJECT_LABEL "${CATEGORY} ${EXENAME}" )
ENDMACRO( MAKE_EXECUTABLE EXENAME )

MACRO( ADD_EXECUTABLE_INTERNAL TRGTNAME )
    ADD_EXECUTABLE( ${TRGTNAME} ${ARGN} )
    IF( WIN32 )
        SET_TARGET_PROPERTIES( ${TRGTNAME} PROPERTIES DEBUG_POSTFIX d )
    ENDIF(WIN32)
ENDMACRO( ADD_EXECUTABLE_INTERNAL TRGTNAME )

macro( LINK_INTERNAL TRGTNAME )
    foreach( LINKLIB ${ARGN} )
        target_link_libraries( ${TRGTNAME} optimized "${LINKLIB}" debug "${LINKLIB}" )
    endforeach()
    target_link_libraries( ${TRGTNAME}
        ${OPENGL_gl_LIBRARY}
    )
endmacro()
