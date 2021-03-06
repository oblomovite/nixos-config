# vim: ft=dosini

# Configfile for qutebrowser.
#
# This configfile is parsed by python's configparser in extended
# interpolation mode. The format is very INI-like, so there are
# categories like [general] with "key = value"-pairs.
#
# Note that you shouldn't add your own comments, as this file is
# regenerated every time the config is saved.
#
# Interpolation looks like  ${value}  or  ${section:value} and will be
# replaced by the respective value.
#
# This is the default config, so if you want to remove anything from
# here (as opposed to change/add), for example a keybinding, set it to
# an empty value.
#
# You will need to escape the following values:
#   - # at the start of the line (at the first position of the key) (\#)
#   - $ in a value ($$)
#   - = in a value as <eq>

[general]
# General/miscellaneous options.
#
# ignore-case (bool):
#     Whether to find text on a page case-insensitively.
#     Default: smart
#
# wrap-search (bool):
#     Whether to wrap finding text to the top when arriving at the end.
#     Default: true
#
# startpage (string-list):
#     The default page(s) to open at the start, separated by commas.
#     Default: http://www.duckduckgo.com
#
# auto-search:
#     Whether to start a search when something else than a URL is
#     entered.
#         naive: Use simple/naive check.
#         dns: Use DNS requests (might be slow!).
#         false: Never search automatically.
#     Default: naive
#
# auto-save-config (bool):
#     Whether to save the config automatically on quit.
#     Default: true
#
# editor (shell-command):
#     The editor (and arguments) to use for the `open-editor` command.
#     Use `{}` for the filename. The value gets split like in a shell,
#     so you can use `"` or `'` to quote arguments.
#     Default: gvim -f "{}"
#
# editor-encoding (encoding):
#     Encoding to use for editor.
#     Default: utf-8
#
# private-browsing (bool):
#     Do not record visited pages in the history or store web page
#     icons.
#     Default: false
#
# developer-extras (bool):
#     Enable extra tools for Web developers.
#     This needs to be enabled for `:inspector` to work and also adds an
#     _Inspect_ entry to the context menu.
#     Default: false
#
# print-element-backgrounds (bool):
#     Whether the background color and images are also drawn when the
#     page is printed.
#     Default: true
#
# xss-auditing (bool):
#     Whether load requests should be monitored for cross-site scripting
#     attempts.
#     Suspicious scripts will be blocked and reported in the inspector's
#     JavaScript console. Enabling this feature might have an impact on
#     performance.
#     Default: false
#
# site-specific-quirks (bool):
#     Enable workarounds for broken sites.
#     Default: true
#
# default-encoding (string):
#     Default encoding to use for websites.
#     The encoding must be a string describing an encoding such as
#     _utf-8_, _iso-8859-1_, etc. If left empty a default value will be
#     used.
#     Default:
#
# new-instance-open-target:
#     How to open links in an existing instance if a new one is
#     launched.
#         tab: Open a new tab in the existing window and activate it.
#         tab-silent: Open a new tab in the existing window without
#     activating it.
#         window: Open in a new window.
#     Default: window
ignore-case = smart
wrap-search = true
startpage = http://www.duckduckgo.com
auto-search = naive
auto-save-config = true
editor = gvim -f "{}"
editor-encoding = utf-8
private-browsing = false
developer-extras = false
print-element-backgrounds = true
xss-auditing = false
site-specific-quirks = true
default-encoding = 
new-instance-open-target = window

