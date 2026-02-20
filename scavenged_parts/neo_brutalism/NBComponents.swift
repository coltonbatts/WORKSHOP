// SCAVENGED FROM: rational-kunal/NeoBrutalism
// PURPOSE: Complete neo-brutalist component kit for ColorWizard
// LICENSE: MIT
//
// INCLUDES: Button, Card, Input, Badge, Slider, Progress
// All components use .nbBox() for consistent border/shadow treatment.

import SwiftUI

// ─── BUTTON STYLE ───────────────────────────────────────────────────

public struct NBButtonStyle: ButtonStyle {
    public enum ButtonType { case `default`, neutral }
    public enum ShadowVariant { case `default`, noShadow, reverse }

    @Environment(\.nbTheme) private var theme
    let type: ButtonType
    let variant: ShadowVariant

    public func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        let elevated: Bool = {
            switch variant {
            case .default: return !isPressed         // Shadow lifts on press
            case .noShadow: return false
            case .reverse: return isPressed           // Shadow appears on press
            }
        }()

        configuration.label
            .padding(theme.padding)
            .foregroundStyle(type == .default ? theme.mainText : theme.text)
            .background(type == .default ? theme.main : theme.bw)
            .animation(.interactiveSpring(), value: isPressed)
            .nbBox(elevated: elevated)
    }
}

public extension ButtonStyle where Self == NBButtonStyle {
    static func neoBrutalism(
        type: NBButtonStyle.ButtonType = .default,
        variant: NBButtonStyle.ShadowVariant = .default
    ) -> NBButtonStyle {
        .init(type: type, variant: variant)
    }
}

// ─── CARD ───────────────────────────────────────────────────────────

public struct NBCard<Header: View, Main: View, Footer: View>: View {
    public enum CardType { case `default`, neutral }
    @Environment(\.nbTheme) var theme

    let type: CardType
    let header: Header?
    let main: Main
    let footer: Footer?

    public init(
        type: CardType = .default,
        @ViewBuilder header: () -> Header? = { EmptyView() },
        @ViewBuilder main: () -> Main,
        @ViewBuilder footer: () -> Footer? = { EmptyView() }
    ) {
        self.type = type
        self.header = header()
        self.main = main()
        self.footer = footer()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing) {
            header.bold()
            main
            footer
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(theme.xlpadding)
        .foregroundStyle(type == .default ? theme.mainText : theme.text)
        .background(type == .default ? theme.main : theme.bw)
        .nbBox()
    }
}

// ─── INPUT STYLE ────────────────────────────────────────────────────

public struct NBInputStyle: @preconcurrency TextFieldStyle {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.nbTheme) var theme

    @MainActor
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(theme.padding)
            .background(theme.bw)
            .nbBox(elevated: false)
            .opacity(isEnabled ? 1.0 : 0.5)
    }
}

public extension TextFieldStyle where Self == NBInputStyle {
    static var neoBrutalism: NBInputStyle { .init() }
}

// ─── BADGE ──────────────────────────────────────────────────────────

public struct NBBadge<Content: View>: View {
    public enum BadgeType { case `default`, neutral }
    @Environment(\.nbTheme) var theme

    private let type: BadgeType
    private let content: Content

    public init(type: BadgeType = .default, @ViewBuilder content: () -> Content) {
        self.type = type
        self.content = content()
    }

    public var body: some View {
        content
            .font(.caption)
            .foregroundStyle(type == .default ? theme.mainText : theme.text)
            .padding(.horizontal, theme.padding)
            .padding(.vertical, theme.smpadding / 2)
            .background(type == .default ? theme.main : theme.bw)
            .nbBox(elevated: false)
    }
}

// ─── SLIDER ─────────────────────────────────────────────────────────

public struct NBSlider: View {
    @Environment(\.nbTheme) var theme
    @Binding private var value: CGFloat  // 0...1

    public init(value: Binding<CGFloat>) { _value = value }

    public var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let fill = max(0, min(value, 1)) * w
            let thumbX = max(0, min(value, 1)) * w

            ZStack(alignment: .leading) {
                HStack(spacing: 0) {
                    Rectangle().fill(theme.main).frame(width: fill, height: theme.size)
                    Rectangle().fill(theme.bw).frame(height: theme.size)
                }
            }
            .frame(width: w, height: theme.size / 2)
            .nbBox(elevated: false)
            .overlay {
                Circle()
                    .fill(theme.blank)
                    .stroke(theme.border, lineWidth: theme.borderWidth)
                    .frame(width: theme.size, height: theme.size)
                    .position(x: thumbX, y: theme.size / 4)
                    .gesture(DragGesture().onChanged { drag in
                        let start = drag.startLocation.x / w
                        let delta = drag.translation.width / w
                        self.value = max(0, min(1, start + delta))
                    })
            }
            .frame(width: w, height: theme.size)
        }
        .frame(height: theme.size)
        .padding(theme.size / 2)
    }
}

// ─── PROGRESS BAR ───────────────────────────────────────────────────

public struct NBProgressViewStyle: ProgressViewStyle {
    @Environment(\.nbTheme) var theme

    public func makeBody(configuration: Configuration) -> some View {
        let frac = configuration.fractionCompleted ?? 0.0
        GeometryReader { geo in
            HStack(spacing: 0) {
                Rectangle().fill(theme.main)
                    .frame(width: frac * geo.size.width, height: theme.size)
                if frac > 0.001 && frac < 0.99 {
                    Divider()
                        .frame(width: theme.borderWidth, height: geo.size.height)
                        .background(Color.black)
                }
                Rectangle().fill(theme.bw).frame(height: theme.size)
            }
        }
        .frame(height: theme.size)
        .nbBox(elevated: false)
    }
}

public extension ProgressViewStyle where Self == NBProgressViewStyle {
    static var neoBrutalism: NBProgressViewStyle { .init() }
}
