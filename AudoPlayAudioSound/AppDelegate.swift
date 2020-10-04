//
//  AppDelegate.swift
//  AudoPlayAudioSound
//
//  Created by Kagen Zhao on 2020/10/2.
//

import Cocoa
import SwiftUI
import ServiceManagement


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var popover: NSPopover!
    var statusBarItem: NSStatusItem!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let contentView = ContentView()

        let popover = NSPopover()
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: contentView)
        popover.contentSize = NSSize(width: 130, height: 100)
        self.popover = popover
        
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        
        if let button = self.statusBarItem.button {
            button.image = NSImage(named: "menuIcon")
            button.action = #selector(togglePopover(_:))
        }
        
        NSApp.activate(ignoringOtherApps: true)
    }
    
    @objc private func togglePopover(_ sender: Any?) {
        if let button = self.statusBarItem.button {
            if self.popover.isShown {
                self.popover.performClose(sender)
            } else {
                self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
}

