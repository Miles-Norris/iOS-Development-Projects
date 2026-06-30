//
//  ContentView.swift
//  AnimationsLab
//
//  Created by Miles Norris on 5/4/26.
//

import SwiftUI

struct ContentView: View {
    @Namespace private var animation

    @State var text1Showing = false
    @State var text2Showing = false
    @State var text3Showing = false
    @State var goTextShowing = false

    private var step: Int {
        if text3Showing { return 3 }
        if text2Showing { return 2 }
        if text1Showing { return 1 }
        return 0
    }

    var body: some View {
        VStack {
            HStack {
                Spacer()
                person(id: "left")
                Spacer()
                person(id: "center")
                Spacer()
                person(id: "right")
                Spacer()
            }
            .padding(.top, 16)

            Spacer()

            ZStack {
                if text3Showing { Text("3").font(.system(size: 60)).transition(.scale.combined(with: .opacity)) }
                if text2Showing { Text("2").font(.system(size: 60)).transition(.scale.combined(with: .opacity)) }
                if text1Showing { Text("1").font(.system(size: 60)).transition(.scale.combined(with: .opacity)) }
                if goTextShowing { Text("Go!").font(.system(size: 60)).transition(.scale.combined(with: .opacity)) }
            }

            Spacer()

            Button {
                if !goTextShowing {
                    withAnimation(.easeOut(duration: 1)) {
                        text3Showing = true
                    } completion: {
                        withAnimation(.easeOut(duration: 1)) {
                            text3Showing = false
                            text2Showing = true
                        } completion: {
                            withAnimation(.easeOut(duration: 1)) {
                                text2Showing = false
                                text1Showing = true
                            } completion: {
                                withAnimation(.easeInOut(duration: 1)) {
                                    text1Showing = false
                                    goTextShowing = true
                                }
                            }
                        }
                    }
                } else {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        text1Showing = false; text2Showing = false; text3Showing = false; goTextShowing = false
                    }
                }
            } label: {
                Text(goTextShowing ? "Stop Game" : "Start Game")
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .animation(.easeInOut(duration: 0.25), value: step)
        .animation(.spring(response: 0.35, dampingFraction: 0.7), value: goTextShowing)
    }

    private func person(id: String) -> some View {
        let upNudge: CGFloat = step > 0 ? 15 : 0
        let scale: CGFloat = step > 0 ? 1.5 : 1.0
        return Image(systemName: "person.fill")
            .font(.system(size: 44))
            .matchedGeometryEffect(id: id, in: animation)
            .offset(y: -upNudge)
            .scaleEffect(scale)
            .shadow(radius: step > 0 ? 3 : 0, y: 1)
            .animation(.easeInOut(duration: 0.25), value: step)
    }
}

#Preview {
    ContentView()
}
