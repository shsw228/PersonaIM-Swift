//
//  ContentView.swift
//  Persona-IM-Swift
//
//  Created by shsw228 on 2024/09/13
//

import SwiftUI

enum Season {
    case Supring
    case Winter
    case None
}

struct ContentView: View {
    @State private var messages: [Message] = []
    @State private var season: Season = .None
    var body: some View {
        // Adjust for Android Layout
        ZStack {
            // Background
            Image(ImageResource.Res.bgSplatterBackground)
                .resizable()
                .frame(maxWidth: .infinity)
                .offset(x: 0, y: -16)
//            // TODO: BackgroundParticles
//            BackgroundParticles(season: season)

            transcript(entries: messages)

            seasonMenu(season: season)
        }
        .background(.red)
        .onAppear {
            messages = MessagesState().Messages
        }
    }
}

extension ContentView {
    @ViewBuilder
    private func BackgroundParticles(season: Season) -> some View {
        if season == .None {
            EmptyView()
        } else {
            Text("season")
        }
    }

    @ViewBuilder
    private func seasonMenu(season _: Season) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Image(ImageResource.Res.logoIm)
                    .resizable()
                    .scaledToFit()
                    .offset(x: 8, y: -4)
                // dp can't convert to pt. But ignore for ease.
                Spacer()
            }
            .frame(height: 80)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    private func transcript(entries: [Message]) -> some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(entries, id: \.self) { mes in
                    chat(message: mes)
                }
            }
        }
        .contentMargins(.top, 80, for: .scrollContent)
        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
    }

    @ViewBuilder
    private func entry(message: Message) -> some View {
        let window = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let screenSize = window?.screen.bounds
        HStack(alignment: .center, spacing: 0) {
            chatIcon(sender: message.sender)
            Text(message.text)
                .lineLimit(nil)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(maxWidth: (screenSize?.width ?? 0) * 0.7)
                .padding(EdgeInsets(top: 20, leading: 42, bottom: 20, trailing: 32))
                .background {
                    Inner()
                        .fill(Color.white)
                    Outer()
                        .fill(Color.black)
                }
        }
    }

    @ViewBuilder
    private func reply(message: Message) -> some View {
        let window = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let screenSize = window?.screen.bounds
        HStack {
            Spacer()

            Text(message.text)
                .lineLimit(nil)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(.black)
                .frame(maxWidth: (screenSize?.width ?? 0) * 0.7)
                .padding(EdgeInsets(top: 20, leading: 40, bottom: 20, trailing: 40))
                .background {
                    ReplyOuterBox()
                        .fill(Color.black)
                    ReplyInnerBox()
                        .fill(Color.white)
                }
                .fixedSize(horizontal: true, vertical: false)
        }
    }

    @ViewBuilder
    private func chat(message: Message) -> some View {
        if message.sender == .Ren {
            reply(message: message)
        } else {
            entry(message: message)
                .border(.mint)
        }
    }
}

@ViewBuilder
private func chatIcon(sender: Sender) -> some View {
    let size = CGSize(width: 110, height: 90)
    // Compose: .size(TranscriptSizes.AvatarSize)

    ZStack(alignment: .topTrailing) {
        Canvas { context, _ in
            context.fill(AvaterBlackBox().path(in: CGRect(x: size.width / 2, y: size.height / 2, width: size.width, height: size.height)), with: .color(.black))
            context.fill(AvaterWhiteBox().path(in: CGRect(x: size.width / 2, y: size.height / 2, width: size.width, height: size.height)), with: .color(.white))
            context.fill(AvaterColoredBox().path(in: CGRect(x: size.width / 2, y: size.height / 2, width: size.width, height: size.height)), with: .color(sender.color()))
        }

        HStack(alignment: .top, spacing: 0) {
            Spacer()
            VStack(alignment: .trailing, spacing: 0) {
                Image(sender.image()!)
                    .resizable()
                    .border(.green)
                    .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 8))
                    .frame(width: 80, height: 80)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipShape(AvaterClipBox())
        .border(.blue)

    }.frame(width: size.width, height: size.height)
}

