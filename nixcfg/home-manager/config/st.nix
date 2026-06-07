{ pkgs, ... }:
{
  home.packages = [
    (pkgs.st.overrideAttrs (old: {
      postPatch = ''
        cp config.def.h config.h

        # Font — replace the entire line to avoid matching issues
        sed -i '/static char font\[\]/c\static char font[] = "Iosevka:size=16:antialias=true:autohint=true";' config.h

        # Internal padding
        sed -i '/static int borderpx/c\static int borderpx = 14;' config.h

        # Disable cursor blink
        sed -i '/static unsigned int blinktimeout/c\static unsigned int blinktimeout = 0;' config.h

        # ====================== COLOR THEME ======================
        sed -i '/static const char \*colorname\[\] = {/,/};/c\static const char *colorname[] = {\
            "#181818", /* black          */\
            "#F43841", /* red            */\
            "#73D936", /* green          */\
            "#FFDD33", /* yellow         */\
            "#96A6C8", /* blue           */\
            "#9E95C7", /* magenta        */\
            "#95A99F", /* cyan           */\
            "#E4E4E4", /* white          */\
            "#52494E", /* bright black   */\
            "#FF4F58", /* bright red     */\
            "#73D936", /* bright green   */\
            "#FFDD33", /* bright yellow  */\
            "#96A6C8", /* bright blue    */\
            "#AFAFD7", /* bright magenta */\
            "#95A99F", /* bright cyan    */\
            "#F5F5F5", /* bright white   */\
            [256] = "#E4E4E4", /* foreground */\
            [257] = "#181818", /* background */\
            [258] = "#E4E4E4", /* cursor     */\
        };' config.h

        # Default color indices
        sed -i '/unsigned int defaultfg/c\unsigned int defaultfg = 256;' config.h
        sed -i '/unsigned int defaultbg/c\unsigned int defaultbg = 257;' config.h
        sed -i '/unsigned int defaultcs/c\unsigned int defaultcs = 258;' config.h
      '';
    }))
  ];
}
