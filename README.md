# Sublime Text Launcher

A simple bash script that ensures a new instance of Sublime Text 3 is launched per workspace.

NOTE: This has only been tested in the Cinnamon DE. Chances are if you're not using Cinnamon, you'll have to adapt this.

## Installation

Needs `wmctrl` to work. Also, Sublime Text 3 :)

Copy the script anywhere that's in your PATH.

Add a new launcher for the script in `~/.local/share/applications` (one is provided in `Launcher/.local/share/applications`).

Use this new launcher instead of the default Sublime Text launcher to open your text files

NOTE: You may need to edit the script and tell it what your distro calls the `subl` instances.

Default is `subl.Subl`, but I've also seen `sublime_text.Sublime_text`.

If you're not sure, fire up a sublime window and check the output of `wmctrl -lx`.


## License
[MIT](https://choosealicense.com/licenses/mit/)
