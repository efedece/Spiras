//
//  RoutinesMenuView.swift
//  Spiras
//
//  Created by Fernando Jose Del Campo Guerola on 12/25/20.
//

import SwiftUI

struct RoutinesMenuView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RoutinesMenuView(
                routines: .constant(SingleRoutine.data),
                saveAction: {}
            )
        }
    }
}

struct RoutinesMenuView: View {
    @Binding var routines: [SingleRoutine]
    @State private var editMode: EditMode = .inactive
    @State private var newRoutineData = SingleRoutine.Data()
    let saveAction: () -> Void
    
    var body: some View {
//        ScrollView { // FIXME: For future use, slicker UI list
//            VStack{
        List {
            ForEach(routines) { routine in
                // Create navigation link to each routine
                NavigationLink(destination: RoutineView(routine: binding(for: routine)) { saveAction() })
                {
                    // Build routine card
                    RoutinesMenuCardView(routine: binding(for: routine), routineTitle: routine.title, editMode: $editMode) { saveAction() }
                }
                .listRowBackground(Constants.backgroundColor)//Color.clear)
            }
            // Remove routine on edits
            .onDelete { indexSet in
                routines.remove(atOffsets: indexSet)
                saveAction()
            }
//        }
        }
         // Modify table appearance to clear predifined background
        .onAppear() {
            UITableView.appearance().separatorStyle = .none
            UITableView.appearance().backgroundColor = .clear
            UITableViewCell.appearance().backgroundColor = .clear
            UITableView.appearance().tableFooterView = UIView()
        }
        .navigationBarTitle("𝞭𝚽𝚪𝚫𝞭",  displayMode: .inline)
        // Add navigation bar items
        .navigationBarItems(
            // Add button on left
            leading: Button(
                action: {
                    let newRoutine = SingleRoutine(title: newRoutineData.title, breatheIn: newRoutineData.breatheIn, holdIn: newRoutineData.holdIn, breatheOut: newRoutineData.breatheOut, holdOut: newRoutineData.holdOut, cycleLength: newRoutineData.cycleLength, numberOfCycles: newRoutineData.numberOfCycles, sessionLength: newRoutineData.sessionLength, vibrationOn: newRoutineData.vibrationOn, soundOn: newRoutineData.soundOn)
                    routines.append(newRoutine)
                    saveAction()
                },
                label: {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .foregroundColor(.white)
                }),
            // Edit button on right
            trailing: EditButton().foregroundColor(.white) )
        .environment(\.editMode, $editMode)
        .background(Constants.backgroundColor)
            .edgesIgnoringSafeArea(.all)
    }

    // Function to bind single routines
    private func binding(for routine: SingleRoutine) -> Binding<SingleRoutine> {
        guard let routineIndex = routines.firstIndex(where: { $0.id == routine.id }) else {
            fatalError("Can't find routine in array")
        }
        return $routines[routineIndex]
    }
}
