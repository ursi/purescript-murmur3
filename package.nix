{ murmur, p }:
{ ps-pkgs, ps-pkgs-ns, ... }:
  { dependencies = with ps-pkgs; [ functions prelude ];

    foreign =
      { Murmur3 =
          { src =
              p.runCommand "murmur3-module" {}
                ''
                mkdir $out; cd $out
                cat ${murmur + /murmurhash3_gc.js} > murmur3.js
                echo $'\nexport { murmurhash3_32_gc }' >> murmur3.js
                '';

            paths.murmur3 = /murmur3.js;
         };
     };
  }
