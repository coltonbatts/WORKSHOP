// SCAVENGED FROM: rational-kunal/NeoBrutalism
// PURPOSE: Core neo-brutalist view modifier for ColorWizard UI elements
// LICENSE: MIT
//
// THE SIGNATURE EFFECT: Hard offset shadow + thick border + rounded corners
// This single modifier turns any SwiftUI view into a neo-brutalist element.
//
// USAGE:
//   Text("Hello").padding().background(.yellow).nbBox()
//   Text("Flat").padding().background(.white).nbBox(elevated: false)

import SwiftUI

// ─── Theme (Environment-based, customizable per-view-tree) ──────────

public struct NBTheme: Sendable {
    // Colors
    public var main: Color         // Primary accent (default: cornflower blue)
    public var bw: Color           // Neutral bg (white in light, dark in dark mode)
    public var background: Color   // App background
    public var blank: Color        // Always white
    public var border: Color       // Always black
    public var text: Color         // Primary text
    public var mainText: Color     // Text on main-colored backgrounds

    // Spacing (sm / default / xl)
    public var smpadding: CGFloat
    public var padding: CGFloat
    public var xlpadding: CGFloat
    public var smspacing: CGFloat
    public var spacing: CGFloat
    public var xlspacing: CGFloat
    public var size: CGFloat       // Unit size (16pt)

    // Border & Shadow
    public var borderWidth: CGFloat    // 2pt thick borders
    public var borderRadius: CGFloat   // 5pt rounded corners
    public var boxShadowX: CGFloat     // 4pt right offset
    public var boxShadowY: CGFloat     // 4pt down offset

    public static let `default` = NBTheme(
        main:         Color(red: 0.533, green: 0.667, blue: 0.933),  // Cornflower
        bw:           .white,
        background:   Color(red: 0.875, green: 0.898, blue: 0.949),  // Light lavender
        blank:        .white,
        border:       .black,
        text:         .black,
        mainText:     .black,
        smpadding:    8,  padding: 12, xlpadding: 24,
        smspacing:    8,  spacing: 12, xlspacing: 24,
        size:         16,
        borderWidth:  2,
        borderRadius: 5,
        boxShadowX:   4,
        boxShadowY:   4
    )
}

// Environment key
extension EnvironmentValues {
    @Entry var nbTheme: NBTheme = .default
}

public extension View {
    func nbTheme(_ theme: NBTheme) -> some View {
        environment(\.nbTheme, theme)
    }
}

// ─── The Core Modifier ──────────────────────────────────────────────

struct NBBoxModifier: ViewModifier {
    @Environment(\.nbTheme) var theme: NBTheme
    let elevated: Bool

    func body(content: Content) -> some View {
        content
            .cornerRadius(theme.borderRadius)
            .shadow(
                color: theme.border,
                radius: 0.0,                                    // NO BLUR — hard shadow
                x: elevated ? theme.boxShadowX : 0.0,
                y: elevated ? theme.boxShadowY : 0.0
            )
            .overlay(
                RoundedRectangle(cornerRadius: theme.borderRadius, style: .circular)
                    .stroke(theme.border, lineWidth: theme.borderWidth)
            )
    }
}

public extension View {
    /// Apply neo-brutalist box treatment: thick border + hard offset shadow
    func nbBox(elevated: Bool = true) -> some View {
        modifier(NBBoxModifier(elevated: elevated))
    }
}
