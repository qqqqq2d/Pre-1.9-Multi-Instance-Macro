; 1.8 RSG Multi Instance Macro, Created by FinestPigeon. Coding help from: Peej, ScarRuns, Specnr, and Four.
; ***READ*** (common issues that need to be addressed)
; Sometimes a clogged saves folder can make it so the GUI seems "Too slow for the macro" If this happens, clear your saves folders
; You will most likley need to have 2 OBS' running to ensure verification. 1 OBS with Display Capture (For streams and main recordings), And a second with 4 Game Captures running on the same screen.
; An example of my OBS setups, Main OBS: https://imgur.com/a/55yuwxS | Verification OBS: https://imgur.com/a/rw5agz1
; An example of how i set up my verification OBS: https://youtu.be/Nmsanpob7C0
; If you use a custom texture pack, make sure the title screen's splash text color is default (Yellow). This is used in the macro to make sure you are in the title screen before creating the world
; If you have any other questions/concerns, message me on discord. FinestPigeon#8738

#SingleInstance, force

; Options:

global Delay := 70 ; The amount of delay between each mouse/key press
global SaveAndQuitDelay := 150 ; The amount of time between the macro pressing "Escape" and it pressing "SaveAndQuit". If you are experiencing crashes, Increase this number
global liveSplitStart := "F7" ; The key that starts your LiveSplit timer, Preferably use a function key
global liveSplitReset := "F8" ; The key that resets your LiveSplit timer, Preferably use a function key
global instanceCount := 4 ; The amount of instances you are using
global hardcore := "No" ; Change this to "Yes" if you play Hardcore mode
global guiScale := "Large" ; Available GUI scales "Auto" "Large" "Normal" "Small"

SetMouseDelay, -1
SetKeyDelay, -1

SaveAndQuit()
{
  if (guiScale = "Auto")
    {
      Send, {Escape}
      Sleep SaveAndQuitDelay
      MouseClick, Left, 960, 720 
    }
  else if (guiScale = "Large")
    {
      Send, {Escape}
      Sleep SaveAndQuitDelay
      MouseClick, Left, 960, 610
    }
  else if (guiScale = "Normal")
    {
      Send, {Escape}
      Sleep SaveAndQuitDelay
      MouseClick, Left, 960, 500
    }
  else if (guiScale = "Small")
    {
      Send, {Escape}
      Sleep SaveAndQuitDelay
      MouseClick, Left, 960, 385
    }
}

CreateWorld() 
{
  if (guiScale = "Auto" && hardcore = "Yes")
    {
      MouseClick, Left, 950, 500
      Sleep Delay
      MouseClick, Left, 1270, 910
      Sleep Delay
      MouseClick, Left, 970, 500
      Sleep Delay
      MouseClick, Left, 640, 1000
    }
  else if (guiScale = "Large" && hardcore = "Yes")
    {
      MouseClick, Left, 950, 450 
      Sleep Delay
      MouseClick, Left, 1200, 950
      Sleep Delay
      MouseClick, Left, 960, 380
      Sleep Delay
      MouseClick, Left, 720, 1030
    }
  else if (guiScale = "Normal" && hardcore = "Yes")
    {
      MouseClick, Left, 960, 390
      Sleep Delay
      MouseClick, Left, 1118, 1000
      Sleep Delay
      MouseClick, Left, 960, 250
      Sleep Delay
      MouseClick, Left, 800, 1045
    }
  else if (guiScale = "Small" && hardcore = "Yes")
    {
      MouseClick, Left, 960, 330
      Sleep Delay
      MouseClick, Left, 1040, 1040
      Sleep Delay
      MouseClick, Left, 960, 130
      Sleep Delay
      MouseClick, Left, 880, 1060
    }
  else if (guiScale = "Auto" && hardcore = "No")
    {
      MouseClick, Left, 950, 500
      Sleep Delay
      MouseClick, Left, 1270, 910
      Sleep Delay
      MouseClick, Left, 640, 1000
    }
  else if (guiScale = "Large" && hardcore = "No")
    {
      MouseClick, Left, 950, 450 
      Sleep Delay
      MouseClick, Left, 1200, 950
      Sleep Delay
      MouseClick, Left, 720, 1030
    }
  else if (guiScale = "Normal" && hardcore = "No")
    {
      MouseClick, Left, 960, 390
      Sleep Delay
      MouseClick, Left, 1118, 1000
      Sleep Delay
      MouseClick, Left, 800, 1045
    }
  else if (guiScale = "Small" && hardcore = "No")
    {
      MouseClick, Left, 960, 330
      Sleep Delay
      MouseClick, Left, 1040, 1040
      Sleep Delay
      MouseClick, Left, 880, 1060
    }
}

SaveAndQuit2()
{
  if (guiScale = "Auto")
    {
      MouseClick, Left, 960, 720
    }
  else if (guiScale = "Large")
    {
      MouseClick, Left, 960, 610
    }
  else if (guiScale = "Normal")
    {
      MouseClick, Left, 960, 500
    }
  else if (guiScale = "Small")
    {
      MouseMove, 960, 385
    }
}



F23:: ; The keybind for exiting a world, creating world, switching instances
  SendInput, {%liveSplitReset%}
  SaveAndQuit()
  loop,
  { 
  PixelSearch, Px, Py, 0, 0, 1920, 1080, 0xFFFF00, 0, Fast RGB
      if (!ErrorLevel)
         Break
  }
  CreateWorld()
  Sleep Delay
  WinActivateBottom, Minecraft
  SendInput, {%liveSplitStart%}
  Send, {Escape}
return



F10:: ; The keybind for resetting all instances (This is because of the 5 minute playtime rule for RSG)
  Send, {%liveSplitReset%}
  SaveAndQuit()
  loop,
  { 
  PixelSearch, Px, Py, 0, 0, 1920, 1080, 0xFFFF00, 0, Fast RGB
      if (!ErrorLevel)
         Break
  }
  CreateWorld()
  Sleep Delay
  WinActivateBottom, Minecraft
  Sleep Delay
Loop % InstanceCount - 1
  {
    SaveAndQuit2()
    loop,
    { 
    PixelSearch, Px, Py, 0, 0, 1920, 1080, 0xFFFF00, 0, Fast RGB
      if (!ErrorLevel)
         Break
    }
    Sleep 10
    CreateWorld()
    Sleep Delay
    WinActivateBottom, Minecraft
  } 
  Send, {%liveSplitStart%}
  Send, {Escape}