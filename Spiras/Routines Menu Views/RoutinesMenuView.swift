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
            RoutinesMenuView(routines: .constant(SingleRoutine.data), saveAction: {})
        }
    }
}

struct RoutinesMenuView: View {
    @Binding var routines: [SingleRoutine]
    @State private var editMode: EditMode = .inactive
    @State private var newRoutineData = SingleRoutine.Data()

    let saveAction: () -> Void
    
    var body: some View {
        List {
            ForEach(routines) { routine in
                NavigationLink(destination: RoutineView(routine: binding(for: routine)) { saveAction() })
                {
                    RoutinesMenuCardView(routine: binding(for: routine), routineTitle: routine.title, editMode: $editMode) { saveAction() }
                }
//                .foregroundColor(Color("3-Ultramarine Blue"))
//                .listRowBackground(Color("1-Vivid Sky Blue"))
            }
            .onDelete { indexSet in
                routines.remove(atOffsets: indexSet)
                saveAction()
            }
        }
        .navigationBarTitle("Spiras Routines",  displayMode: .inline)
        .navigationBarItems(
            leading:
                Button(
                    action: {
                        let newRoutine = SingleRoutine(title: newRoutineData.title, breatheIn: newRoutineData.breatheIn, holdIn: newRoutineData.holdIn, breatheOut: newRoutineData.breatheOut, holdOut: newRoutineData.holdOut, cycleLength: newRoutineData.cycleLength, numberOfCycles: newRoutineData.numberOfCycles, sessionLength: newRoutineData.sessionLength, vibrationOn: newRoutineData.vibrationOn, soundOn: newRoutineData.soundOn)
                        routines.append(newRoutine)
                        saveAction()
                    },
                    label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }),
            trailing:
                EditButton()
        )
        .environment(\.editMode, $editMode)
        .environment(\.colorScheme, .dark)
    }

    private func binding(for routine: SingleRoutine) -> Binding<SingleRoutine> {
        guard let routineIndex = routines.firstIndex(where: { $0.id == routine.id }) else {
            fatalError("Can't find routine in array")
        }
        return $routines[routineIndex]
    }
}