[ui]
# General options related to the user interface.
#
# zoom-levels (perc-list):
#     The available zoom levels, separated by commas.
#     Default:
#     25%,33%,50%,67%,75%,90%,100%,110%,125%,150%,175%,200%,250%,300%,400%,500%
#
# default-zoom (percentage):
#     The default zoom level.
#     Default: 100%
#
# message-timeout (int):
#     Time (in ms) to show messages in the statusbar for.
#     Default: 2000
#
# confirm-quit:
#     Whether to confirm quitting the application.
#         always: Always show a confirmation.
#         multiple-tabs: Show a confirmation if multiple tabs are
#     opened.
#         never: Never show a confirmation.
#     Default: never
#
# display-statusbar-messages (bool):
#     Whether to display javascript statusbar messages.
#     Default: false
#
# zoom-text-only (bool):
#     Whether the zoom factor on a frame applies only to the text or to
#     all content.
#     Default: false
#
# frame-flattening (bool):
#     Whether to  expand each subframe to its contents.
#     This will flatten all the frames to become one scrollable page.
#     Default: false
#
# user-stylesheet (user-stylesheet):
#     User stylesheet to use (absolute filename or CSS string).
#     Default: ::-webkit-scrollbar { width: 0px; height: 0px; }
#
# css-media-type (string):
#     Set the CSS media type.
#     Default:

zoom-levels = 25%,33%,50%,67%,75%,90%,100%,110%,125%,150%,175%,200%,250%,300%,400%,500%
default-zoom = 100%
message-timeout = 2000
confirm-quit = never
display-statusbar-messages = false
zoom-text-only = false
frame-flattening = false
user-stylesheet = ::-webkit-scrollbar { width: 0px; height: 0px; }
css-media-type = 

[network]
# Settings related to the network.
#
# do-not-track (bool):
#     Value to send in the `DNT` header.
#     Default: true
#
# accept-language (string):
#     Value to send in the `accept-language` header.
#     Default: en-US,en
#
# user-agent (string):
#     User agent to send. Empty to send the default.
#     Default:
#
# proxy:
#     The proxy to use.
#     In addition to the listed values, you can use a `socks://...` or
#     `http://...` URL.
#         system: Use the system wide proxy.
#         none: Don't use any proxy
#     Default: system
#
# ssl-strict (bool):
#     Whether to validate SSL handshakes.
#     Default: true
#
# dns-prefetch (bool):
#     Whether to try to pre-fetch DNS entries to speed up browsing.
#     Default: true
do-not-track = true
accept-language = en-US,en
user-agent = 
proxy = system
ssl-strict = true
dns-prefetch = true

[completion]
# Options related to completion and command history.
#
# show (bool):
#     Whether to show the autocompletion window.
#     Default: true
#
# height (percentage-or-int):
#     The height of the completion, in px or as percentage of the
#     window.
#     Default: 50%
#
# history-length (int):
#     How many commands to save in the history.
#     0: no history / -1: unlimited
#     Default: 100
#
# quick-complete (bool):
#     Whether to move on to the next part when there's only one possible
#     completion left.
#     Default: true
#
# shrink (bool):
#     Whether to shrink the completion to be smaller than the configured
#     size if there are no scrollbars.
#     Default: false
show = true
height = 50%
history-length = 100
quick-complete = true
shrink = false

[input]
# Options related to input modes.
#
# timeout (int):
#     Timeout for ambiguous keybindings.
#     Default: 500
#
# insert-mode-on-plugins (bool):
#     Whether to switch to insert mode when clicking flash and other
#     plugins.
#     Default: false
#
# auto-leave-insert-mode (bool):
#     Whether to leave insert mode if a non-editable element is clicked.
#     Default: true
#
# auto-insert-mode (bool):
#     Whether to automatically enter insert mode if an editable element
#     is focused after page load.
#     Default: false
#
# forward-unbound-keys:
#     Whether to forward unbound keys to the webview in normal mode.
#         all: Forward all unbound keys.
#         auto: Forward unbound non-alphanumeric keys.
#         none: Don't forward any keys.
#     Default: auto
#
# spatial-navigation (bool):
#     Enables or disables the Spatial Navigation feature
#     Spatial navigation consists in the ability to navigate between
#     focusable elements in a Web page, such as hyperlinks and form
#     controls, by using Left, Right, Up and Down arrow keys. For
#     example, if a user presses the Right key, heuristics determine
#     whether there is an element he might be trying to reach towards
#     the right and which element he probably wants.
#     Default: false
#
# links-included-in-focus-chain (bool):
#     Whether hyperlinks should be included in the keyboard focus chain.
#     Default: true
timeout = 500
insert-mode-on-plugins = false
auto-leave-insert-mode = true
auto-insert-mode = false
forward-unbound-keys = auto
spatial-navigation = false
links-included-in-focus-chain = true

