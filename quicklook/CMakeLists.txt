# SPDX-License-Identifier: GPL-3.0-only
# MuseScore-Studio-CLA-applies
#
# MuseScore Studio
# Music Composition & Notation
#
# Copyright (C) 2024 MuseScore Limited
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 3 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

if(NOT OS_IS_MAC)
    return()
endif()

# Create a custom target for Swift Package Manager build
add_custom_target(swift_package_build
    COMMAND swift package resolve
    COMMAND swift build
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    COMMENT "Building Swift Package Manager dependencies"
)

# QuickLook Preview Provider Extension
add_custom_target(MuseScoreQLPreviewProvider ALL
    DEPENDS swift_package_build
    COMMENT "Installing MuseScoreQLPreviewProvider.appex"
)

# Thumbnail Provider Extension
# add_custom_target(MuseScoreThumbnailProvider ALL
    # DEPENDS swift_package_build
    # COMMENT "Installing MuseScoreThumbnailProvider.appex"
# )

# Install targets
install(CODE "
    # Create directory structure
    file(MAKE_DIRECTORY \"${CMAKE_INSTALL_PREFIX}/mscore.app/Contents/PlugIns/MuseScoreQLPreviewProvider.appex/Contents/MacOS\")
    file(MAKE_DIRECTORY \"${CMAKE_INSTALL_PREFIX}/mscore.app/Contents/PlugIns/MuseScoreQLPreviewProvider.appex/Contents/Frameworks\")

    # Copy Info.plist files
    file(COPY \"${CMAKE_CURRENT_SOURCE_DIR}/mscz-ql-plugin/Info.plist\"
         DESTINATION \"${CMAKE_INSTALL_PREFIX}/mscore.app/Contents/PlugIns/MuseScoreQLPreviewProvider.appex/Contents\")

    # Copy executable to MacOS
    file(COPY \"${CMAKE_CURRENT_SOURCE_DIR}/.build/debug/MuseScoreQLPreviewProvider\"
         DESTINATION \"${CMAKE_INSTALL_PREFIX}/mscore.app/Contents/PlugIns/MuseScoreQLPreviewProvider.appex/Contents/MacOS\")

    # Copy ZIPFoundation and other dependencies to Frameworks
    file(GLOB ZIPFOUNDATION_LIBS \"${CMAKE_CURRENT_SOURCE_DIR}/.build/debug/libZIPFoundation*.dylib\")
    file(COPY \${ZIPFOUNDATION_LIBS}
         DESTINATION \"${CMAKE_INSTALL_PREFIX}/mscore.app/Contents/PlugIns/MuseScoreQLPreviewProvider.appex/Contents/Frameworks\")
")
