//
//  ContentView.swift
//  Persona-IM-Swift
//
//  Created by shsw228 on 2024/09/13
//

import SwiftUI

struct ContentView: View {
    @State private var messages: [Message] = []
    var body: some View {
        // Adjust for Android Layout
        GeometryReader { geo in
            ZStack {
                // Background
                Image(ImageResource.Res.bgSplatterBackground)
                    .resizable()
                    //                .safeAreaPadding(.top)
                    .frame(maxWidth: .infinity)
                ScrollView {
                    VStack(alignment: .center, spacing: 10) {
                        ForEach(messages, id: \.self) { mes in
                            chat(message: mes)
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                VStack {
                    Color(.gray).opacity(0.8)
                        .frame(width: geo.size.width, height: geo.safeAreaInsets.top)
                        .ignoresSafeArea()
                    Spacer()
                }
                VStack {
                    HStack {
                        Image(ImageResource.Res.logoIm)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .offset(x: 8, y: -4)
                        // dp can't convert to pt. But ignore for ease.
                        Spacer()
                    }
                    Spacer()
                }
            }
            .background(.red)
            .onAppear {
                messages = MessagesState().Messages
            }
        }
    }
}

extension ContentView {
    @ViewBuilder
    private func chat(message: Message) -> some View {
        let window = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let screenSize = window?.screen.bounds
        HStack(alignment: .center) {
            if message.sender == Sender.Ren {
                Spacer()
            }
            if let image = message.sender.image() {
                Image(image)
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
                        .padding(EdgeInsets(top: 0.5, leading: 1.15, bottom: 20, trailing: 0))
                    }
                    .border(.white)
            }
            Text(message.text)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                //                .border(.white)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(maxWidth: (screenSize?.width ?? 0) * 0.7)
                .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
                .background {
                    Inner()
                        .fill(Color.white)
                    Outer()
                        .fill(Color.black)
                }

            if message.sender != Sender.Ren {
                Spacer()
            }
        }
    }
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