[tabs]
# Configuration of the tab bar.
#
# background-tabs (bool):
#     Whether to open new tabs (middleclick/ctrl+click) in background.
#     Default: false
#
# select-on-remove:
#     Which tab to select when the focused tab is removed.
#         left: Select the tab on the left.
#         right: Select the tab on the right.
#         previous: Select the previously selected tab.
#     Default: right
#
# new-tab-position:
#     How new tabs are positioned.
#         left: On the left of the current tab.
#         right: On the right of the current tab.
#         first: At the left end.
#         last: At the right end.
#     Default: right
#
# new-tab-position-explicit:
#     How new tabs opened explicitely are positioned.
#         left: On the left of the current tab.
#         right: On the right of the current tab.
#         first: At the left end.
#         last: At the right end.
#     Default: last
#
# last-close:
#     Behaviour when the last tab is closed.
#         ignore: Don't do anything.
#         blank: Load a blank page.
#         close: Close the window.
#     Default: ignore
#
# auto-hide (bool):
#     Hide the tabbar if only one tab is open.
#     Default: false
#
# wrap (bool):
#     Whether to wrap when changing tabs.
#     Default: true
#
# movable (bool):
#     Whether tabs should be movable.
#     Default: true
#
# close-mouse-button:
#     On which mouse button to close tabs.
#         right: Close tabs on right-click.
#         middle: Close tabs on middle-click.
#         none: Don't close tabs using the mouse.
#     Default: middle
#
# position:
#     The position of the tab bar.
#     Valid values: north, south, east, west
#     Default: north
#
# show-favicons (bool):
#     Whether to show favicons in the tab bar.
#     Default: true
#
# width (percentage-or-int):
#     The width of the tab bar if it's vertical, in px or as percentage
#     of the window.
#     Default: 20%
#
# indicator-width (int):
#     Width of the progress indicator (0 to disable).
#     Default: 3
#
# indicator-space (int):
#     Spacing between tab edge and indicator.
#     Default: 3
background-tabs = false
select-on-remove = right
new-tab-position = right
new-tab-position-explicit = last
last-close = blank
auto-hide = false
wrap = true
movable = true
close-mouse-button = middle
position = north
show-favicons = true
width = 20%
indicator-width = 3
indicator-space = 3

[storage]
# Settings related to cache and storage.
#
# download-directory (directory):
#     The directory to save downloads to. An empty value selects a
#     sensible os-specific default.
#     Default:
#
# maximum-pages-in-cache (int):
#     The maximum number of pages to hold in the memory page cache.
#     The Page Cache allows for a nicer user experience when navigating
#     forth or back to pages in the forward/back history, by pausing and
#     resuming up to _n_ pages.
#     For more information about the feature, please refer to:
#     http://webkit.org/blog/427/webkit-page-cache-i-the-basics/
#     Default:
#
# object-cache-capacities (bytes-list):
#     The capacities for the memory cache for dead objects such as
#     stylesheets or scripts. Syntax: cacheMinDeadCapacity,
#     cacheMaxDead, totalCapacity.
#     The _cacheMinDeadCapacity_ specifies the minimum number of bytes
#     that dead objects should consume when the cache is under pressure.
#     _cacheMaxDead_ is the maximum number of bytes that dead objects
#     should consume when the cache is *not* under pressure.
#     _totalCapacity_ specifies the maximum number of bytes that the
#     cache should consume *overall*.
#     Default:
#
# offline-storage-default-quota (bytes):
#     Default quota for new offline storage databases.
#     Default:
#
# offline-web-application-cache-quota (bytes):
#     Quota for the offline web application cache.
#     Default:
#
# offline-storage-database (bool):
#     Whether support for the HTML 5 offline storage feature is enabled.
#     Default: true
#
# offline-web-application-storage (bool):
#     Whether support for the HTML 5 web application cache feature is
#     enabled.
#     An application cache acts like an HTTP cache in some sense. For
#     documents that use the application cache via JavaScript, the
#     loader engine will first ask the application cache for the
#     contents, before hitting the network.
#     The feature is described in details at:
#     http://dev.w3.org/html5/spec/Overview.html#appcache
#     Default: true
#
# local-storage (bool):
#     Whether support for the HTML 5 local storage feature is enabled.
#     Default: true
#
# cache-size (int):
#     Size of the HTTP network cache.
#     Default: 52428800

