//
//  ContentView.swift
//  ButtonsPractice
//
//  Created by Miles Norris on 2/23/26.
//

import SwiftUI

struct ContentView: View {
    @State var button1disabled = false
    @State var circleColor: Color = .cyan
    @State var isBirdBlack = false
    @State var button5Position: CGFloat = 50
    @State var button6Color = Color.blue
    @State var randomBase = 1
    @State var randomMultiplier = 2
    @State var total = 2
    
    var body: some View {
        VStack {
            Image(systemName: isBirdBlack ? "bird.fill" : "bird")
                .font(.system(size: 100))
            Button {
                
            } label: {
                Text("Button 1")
                    .frame(maxWidth: .infinity)
                
            }
            .foregroundStyle(Color.white)
            .padding(.vertical, 8)
            .disabled(button1disabled)
            .background(
                Capsule()
                    .foregroundStyle(button1disabled ? Color.gray : Color.teal)
            )
            Button {
                button1disabled.toggle()
            } label: {
                Circle()
                    .foregroundStyle(Color.blue)
                    .frame(width: 80, height: 80)
                    .overlay {
                        Text("Disable Button 1")
                            .foregroundStyle(Color.white)
                    }
            }
            Button {
                
            } label: {
                Text("Does Nothing")
            }
            .buttonStyle(MyButtonModifier())
            Button {
                isBirdBlack.toggle()
            } label: {
                Image(systemName: "bird.fill")
            }
            .buttonStyle(MyButtonModifier())
            Button {
                button5Position = CGFloat(Int.random(in: 50...350))
            } label: {
                Capsule()
                    .foregroundStyle(Color.green)
                    .frame(width: 90, height: 50)
            }
            .padding()
            .position(x: button5Position, y: 35)
            Button {
                button6Color = getRandomColor()
            } label: {
                Text("Random Color")
                    .foregroundStyle(Color.black)
                    .background {
                        Rectangle()
                            .frame(width: 250, height: 50)
                            .foregroundStyle(button6Color)
                    }
            }
            .buttonStyle(.plain)
            .padding(20)
            Button {
                randomBase = Int.random(in: 1...1000)
                randomMultiplier = Int.random(in: 1...1000)
                total = randomBase * randomMultiplier
            } label: {
                Capsule()
                    .frame(maxWidth: .infinity, maxHeight: 150)
                    .foregroundStyle(Color.orange)
                    .overlay {
                        Text("\(randomBase) * \(randomMultiplier) = \(total)")
                    }
            }
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "playstation.logo")
                        .font(.system(size: 50))
                }
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "xbox.logo")
                        .font(.system(size: 50))
                        .foregroundStyle(Color.green)
                }
                Spacer()
            }
            Button {
                fatalError()
            } label: {
                Text("⚠️‼️ DO NOT PRESS!! ‼️⚠️")
                    .foregroundStyle(Color.red)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .frame(width: 300, height: 50)
                            .foregroundStyle(Color.white)
                            .border(Color.red, width: 5)
                    }
                    .frame(width: 300, height: 50)
            }


        }
    }
    func getRandomColor() -> Color {
        switch Int.random(in: 1...10) {
        case 1:
           return Color.blue
        case 2:
            return Color.green
        case 3:
            return Color.orange
        case 4:
            return Color.yellow
        case 5:
            return Color.gray
        case 6:
            return Color.brown
        case 7:
            return Color.cyan
        case 8:
            return Color.indigo
        case 9:
            return Color.pink
        case 10:
            return Color.purple
        default:
            return Color.white
        }
    }
}

#Preview {
    ContentView()
}
