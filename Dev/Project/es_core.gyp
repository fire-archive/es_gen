{
  'variables': { 
	'es_core_dir%': '../Tools/es_core',
  },
  'targets': [
    {
      'target_name': 'head',
      'type': 'executable',
      'dependencies':[
        'sdl2.gyp:SDL2',
      ],      
      'sources': [
        '<(es_core_dir)/game_main.cpp',
        '<(es_core_dir)/game_main.h',
        '<(es_core_dir)/main.cpp',
        '<(es_core_dir)/render_main.cpp',
        '<(es_core_dir)/render_main.h',
        '<(es_core_dir)/head_src/game.cpp',
	    '<(es_core_dir)/head_src/game.h',
	    '<(es_core_dir)/head_src/render.cpp',
	    '<(es_core_dir)/head_src/render.h',
	    '<(es_core_dir)/head_src/shared_render_state.h',
	    '<(es_core_dir)/nstr.h',
      ],
      'include_dirs': [
          '<(es_core_dir)/',
          '<(es_core_dir)/../czmq/include',
          '<(es_core_dir)/../libzmq/include',
          '<(es_core_dir)/../ogre/Build/include',
          '<(es_core_dir)/../ogre/OgreMain/include',
          '<(es_core_dir)/../SDL/include',
          '<(es_core_dir)/../tbb/include',
          '<(es_core_dir)/head_src',
          '<(es_core_dir)/../nanomsg/Build/nanomsg/include',
          '<(es_core_dir)/../cppnanomsg',
      ],
      'link_settings': {
        'libraries': [
          '-llibzmq',
		  '-lczmq',
		  '-lOgreMain',
		  '-lSDL2',
		  '-lnanomsg',
        ],
      },
        'msvs_settings': {
        'VCLinkerTool': {
        'AdditionalLibraryDirectories': [
          '<(es_core_dir)/../libzmq/lib/Win32',
          '<(es_core_dir)/../czmq/builds/msvc/Release',
          '<(es_core_dir)/../ogre/Build/lib/RelWithDebInfo',
          '<(es_core_dir)/../SDL/VisualC/SDL/Win32/Release',
          '<(es_core_dir)/../tbb/lib/intel64/vc11/',
          '<(es_core_dir)/../nanomsg/Build/nanomsg/lib',
          'default',
        ],
      },
      },
      'direct_dependent_settings': {
        'include_dirs': [
          '<(es_core_dir)/',
        ],
      },
      'conditions': [
        ['OS=="win"', {
          'targets': [
            {
			  'defines': [
			  ],
            },
          ],
        }],
      ],
    },
    {
      'target_name': 'scene',
      'type': 'executable',
      'sources': [
        '<(es_core_dir)/game_main.cpp',
        '<(es_core_dir)/game_main.h',
        '<(es_core_dir)/main.cpp',
        '<(es_core_dir)/render_main.cpp',
        '<(es_core_dir)/render_main.h',
        '<(es_core_dir)/scene_load_src/game.cpp',
	    '<(es_core_dir)/scene_load_src/game.h',
	    '<(es_core_dir)/scene_load_src/render.cpp',
	    '<(es_core_dir)/scene_load_src/render.h',
	    '<(es_core_dir)/scene_load_src/shared_render_state.h',
      ],
      'include_dirs': [
          '<(es_core_dir)/',
          '<(es_core_dir)/../czmq/include',
          '<(es_core_dir)/../libzmq/include',
          '<(es_core_dir)/../ogre/Build/include',
          '<(es_core_dir)/../ogre/OgreMain/include',
          '<(es_core_dir)/../SDL/include',
          '<(es_core_dir)/../tbb/include',
          '<(es_core_dir)/head_src/',
      ],
      'link_settings': {
        'libraries': [
          '-llibzmq',
		  '-lczmq',
		  '-lOgreMain',
		  '-lSDL2',
        ],
      },
        'msvs_settings': {
        'VCLinkerTool': {
        'AdditionalLibraryDirectories': [
          '<(es_core_dir)/../libzmq/lib/Win32',
          '<(es_core_dir)/../czmq/builds/msvc/Release',
          '<(es_core_dir)/../ogre/Build/lib/RelWithDebInfo',
          '<(es_core_dir)/../SDL/VisualC/SDL/Win32/Release',
          '<(es_core_dir)/../tbb/lib/intel64/vc11/',
          'default'
        ],
      },
      },
      'direct_dependent_settings': {
        'include_dirs': [
          '<(es_core_dir)/',
        ],
      },
    },
  ],
}