download-directory = ~/downloads
maximum-pages-in-cache = 
object-cache-capacities = 
offline-storage-default-quota = 
offline-web-application-cache-quota = 
offline-storage-database = true
offline-web-application-storage = true
local-storage = true
cache-size = 52428800

[permissions]
# Loaded plugins/scripts and allowed actions.
#
# allow-images (bool):
#     Whether images are automatically loaded in web pages.
#     Default: true
#
# allow-javascript (bool):
#     Enables or disables the running of JavaScript programs.
#     Default: true
#
# allow-plugins (bool):
#     Enables or disables plugins in Web pages.
#     Qt plugins with a mimetype such as "application/x-qt-plugin" are
#     not affected by this setting.
#     Default: false
#
# javascript-can-open-windows (bool):
#     Whether JavaScript programs can open new windows.
#     Default: false
#
# javascript-can-close-windows (bool):
#     Whether JavaScript programs can close windows.
#     Default: false
#
# javascript-can-access-clipboard (bool):
#     Whether JavaScript programs can read or write to the clipboard.
#     Default: false
#
# local-content-can-access-remote-urls (bool):
#     Whether locally loaded documents are allowed to access remote
#     urls.
#     Default: false
#
# local-content-can-access-file-urls (bool):
#     Whether locally loaded documents are allowed to access other local
#     urls.
#     Default: true
#
# cookies-accept:
#     Whether to accept cookies.
#         default: Default QtWebKit behaviour.
#         never: Don't accept cookies at all.
#     Default: default
#
# cookies-store (bool):
#     Whether to store cookies.
#     Default: true

allow-images = true
allow-javascript = true
allow-plugins = false
javascript-can-open-windows = false
javascript-can-close-windows = false
javascript-can-access-clipboard = false
local-content-can-access-remote-urls = false
local-content-can-access-file-urls = true
cookies-accept = default
cookies-store = true

[hints]
# Hinting settings.
#
# border (string):
#     CSS border value for hints.
#     Default: 1px solid #E3BE23
#
# opacity (float):
#     Opacity for hints.
#     Default: 0.7
#
# mode:
#     Mode to use for hints.
#         number: Use numeric hints.
#         letter: Use the chars in the hints -> chars setting.
#     Default: letter
#
# chars (string):
#     Chars used for hint strings.
#     Default: asdfghjkl
#
# uppercase (bool):
#     Make chars in hint strings uppercase.
#     Default: false
#
# auto-follow (bool):
#     Whether to auto-follow a hint if there's only one left.
#     Default: true
#
# next-regexes (regex-list):
#     A comma-separated list of regexes to use for 'next' links.
#     Default: \bnext\b,\bmore\b,\bnewer\b,\b[>??????]\b,\b(>>|??)\b
#
# prev-regexes (regex-list):
#     A comma-separated list of regexes to use for 'prev' links.
#     Default: \bprev(ious)?\b,\bback\b,\bolder\b,\b[<??????]\b,\b(<<|??)\b

