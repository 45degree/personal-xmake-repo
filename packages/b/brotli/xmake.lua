package("brotli")

    set_homepage("https://github.com/google/brotli")
    set_description("Brotli is a generic-purpose lossless compression algorithm")
    set_urls("https://github.com/google/brotli/archive/$(version).tar.gz")

    add_versions("v1.0.9", "f9e8d81d0405ba66d181529af42a3354f838c939095ff99930da6aa9cdf6fe46")
    add_links("brotlicommon", "brotlidec", "brotlienc")

    on_install("linux", function (package)
        import("package.tools.cmake").install(package, {"-DCMAKE_BUILD_TYPE=Release"})
    end)
    on_test(function (package)
        assert(package:check_cxxsnippets({test = [[
            #include <brotli/decode.h>
            #include <brotli/encode.h>

            int test(void) {
                uint32_t i = BrotliEncoderVersion();
                return 0;
            }
        ]]}, {configs = {languages = "c++11"}}))
    end)

package_end()
