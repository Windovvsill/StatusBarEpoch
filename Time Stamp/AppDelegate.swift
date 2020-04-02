//
//  AppDelegate.swift
//  Time Stamp
//
//  Created by Steve on 2020-04-01.
//  Copyright © 2020 Steve. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    //strong reference to retain the status bar item object
    var statusItem: NSStatusItem?
    
    let popover = NSPopover()
    var eventMonitor: EventMonitor?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: -1)
        
        guard let button = statusItem?.button else {
            print("status bar item failed. Try removing some menu bar item.")
            NSApp.terminate(nil)
            return
        }
        
        button.image = NSImage(named: "MenuBarButton")
        button.title = String(format: "%.0f", (NSDate().timeIntervalSince1970 * 1000).rounded())
        button.target = self
        button.action = #selector(printQuote(_:))
        
        constructMenu()
        
        _ = Timer.scheduledTimer(timeInterval: 2.5,
        target: self,
        selector: #selector(printQuote(_:)),
        userInfo: nil,
        repeats: true)
        
        popover.contentViewController = TimeStampViewController.freshController()
        
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
          if let strongSelf = self, strongSelf.popover.isShown {
            strongSelf.closePopover(sender: event)
          }
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @objc func printQuote(_ sender: Any?) {
        statusItem?.button?.title = String(format: "%.0f", (NSDate().timeIntervalSince1970 * 1000).rounded())
        statusItem?.button?.font = NSFont.monospacedSystemFont(ofSize: 0, weight: .regular)
    }
    
    @objc func togglePopover(_ sender: Any?) {
      if popover.isShown {
        closePopover(sender: sender)
      } else {
        showPopover(sender: sender)
      }
    }

    func showPopover(sender: Any?) {
        if let button = statusItem?.button {
        popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
      }
        
      eventMonitor?.start()
    }

    func closePopover(sender: Any?) {
      popover.performClose(sender)
        
      eventMonitor?.stop()
    }
    
    func constructMenu() {
      let menu = NSMenu()

      menu.addItem(NSMenuItem(title: "To Date", action: #selector(AppDelegate.togglePopover(_:)), keyEquivalent: "D"))
      menu.addItem(NSMenuItem.separator())
      menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

        statusItem?.menu = menu
    }
}

