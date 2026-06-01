final: prev: {
  dwl = prev.dwl.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      cp ${../dwl/config.def.h} config.def.h
    '';
  });
}
