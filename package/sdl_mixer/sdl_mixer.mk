################################################################################
#
# sdl_mixer
#
################################################################################

SDL_MIXER_VERSION = 1.2.13
SDL_MIXER_SOURCE = SDL-1.2.tar.gz
SDL_MIXER_SITE =  https://github.com/SDL-mirror/SDL_mixer/archive
SDL_MIXER_LICENSE = zlib
SDL_MIXER_LICENSE_FILES = COPYING

SDL_MIXER_INSTALL_STAGING = YES
SDL_MIXER_DEPENDENCIES = sdl
SDL_MIXER_CONF_OPTS = \
	--without-x \
	--with-sdl-prefix=$(STAGING_DIR)/usr \
	--disable-music-mp3 \
	--disable-music-mod \
	--disable-music-flac # configure script fails when cross compiling

ifeq ($(BR2_PACKAGE_LIBMAD),y)
SDL_MIXER_CONF_OPTS += --enable-music-mp3-mad-gpl
SDL_MIXER_DEPENDENCIES += libmad
else
SDL_MIXER_CONF_OPTS += --disable-music-mp3-mad-gpl
endif

ifeq ($(BR2_PACKAGE_LIBMODPLUG),y)
SDL_MIXER_CONF_OPTS += --enable-music-mod-modplug
SDL_MIXER_DEPENDENCIES += libmodplug
else
SDL_MIXER_CONF_OPTS += --disable-music-mod-modplug
endif

# prefer tremor over libvorbis
ifeq ($(BR2_PACKAGE_TREMOR),y)
SDL_MIXER_CONF_OPTS += --enable-music-ogg-tremor
SDL_MIXER_DEPENDENCIES += tremor
else
SDL_MIXER_CONF_OPTS += --disable-music-ogg
endif

$(eval $(autotools-package))