border = 1px solid #E3BE23
opacity = 0.7
mode = letter
chars = asdfghjkl
uppercase = true
auto-follow = true
next-regexes = \bnext\b,\bmore\b,\bnewer\b,\b[>??????]\b,\b(>>|??)\b
prev-regexes = \bprev(ious)?\b,\bback\b,\bolder\b,\b[<??????]\b,\b(<<|??)\b

[searchengines]
# Definitions of search engines which can be used via the address bar.
# The searchengine named `DEFAULT` is used when `general -> auto-search`
# is true and something else than a URL was entered to be opened. Other
# search engines can be used via the bang-syntax, e.g. `:open
# qutebrowser !google`. The string `{}` will be replaced by the search
# term, use `{{` and `}}` for literal `{`/`}` signs.

DEFAULT = ${duckduckgo}
duckduckgo = https://duckduckgo.com/?q={}
ddg = ${duckduckgo}
google = https://encrypted.google.com/search?q={}
g = ${google}
wikipedia = http://en.wikipedia.org/w/index.php?title=Special:Search&search={}
wiki = ${wikipedia}

[aliases]
# Aliases for commands.
# By default, no aliases are defined. Example which adds a new command
# `:qtb` to open qutebrowsers website:
# `qtb = open http://www.qutebrowser.org/`

