import XMonad
import XMonad.Config.Gnome
import XMonad.ManageHook
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import System.Exit

-- mod1Mask = Left Alt
myModMask = mod1Mask

myTerminal = "terminator"
myNormalBorderColor = "#7c7c7c"
myFocusedBorderColor = "#7fff00"
myBorderWidth = 1

myWorkspaces = ["1:code", "2:web", "3", "4", "5:media"] ++ map show [6..9]

myManageHook = composeAll [
        className =? "sublime-text-2"   --> doShift "1:code",
        resource  =? "desktop_window"   --> doIgnore,
        resource  =? "kdesktop"         --> doIgnore
    ]

myDefaultConfig = gnomeConfig

main = do
    xmproc <- spawnPipe "~/.cabal/bin/xmobar ~/.xmonad/xmobar.hs"
    xmonad $ myDefaultConfig {
        borderWidth         = myBorderWidth,
        normalBorderColor   = myNormalBorderColor,
        focusedBorderColor  = myFocusedBorderColor,
        modMask             = myModMask,
        terminal            = myTerminal,
        workspaces          = myWorkspaces,

        manageHook          = myManageHook <+> manageDocks,
        layoutHook          = avoidStruts $ layoutHook myDefaultConfig,
        handleEventHook     = docksEventHook <+> handleEventHook myDefaultConfig
    }  `additionalKeys`
        [ ((myModMask .|. controlMask, xK_l), spawn "xscreensaver-command -lock"),
          ((myModMask, xK_p), spawn "dmenu_run")
        ]