//
//  ContentView.swift
//  LifecycleLab
//
//  Created by Miles Norris on 3/11/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @State var eventsText = "Events"
    var body: some View {
        NavigationStack {
            VStack {
                Text(eventsText)
                    .multilineTextAlignment(.center)
                    .onChange(of: scenePhase) {
                        switch scenePhase {
                        case .background:
                            eventsText += "\n App In Background"
                        case .inactive:
                            eventsText += "\n App Is Inactive"
                        case .active:
                            eventsText += "\n App Is Now Active"
                        @unknown default:
                            eventsText += "\n Something Concerning Has Happened"
                        }
                    }
            }
            .padding()
            NavigationLink(destination: NewView(eventsText: $eventsText)) {
                Text("Go to a new view")
            }
        }
    }
}

struct NewView: View {
    @Binding var eventsText: String
    var body: some View {
        Text(eventsText)
            .multilineTextAlignment(.center)
            .onAppear {
                eventsText += "\n A New View Has Appeared"
            }
            .onDisappear {
                eventsText += "\n The New View Has Disappeared"
            }
    }
}

#Preview {
    ContentView()
}
