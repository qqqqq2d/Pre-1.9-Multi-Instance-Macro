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

global Delay := 90 ; The amount of delay between each mouse/key press
global SaveAndQuitDelay := 150 ; The amount of time between the macro pressing "Escape" and it pressing "SaveAndQuit". If you are experiencing crashes, Increase this number
global liveSplitStart := "F7" ; The key that starts your LiveSplit timer, Preferably use a function key
global liveSplitReset := "F8" ; The key that resets your LiveSplit timer, Preferably use a function key
global instanceCount := 4 ; The amount of instances you are using


SetMouseDelay, -1
SetKeyDelay, -1

SaveAndQuit()
{
      Send {Escape}
      Sleep SaveAndQuitDelay
      Send {Tab}
      Sleep 100
      Send {Enter}
}

SaveAndQuit2()
{

}


CreateWorld() 
{
      Send {Tab}
      Send {Enter}
      Sleep 100
      Send {Tab}
      Send {Tab}
      Send {Tab}
      Send {Enter}
      Sleep 100
      Send {Tab}
      Send {Enter}

      
      
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