struct Inner: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 31.7, y: 3.1))
        path.addLine(to: CGPoint(x: rect.width, y: 0.0))
        path.addLine(to: CGPoint(x: rect.width - 23, y: rect.height))
        path.addLine(to: CGPoint(x: 14.5, y: rect.height - 8))
        path.closeSubpath()
        return path
    }
}

struct Outer: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 33, y: 7.7))
        path.addLine(to: CGPoint(x: rect.width - 13, y: 3.7))
        path.addLine(to: CGPoint(x: rect.width - 25.7, y: rect.height - 4.6))
        path.addLine(to: CGPoint(x: 20.4, y: rect.height - 12))
        path.closeSubpath()
        return path
    }
}

struct AvaterBlackBox: Shape {
    func path(in _: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 17))
        path.addLine(to: CGPoint(x: 100.5, y: 27.2))
        path.addLine(to: CGPoint(x: 110, y: 72.7))
        path.addLine(to: CGPoint(x: 33.4, y: 90))
        path.closeSubpath()
        return path
    }
}

struct AvaterWhiteBox: Shape {
    func path(in _: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 16.4, y: 20.5))
        path.addLine(to: CGPoint(x: 96.7, y: 30.4))
        path.addLine(to: CGPoint(x: 106.4, y: 70))
        path.addLine(to: CGPoint(x: 37.8, y: 80.4))

        path.closeSubpath()
        return path
    }
}

struct AvaterColoredBox: Shape {
    func path(in _: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 22.5, y: 28))
        path.addLine(to: CGPoint(x: 94.4, y: 31.4))
        path.addLine(to: CGPoint(x: 104.3, y: 67.5))
        path.addLine(to: CGPoint(x: 40, y: 76.6))
        path.closeSubpath()
        return path
    }
}

struct AvaterClipBox: Shape {
    func path(in _: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 10.3, y: -5.6))
        path.addLine(to: CGPoint(x: 114.7, y: -5.6))
        path.addLine(to: CGPoint(x: 114.7, y: 65.6))
        path.addLine(to: CGPoint(x: 40, y: 76.6))
        path.closeSubpath()

        return path
    }
}

struct ReplyOuterBox: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // スタートポイント (0, 0)
        path.move(to: CGPoint(x: 0, y: 0))

        // Line to (rect.width - 35.dp.toPx(), 4.dp.toPx())
        path.addLine(to: CGPoint(x: rect.width - 35, y: 4))

        // Line to (rect.width - 10.7.dp.toPx(), rect.height - 6.6.dp.toPx())
        path.addLine(to: CGPoint(x: rect.width - 10.7, y: rect.height - 6.6))

        // Line to (35.5.dp.toPx(), rect.height)
        path.addLine(to: CGPoint(x: 35.5, y: rect.height))

        // Close the path
        path.closeSubpath()

        return path
    }
}

struct ReplyInnerBox: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 12, y: 5))
        path.addLine(to: CGPoint(x: rect.width - 36, y: 9.5))
        path.addLine(to: CGPoint(x: rect.width - 16.4, y: rect.height - 11.7))
        path.addLine(to: CGPoint(x: 36.5, y: rect.height - 3.5))
        path.closeSubpath()

        return path
    }
}

#Preview {
    ContentView()
}

#Preview("avater", traits: .sizeThatFitsLayout) {
    Image(Sender.Ann.image()!)
        .resizable()
        .scaledToFit()
        .frame(height: 100)
        .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 0))
        .scaleEffect(0.75)
        .clipShape(AvaterClipBox())
        .background {
            ZStack {
                AvaterBlackBox()
                    .fill(.black)
                AvaterWhiteBox()
                    .fill(.white)
                AvaterColoredBox()
                    .fill(.pink)
            }
            .padding(EdgeInsets(top: 0.5, leading: 1.15, bottom: 20, trailing: 1.15))
        }

        .border(.red)
}

#Preview("icon", traits: .sizeThatFitsLayout) {
    chatIcon(sender: Sender.Ann)
}
