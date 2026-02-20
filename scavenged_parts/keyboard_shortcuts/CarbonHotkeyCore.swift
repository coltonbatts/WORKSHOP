// SCAVENGED FROM: sindresorhus/KeyboardShortcuts — CarbonKeyboardShortcuts.swift
// PURPOSE: Reference implementation of low-level Carbon API hotkey registration
// LICENSE: MIT
//
// This is the CORE ENGINE that makes global hotkeys work on macOS.
// KeyboardShortcuts wraps this — you don't need to touch Carbon directly.
// Kept here as reference for understanding the plumbing.
//
// KEY INSIGHT: macOS global hotkeys use the Carbon Event API (not Cocoa).
//   RegisterEventHotKey() → OS-level hotkey → callback fires even when app is in background
//
// THE FLOW:
//   1. InstallEventHandler() — sets up the Carbon event handler once
//   2. RegisterEventHotKey(keyCode, modifiers, id, ...) — registers each shortcut
//   3. OS fires kEventHotKeyPressed/kEventHotKeyReleased events
//   4. Handler resolves hotKeyId → stored closure → calls your code
//
// MENU TRACKING WORKAROUND:
//   NSMenu runs in a special run loop mode that blocks Carbon hotkey events.
//   Solution: When menu opens, switch to raw key event monitoring instead.
//   On macOS 14+, uses RunLoopLocalEventMonitor; older uses AddEventTypesToHandler.
//
// FOR COLORWIZARD:
//   You don't need to copy this file. Just use the KeyboardShortcuts SPM package.
//   This is here so you understand what's happening under the hood.

// Minimal registration example (if you ever need to go lower-level):
/*
import Carbon.HIToolbox

func registerGlobalHotkey(keyCode: UInt32, modifiers: UInt32) {
    var hotKeyRef: EventHotKeyRef?
    let hotKeyID = EventHotKeyID(signature: 0x434C5752, id: 1)  // "CLWR"

    RegisterEventHotKey(
        keyCode,
        modifiers,
        hotKeyID,
        GetEventDispatcherTarget(),
        0,
        &hotKeyRef
    )
}
*/
