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
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var isPresented = false
    @State private var newRoutineData = SingleRoutine.Data()
    
    let saveAction: () -> Void
    
    var body: some View {
        List {
            ForEach(routines) { routine in
                NavigationLink(destination: RoutineView(routine: binding(for: routine)))
                {
                    RoutinesMenuCardView(routine: routine)
                }
                .listRowBackground(Color("background5"))
            }
//            .onDelete { indexSet in
//                indexSet.map { routines[$0] }.forEach { routine in
//                    routines.remove(atOffsets: routine)
//                }
//            }
        }
        .navigationTitle("Spiras Routines")
        .navigationBarItems(
            leading:
                Button(
                    action: {
                        isPresented = true
                        let newRoutine = SingleRoutine(title: newRoutineData.title, breatheIn: newRoutineData.breatheIn, holdIn: newRoutineData.holdIn, breatheOut: newRoutineData.breatheOut, holdOut: newRoutineData.holdOut, cycleLength: newRoutineData.cycleLength, numberOfCycles: newRoutineData.numberOfCycles, sessionLength: newRoutineData.sessionLength, vibrationOn: newRoutineData.vibrationOn, soundOn: newRoutineData.soundOn)
                        routines.append(newRoutine)
                        isPresented = false
                    },
                    label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }),
            trailing:
                EditButton()
        )
        
//        .sheet(isPresented: $isPresented) {
//            NavigationView {
//                EditView(routineData: $newRoutineData)
//                    .navigationBarItems(leading: Button("Dismiss") {
//                        isPresented = false
//                    }, trailing: Button("Add") {
//                        let newRoutine = SingleRoutine(title: newRoutineData.title, breatheIn: newRoutineData.breatheIn, holdIn: newRoutineData.holdIn, breatheOut: newRoutineData.breatheOut, holdOut: newRoutineData.holdOut, numberOfCycles: newRoutineData.numberOfCycles, vibrationOn: newRoutineData.vibrationOn, soundOn: newRoutineData.soundOn)
//                        routines.append(newRoutine)
//                        isPresented = false
//                    })
//            }
//        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
        .environment(\.colorScheme, .dark)
    }

    private func binding(for routine: SingleRoutine) -> Binding<SingleRoutine> {
        guard let routineIndex = routines.firstIndex(where: { $0.id == routine.id }) else {
            fatalError("Can't find routine in array")
        }
        return $routines[routineIndex]
    }
}
