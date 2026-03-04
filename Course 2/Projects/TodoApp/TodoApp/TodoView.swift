//
//  ContentView.swift
//  TodoApp
//
//  Created by Miles Norris on 3/4/26.
//

import SwiftUI

struct TodoView: View {
    @State var todoSections = TodoSection.dummySections
    
    var body: some View {
        VStack {
            HStack {
                Text("Todos")
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading, 25)
                Spacer()
            }
            
            List {
                ForEach($todoSections) { $section in
                    Section(section.sectionTitle) {
                        ForEach($section.todos) { $todo in
                            TodoRowView(todo: $todo)
                                .onTapGesture {
                                    withAnimation {
                                        todo.markedComplete.toggle()
                                    }
                                }
                        }
                    }
                }
            }
            .listStyle(.inset)
            
            Spacer()
        }
    }
}

#Preview {
    TodoView()
}
