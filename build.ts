import { type Build } from 'xbuild';

const build: Build = {
    common: {
        project: 'msgpackc',
        archs: ['x64'],
        variables: [],
        copy: {},
        defines: [],
        options: [
            ['BUILD_SHARED_LIBs', false], 
            ['MSGPACK_BUILD_EXAMPLES', false]
        ],
        subdirectories: ['msgpack-c'],
        libraries: {
            'msgpack-c': {
                name: 'msgpackc',
                properties: {
                    'IMPORT_SUFFIX': '".lib"'
                }
            }
        },
        buildDir: 'build',
        buildOutDir: '../libs',
        buildFlags: ['-DMSGPACK_ENABLE_SHARED=OFF']
    },
    platforms: {
        win32: {
            windows: {},
            android: {
                archs: ['x86', 'x86_64', 'armeabi-v7a', 'arm64-v8a'],
            }
        },
        linux: {
            linux: {}
        },
        darwin: {
            macos: {}
        }
    }
}

export default build;