[colors]
# Colors used in the UI.
# A value can be in one of the following format:
#  * `#RGB`/`#RRGGBB`/`#RRRGGGBBB`/`#RRRRGGGGBBBB`
#  * A SVG color name as specified in http://www.w3.org/TR/SVG/types.html#ColorKeywords[the W3C specification].
#  * transparent (no color)
#  * `rgb(r, g, b)` / `rgba(r, g, b, a)` (values 0-255 or percentages)
#  * `hsv(h, s, v)` / `hsva(h, s, v, a)` (values 0-255, hue 0-359)
#  * A gradient as explained in http://qt-project.org/doc/qt-4.8/stylesheet-reference.html#list-of-property-types[the Qt documentation] under ``Gradient''.
# The `hints.*` values are a special case as they're real CSS colors, not Qt-CSS colors. There, for a gradient, you need to use `-webkit-gradient`, see https://www.webkit.org/blog/175/introducing-css-gradients/[the WebKit documentation].
#
# completion.fg (qcolor):
#     Text color of the completion widget.
#     Default: white
#
# completion.bg (qss-color):
#     Background color of the completion widget.
#     Default: #333333
#
# completion.item.bg (qss-color):
#     Background color of completion widget items.
#     Default: ${completion.bg}
#
# completion.category.fg (qcolor):
#     Foreground color of completion widget category headers.
#     Default: white
#
# completion.category.bg (qss-color):
#     Background color of the completion widget category headers.
#     Default: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #888888,
#     stop:1 #505050)
#
# completion.category.border.top (qss-color):
#     Top border color of the completion widget category headers.
#     Default: black
#
# completion.category.border.bottom (qss-color):
#     Bottom border color of the completion widget category headers.
#     Default: ${completion.category.border.top}
#
# completion.item.selected.fg (qcolor):
#     Foreground color of the selected completion item.
#     Default: black
#
# completion.item.selected.bg (qss-color):
#     Background color of the selected completion item.
#     Default: #e8c000
#
# completion.item.selected.border.top (qss-color):
#     Top border color of the completion widget category headers.
#     Default: #bbbb00
#
# completion.item.selected.border.bottom (qss-color):
#     Bottom border color of the selected completion item.
#     Default: ${completion.item.selected.border.top}
#
# completion.match.fg (qss-color):
#     Foreground color of the matched text in the completion.
#     Default: #ff4444
#
# statusbar.bg (qss-color):
#     Foreground color of the statusbar.
#     Default: black
#
# statusbar.fg (qss-color):
#     Foreground color of the statusbar.
#     Default: white
#
# statusbar.bg.error (qss-color):
#     Background color of the statusbar if there was an error.
#     Default: red
#
# statusbar.bg.prompt (qss-color):
#     Background color of the statusbar if there is a prompt.
#     Default: darkblue
#
# statusbar.bg.insert (qss-color):
#     Background color of the statusbar in insert mode.
#     Default: darkgreen
#
# statusbar.progress.bg (qss-color):
#     Background color of the progress bar.
#     Default: white
#
# statusbar.url.fg (qss-color):
#     Default foreground color of the URL in the statusbar.
#     Default: ${statusbar.fg}
#
# statusbar.url.fg.success (qss-color):
#     Foreground color of the URL in the statusbar on successful load.
#     Default: lime
#
# statusbar.url.fg.error (qss-color):
#     Foreground color of the URL in the statusbar on error.
#     Default: orange
#
# statusbar.url.fg.warn (qss-color):
#     Foreground color of the URL in the statusbar when there's a
#     warning.
#     Default: yellow
#
# statusbar.url.fg.hover (qss-color):
#     Foreground color of the URL in the statusbar for hovered links.
#     Default: aqua
#
# tab.fg.odd (qcolor):
#     Foreground color of unselected odd tabs.
#     Default: white
#
# tab.fg.even (qcolor):
#     Foreground color of unselected even tabs.
#     Default: white
#
# tab.fg.selected (qcolor):
#     Foreground color of selected tabs.
#     Default: white
#
# tab.bg.odd (qcolor):
#     Background color of unselected odd tabs.
#     Default: grey
#
# tab.bg.even (qcolor):
#     Background color of unselected even tabs.
#     Default: darkgrey
#
# tab.bg.selected (qcolor):
#     Background color of selected tabs.
#     Default: black
#
# tab.bg.bar (qcolor):
#     Background color of the tabbar.
#     Default: #555555
#
# tab.indicator.start (qcolor):
#     Color gradient start for the tab indicator.
#     Default: #0000aa
#
# tab.indicator.stop (qcolor):
#     Color gradient end for the tab indicator.
#     Default: #00aa00
#
# tab.indicator.error (qcolor):
#     Color for the tab indicator on errors..
#     Default: #ff0000
#
# tab.indicator.system:
#     Color gradient interpolation system for the tab indicator.
#         rgb: Interpolate in the RGB color system.
#         hsv: Interpolate in the HSV color system.
#         hsl: Interpolate in the HSL color system.
#     Default: rgb
#
# tab.seperator (qss-color):
#     Color for the tab seperator.
#     Default: #555555
#
# hints.fg (css-color):
#     Font color for hints.
#     Default: black
#
# hints.fg.match (css-color):
#     Font color for the matched part of hints.
#     Default: green
#
# hints.bg (css-color):
#     Background color for hints.
#     Default: -webkit-gradient(linear, left top, left bottom,
#     color-stop(0%,#FFF785), color-stop(100%,#FFC542))
#
# downloads.fg (qcolor):
#     Foreground color for downloads.
#     Default: #ffffff
#
# downloads.bg.bar (qss-color):
#     Background color for the download bar.
#     Default: black
#
# downloads.bg.start (qcolor):
#     Color gradient start for downloads.
#     Default: #0000aa
#
# downloads.bg.stop (qcolor):
#     Color gradient end for downloads.
#     Default: #00aa00
#
# downloads.bg.system:
#     Color gradient interpolation system for downloads.
#         rgb: Interpolate in the RGB color system.
#         hsv: Interpolate in the HSV color system.
#         hsl: Interpolate in the HSL color system.
#     Default: rgb
#
# downloads.bg.error (qcolor):
#     Background color for downloads with errors.
#     Default: red

