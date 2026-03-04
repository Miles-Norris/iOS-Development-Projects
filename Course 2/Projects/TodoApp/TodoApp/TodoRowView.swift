//
//  TodoRowView.swift
//  TodoApp
//
//  Created by Miles Norris on 3/4/26.
//

import SwiftUI


struct TodoRowView: View {
    @Binding var todo: Todo
    
    var body: some View {
        HStack {
            
            Circle()
                .strokeBorder(.blue, lineWidth: 1)
                .background(Circle()
                    .fill(todo.markedComplete ? .blue : .clear)
                )
                .frame(width: 20, height: 20)
            
            Text(todo.title)
                .padding(.leading, 5)
            
            Spacer()
        }
        .padding()
        .frame(height: 40)
    }
}


#Preview(traits: .sizeThatFitsLayout) {
    @Previewable @State var todo = TodoSection.dummySections.first!.todos.first!
    TodoRowView(todo: $todo)
}
