//
//  ToDoDetailView.swift
//  ToDoList
//
//  Created by Bekir Berke Yılmaz on 29.09.2023.
//

import SwiftUI

struct ToDoDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showingAlert = false
    let todo: ToDoItem
    var body: some View {
        VStack{
            Text(todo.userDescription)
            Button("Tamamlandı olarak işaretle"){
                todoUpdate()
            }
            .background(Color.blue)
            .foregroundStyle(Color.white)
            .clipShape(Capsule())
            .alert("Tamamlandı olarak işaretlendi",isPresented: $showingAlert){
                Button("Tamam"){}
            }
        }
    }
    func todoUpdate(){
        todo.isCompleted = true
        showingAlert = true
    }
}

#Preview {
    ToDoDetailView(todo: ToDoItem.sampleData )
}