completion.fg = white
completion.bg = #333333
completion.item.bg = ${completion.bg}
completion.category.fg = white
completion.category.bg = qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #888888, stop:1 #505050)
completion.category.border.top = black
completion.category.border.bottom = ${completion.category.border.top}
completion.item.selected.fg = black
completion.item.selected.bg = #e8c000
completion.item.selected.border.top = #bbbb00
completion.item.selected.border.bottom = ${completion.item.selected.border.top}
completion.match.fg = #ff4444
statusbar.bg = black
statusbar.fg = white
statusbar.bg.error = red
statusbar.bg.prompt = darkblue
statusbar.bg.insert = darkgreen
statusbar.progress.bg = white
statusbar.url.fg = ${statusbar.fg}
statusbar.url.fg.success = lime
statusbar.url.fg.error = orange
statusbar.url.fg.warn = yellow
statusbar.url.fg.hover = aqua
tab.fg.odd = white
tab.fg.even = white
tab.fg.selected = white
tab.bg.odd = grey
tab.bg.even = darkgrey
tab.bg.selected = black
tab.bg.bar = #555555
tab.indicator.start = #0000aa
tab.indicator.stop = #00aa00
tab.indicator.error = #ff0000
tab.indicator.system = rgb
tab.seperator = #555555
hints.fg = black
hints.fg.match = green
hints.bg = -webkit-gradient(linear, left top, left bottom, color-stop(0%,#FFF785), color-stop(100%,#FFC542))
downloads.fg = #ffffff
downloads.bg.bar = black
downloads.bg.start = #0000aa
downloads.bg.stop = #00aa00
downloads.bg.system = rgb
downloads.bg.error = red


[fonts]
# Fonts used for the UI, with optional style/weight/size.
#  * Style: `normal`/`italic`/`oblique`
#  * Weight: `normal`, `bold`, `100`..`900`
#  * Size: _number_ `px`/`pt`
#
# _monospace (font):
#     Default monospace fonts.
#     Default: Terminus, Monospace, "DejaVu Sans Mono", Monaco,
#     "Bitstream Vera Sans Mono", "Andale Mono", "Liberation Mono",
#     "Courier New", Courier, monospace, Fixed, Consolas, Terminal
#
# completion (font):
#     Font used in the completion widget.
#     Default: 8pt ${_monospace}
#
# tabbar (font):
#     Font used in the tabbar.
#     Default: 8pt ${_monospace}
#
# statusbar (font):
#     Font used in the statusbar.
#     Default: 8pt ${_monospace}
#
# downloads (font):
#     Font used for the downloadbar.
#     Default: 8pt ${_monospace}
#
# hints (font):
#     Font used for the hints.
#     Default: bold 12px Monospace
#
# debug-console (font):
#     Font used for the debugging console.
#     Default: 8pt ${_monospace}
#
# web-family-standard (string):
#     Font family for standard fonts.
#     Default:
#
# web-family-fixed (string):
#     Font family for fixed fonts.
#     Default:
#
# web-family-serif (string):
#     Font family for serif fonts.
#     Default:
#
# web-family-sans-serif (string):
#     Font family for sans-serif fonts.
#     Default:
#
# web-family-cursive (string):
#     Font family for cursive fonts.
#     Default:
#
# web-family-fantasy (string):
#     Font family for fantasy fonts.
#     Default:
#
# web-size-minimum (int):
#     The hard minimum font size.
#     Default:
#
# web-size-minimum-logical (int):
#     The minimum logical font size that is applied when zooming out.
#     Default:
#
# web-size-default (int):
#     The default font size for regular text.
#     Default:
#
# web-size-default-fixed (int):
#     The default font size for fixed-pitch text.
#     Default:

_monospace = "PragmataPro", Terminus, Monospace, "DejaVu Sans Mono", Monaco, "Bitstream Vera Sans Mono", "Andale Mono", "Liberation Mono", "Courier New", Courier, monospace, Fixed, Consolas, Terminal
completion = 10pt ${_monospace}
tabbar = 10pt ${_monospace}
statusbar = 10pt ${_monospace}
downloads = 10pt ${_monospace}
hints = bold 12px ${_monospace}
debug-console = 10pt ${_monospace}
web-family-standard = 
web-family-fixed = 
web-family-serif = 
web-family-sans-serif = 
web-family-cursive = 
web-family-fantasy = 
web-size-minimum = 
web-size-minimum-logical = 
web-size-default = 
web-size-default-fixed = 
