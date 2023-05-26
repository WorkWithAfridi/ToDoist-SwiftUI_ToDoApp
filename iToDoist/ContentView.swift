//
//  ContentView.swift
//  iTodolist
//
//  Created by Khondakar Afridi on 24/5/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var newItemText = ""
    @Environment(\.managedObjectContext) var context
    @FetchRequest(fetchRequest: ToDoListItem.getAllTodoListItem()) var items : FetchedResults<ToDoListItem>
    
    var body: some View {
        NavigationView(content: {
            List(content: {
                Section(header: Text("New Item"), content: {
                    HStack(content: {
                        TextField("Enter new item...", text: $newItemText)
                        Button( action: {
                            if !newItemText.isEmpty{
                                let newItem = ToDoListItem(context: context)
                                newItem.name = newItemText
                                newItem.createdAt = Date()
                                
                                do{
                                    try context.save()
                                } catch{
                                    print(error)
                                }
                                
                                newItemText=""
                            }
                        }, label: {
                            Text("Save")
                        })
                    })
                })
                Section(header: Text("Todos"), content: {
                    ForEach(items, content: {
                        toDoListItem in
                        VStack(alignment: .leading){
                            Text(toDoListItem.name!).font(.headline)
                            Text("\(toDoListItem.createdAt!)")
                        }
                    }).onDelete(perform: {
                        indexSet in
                        guard let index = indexSet.first else{
                            return
                        }
                        let itemToDelete = items[index]
                        context.delete(itemToDelete)
                        do{
                          try context.save()
                        } catch{
                            print(error)
                        }
                    })
                })
            }).navigationTitle("iTodolist")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
