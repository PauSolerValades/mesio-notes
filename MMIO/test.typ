#set page(width: 20cm, height:auto)
#set heading(numbering: "1.")

= Fun with typst

The typst program is pretty neat! 

- Extremely fast incremental recompile
- Easier syntax
- Markup includes a well-designed scripting language
  (vs. LaTeX's macro system; akin to the difference between
  using macros in the C preprocessor vs. functions)

Circles #box[#circle(radius: 4pt)] are easy to embed, 
along with equations like $E = m c^2$ and $a^2+b^2=c^2$ 
and $sum_(k=0)^infinity 1/(k^2)=pi^2 / 6$. Or on its own line:

#let bf(x) = $upright(bold(#x))$
#set math.mat(delim: "[")

$ bf(T)(theta) = mat(cos theta, -sin theta; sin theta, cos theta) $

- `typst` program: https://github.com/typst/typst/releases/tag/22-03-21-2
- vscode language files for syntax highlighting at https://github.com/typst/typst/tree/main/tools/support

  - Download the vscode support files

    ```
    mkdir typst-vscode
    cd typst-vscode
    git clone --filter=blob:none --sparse https://github.com/typst/typst .
    git sparse-checkout add tools/support
    ```
  - In VSCode:
      - Shift-Ctrl-P
      - select "Developer: Install Extension from Location"
      - select the tools/support directory you got from git
- Run `typst --watch MYFILE.typ` in a terminal in VS Code
- Install #link("https://marketplace.visualstudio.com/items?itemName=tomoki1207.pdf")[vscode-pdf extension]
    for viewing pdf
    
/*
 * Here is a sample comment
 *
 * typst theses:
 * https://www.user.tu-berlin.de/laurmaedje/programmable-markup-language-for-typesetting.pdf
 * https://www.user.tu-berlin.de/mhaug/fast-typesetting-incremental-compilation.pdf
 */