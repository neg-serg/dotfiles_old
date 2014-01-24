" colorv menu
function! GetColorFormat()
    let formats = {'r' : 'RGB',
                  \'n' : 'NAME',
                  \'s' : 'HEX',
                  \'ar': 'RGBA',
                  \'pr': 'RGBP',
                  \'pa': 'RGBAP',
                  \'m' : 'CMYK',
                  \'l' : 'HSL',
                  \'la' : 'HSLA',
                  \'h' : 'HSV',
                  \}
    let formats_menu = ["\n"]
    for [k, v] in items(formats)
        call add(formats_menu, "  ".k."\t".v."\n")
    endfor
    let fsel = get(formats, input('Choose a format: '.join(formats_menu).'? '))
    return fsel
endfunction

function! GetColorMethod()
    let methods = {
                   \'h' : 'Hue',
                   \'s' : 'Saturation',
                   \'v' : 'Value',
                   \'m' : 'Monochromatic',
                   \'a' : 'Analogous',
                   \'3' : 'Triadic',
                   \'4' : 'Tetradic',
                   \'n' : 'Neutral',
                   \'c' : 'Clash',
                   \'q' : 'Square',
                   \'5' : 'Five-Tone',
                   \'6' : 'Six-Tone',
                   \'2' : 'Complementary',
                   \'p' : 'Split-Complementary',
                   \'l' : 'Luma',
                   \'g' : 'Turn-To',
                   \}
    let methods_menu = ["\n"]
    for [k, v] in items(methods)
        call add(methods_menu, "  ".k."\t".v."\n")
    endfor
    let msel = get(methods, input('Choose a method: '.join(methods_menu).'? '))
    return msel
endfunction

let g:unite_source_menu_menus.colorv = {
    \ 'description' : '         color management
        \                                      ⌘ [space]c',
    \}
let g:unite_source_menu_menus.colorv.command_candidates = [
    \['▷ open colorv                                                ⌘ ,cv',
        \'ColorV'],
    \['▷ open colorv with the color under the cursor                ⌘ ,cw',
        \'ColorVView'],
    \['▷ preview colors                                             ⌘ ,cpp',
        \'ColorVPreview'],
    \['▷ color picker                                               ⌘ ,cd',
        \'ColorVPicker'],
    \['▷ edit the color under the cursor                            ⌘ ,ce',
        \'ColorVEdit'],
    \['▷ edit the color under the cursor (and all the concurrences) ⌘ ,cE',
        \'ColorVEditAll'],
    \['▷ insert a color                                             ⌘ ,cii',
        \'exe "ColorVInsert " .GetColorFormat()'],
    \['▷ color list relative to the current                         ⌘ ,cgh',
        \'exe "ColorVList " .GetColorMethod() "
        \ ".input("number of colors? (optional): ")
        \ " ".input("number of steps?  (optional): ")'],
    \['▷ show colors list (Web W3C colors)                          ⌘ ,cn',
        \'ColorVName'],
    \['▷ choose color scheme (ColourLovers, Kuler)                  ⌘ ,css',
        \'ColorVScheme'],
    \['▷ show favorite color schemes                                ⌘ ,csf',
        \'ColorVSchemeFav'],
    \['▷ new color scheme                                           ⌘ ,csn',
        \'ColorVSchemeNew'],
    \['▷ create hue gradation between two colors',
        \'exe "ColorVTurn2 " " ".input("Color 1 (hex): ")
        \" ".input("Color 2 (hex): ")'],
    \]
" }}}

