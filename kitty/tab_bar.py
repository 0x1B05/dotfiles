# foreground #24292f
# background #ffffff
# selection_foreground #ffffff
# selection_background #0969da
#
# #: Cursor colors
# cursor #0969da
#
# tab_bar_background #e9e9ec
# active_tab_foreground #0969da
# active_tab_background #a8aecb
# inactive_tab_foreground #6172b0
# inactive_tab_background #e9e9ec
#
# #: The basic 16 colors
#
# #: black
# color0 #24292f
# color8 #57606a
#
# #: red
# color1 #cf222e
# color9 #a40e26
#
# #: green
# color2 #116329
# color10 #1a7f37
#
# #: yellow
# color3 #4d2d00
# color11 #633c01
#
# #: blue
# color4 #0969da
# color12 #218bff
#
# #: magenta
# color5 #8250df
# color13 #a475f9
#
# #: cyan
# color6 #1b7c83
# color14 #3192aa
#
# #: white
# color7 #6e7781
# color15 #8c959f

import datetime
from kitty.fast_data_types import Screen, get_options
from kitty.tab_bar import (DrawData, ExtraData, TabBarData , as_rgb,
                           draw_tab_with_powerline)
from kitty.utils import color_as_int

opts = get_options()

CLOCK_FG = as_rgb(int("ffffff", 16))
CLOCK_BG = as_rgb(color_as_int(opts.color4))
DATE_FG = as_rgb(int("ffffff", 16))
DATE_BG = as_rgb(color_as_int(opts.color4))

def _draw_right_status(screen: Screen, is_last: bool) -> int:
    if not is_last:
        return screen.cursor.x

    cells = [
        (CLOCK_BG, screen.cursor.bg, ""),
        (CLOCK_FG, CLOCK_BG, datetime.datetime.now().strftime(" %H:%M ")),
        (DATE_FG, DATE_BG, datetime.datetime.now().strftime("  %Y/%m/%d ")),
    ]

    right_status_length = 0
    for _, _, cell in cells:
        right_status_length += len(cell)

    draw_spaces = screen.columns - screen.cursor.x - right_status_length
    if draw_spaces > 0:
        screen.draw(" " * draw_spaces)

    for fg, bg, cell in cells:
        screen.cursor.fg = fg
        screen.cursor.bg = bg
        screen.draw(cell)
    screen.cursor.fg = 0
    screen.cursor.bg = 0

    screen.cursor.x = max(screen.cursor.x, screen.columns - right_status_length)
    return screen.cursor.x


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    end = draw_tab_with_powerline(
        draw_data, screen, tab, before, max_title_length, index, is_last, extra_data
    )
    _draw_right_status(
        screen,
        is_last,
    )
    return end
