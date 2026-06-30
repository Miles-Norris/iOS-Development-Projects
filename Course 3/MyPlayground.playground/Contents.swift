//: A UIKit based Playground for presenting user interface
  
import SwiftUI
import PlaygroundSupport

struct MainView: View {
    @State var isShowing = false
    var body: some View {
        VStack {
            Spacer()
            if isShowing {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.blue)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .opacity.combined(with: .slide), removal: .scale.combined(with: .move(edge: .top))))
            }
            
            Spacer()
            
            Button {
                withAnimation {
                    isShowing.toggle()
                }
            } label: {
                Text(isShowing ? "Hide" : "Show")
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .frame(width: 500, height: 800)
    }
}

PlaygroundPage.current.setLiveView(MainView())
