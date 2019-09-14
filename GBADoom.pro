QT += gui widgets

CONFIG += c++11 console
CONFIG -= app_bundle

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS


# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

INCLUDEPATH += "include"
INCLUDEPATH += "include\libtimidity"

SOURCES += \
        source/am_map.c \
        source/audio.cpp \
        source/d_client.c \
        source/d_items.c \
        source/d_main.c \
        source/doomdef.c \
        source/doomstat.c \
        source/dstrings.c \
        source/f_finale.c \
        source/f_wipe.c \
        source/g_game.c \
        source/hu_lib.c \
        source/hu_stuff.c \
        source/i_audio.cpp \
        source/i_main.c \
        source/i_system.c \
        source/i_system_e32.cpp \
        source/i_video.c \
        source/info.c \
        source/libtimidity/common.c \
        source/libtimidity/instrum.c \
        source/libtimidity/mix.c \
        source/libtimidity/output.c \
        source/libtimidity/playmidi.c \
        source/libtimidity/readmidi.c \
        source/libtimidity/resample.c \
        source/libtimidity/stream.c \
        source/libtimidity/timi_tables.c \
        source/libtimidity/timidity.c \
        source/lprintf.c \
        source/m_argv.c \
        source/m_bbox.c \
        source/m_cheat.c \
        source/m_menu.c \
        source/m_misc.c \
        source/m_random.c \
        source/md5.c \
        source/mmus2mid.c \
        source/p_ceilng.c \
        source/p_checksum.c \
        source/p_doors.c \
        source/p_enemy.c \
        source/p_floor.c \
        source/p_genlin.c \
        source/p_inter.c \
        source/p_lights.c \
        source/p_map.c \
        source/p_maputl.c \
        source/p_mobj.c \
        source/p_plats.c \
        source/p_pspr.c \
        source/p_saveg.c \
        source/p_setup.c \
        source/p_sight.c \
        source/p_spec.c \
        source/p_switch.c \
        source/p_telept.c \
        source/p_tick.c \
        source/p_user.c \
        source/r_bsp.c \
        source/r_data.c \
        source/r_demo.c \
        source/r_draw.c \
        source/r_main.c \
        source/r_patch.c \
        source/r_plane.c \
        source/r_segs.c \
        source/r_sky.c \
        source/r_things.c \
        source/s_sound.c \
        source/sounds.c \
        source/st_lib.c \
        source/st_stuff.c \
        source/tables.c \
        source/v_video.c \
        source/version.c \
        source/w_memcache.c \
        source/w_wad.c \
        source/wi_stuff.c \
        source/z_bmalloc.c \
        source/z_zone.c

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    include/am_map.h \
    include/audio.h \
    include/config.h \
    include/d_englsh.h \
    include/d_event.h \
    include/d_items.h \
    include/d_main.h \
    include/d_net.h \
    include/d_player.h \
    include/d_think.h \
    include/d_ticcmd.h \
    include/doomdata.h \
    include/doomdef.h \
    include/doomstat.h \
    include/doomtype.h \
    include/dstrings.h \
    include/f_finale.h \
    include/f_wipe.h \
    include/g_game.h \
    include/hu_lib.h \
    include/hu_stuff.h \
    include/i_main.h \
    include/i_network.h \
    include/i_sound.h \
    include/i_system.h \
    include/i_system_e32.h \
    include/i_system_win.h \
    include/i_video.h \
    include/info.h \
    include/libtimidity/common.h \
    include/libtimidity/instrum.h \
    include/libtimidity/mix.h \
    include/libtimidity/options.h \
    include/libtimidity/ospaths.h \
    include/libtimidity/output.h \
    include/libtimidity/playmidi.h \
    include/libtimidity/readmidi.h \
    include/libtimidity/resample.h \
    include/libtimidity/timi_endian.h \
    include/libtimidity/timi_tables.h \
    include/libtimidity/timidity.h \
    include/libtimidity/timidity_internal.h \
    include/lprintf.h \
    include/m_argv.h \
    include/m_bbox.h \
    include/m_cheat.h \
    include/m_fixed.h \
    include/m_menu.h \
    include/m_misc.h \
    include/m_random.h \
    include/m_swap.h \
    include/md5.h \
    include/mmus2mid.h \
    include/p_checksum.h \
    include/p_enemy.h \
    include/p_inter.h \
    include/p_map.h \
    include/p_maputl.h \
    include/p_mobj.h \
    include/p_pspr.h \
    include/p_saveg.h \
    include/p_setup.h \
    include/p_spec.h \
    include/p_tick.h \
    include/p_user.h \
    include/pcm_to_alaw.h \
    include/protocol.h \
    include/r_bsp.h \
    include/r_data.h \
    include/r_defs.h \
    include/r_demo.h \
    include/r_draw.h \
    include/r_main.h \
    include/r_patch.h \
    include/r_plane.h \
    include/r_segs.h \
    include/r_sky.h \
    include/r_state.h \
    include/r_things.h \
    include/s_sound.h \
    include/sounds.h \
    include/st_lib.h \
    include/st_stuff.h \
    include/tables.h \
    include/v_video.h \
    include/version.h \
    include/w_wad.h \
    include/wi_stuff.h \
    include/z_bmalloc.h \
    include/z_zone.h