import XMonad
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
        resource  =? "desktop_window"   --> doIgnore,
        resource  =? "kdesktop"         --> doIgnore
    ]

main = do
    xmproc <- spawnPipe "~/.cabal/bin/xmobar ~/.xmonad/xmobar.hs"
    xmonad $ defaultConfig {
        borderWidth         = myBorderWidth,
        normalBorderColor   = myNormalBorderColor,
        focusedBorderColor  = myFocusedBorderColor,
        modMask             = myModMask,
        terminal            = myTerminal,
        workspaces          = myWorkspaces,

        manageHook          = myManageHook <+> manageDocks,
        layoutHook          = avoidStruts $ layoutHook defaultConfig,
        handleEventHook     = docksEventHook <+> handleEventHook defaultConfig
    }  `additionalKeys`
        [ ((myModMask .|. controlMask, xK_l), spawn "xscreensaver-command -lock")
        ]
