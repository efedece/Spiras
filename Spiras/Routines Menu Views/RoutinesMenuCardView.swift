//
//  RoutineMenuCardView.swift
//  Spiras
//
//  Created by Fernando Jose Del Campo Guerola on 12/24/20.
//

import SwiftUI

struct RoutineMenuCardView_Previews: PreviewProvider {
    static var previews: some View {
        RoutinesMenuCardView(routine: .constant(SingleRoutine.data[0]), routineTitle: SingleRoutine.data[0].title, editMode: .constant(.inactive), saveAction: {})
            .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 100))
    }
}

struct RoutinesMenuCardView: View {
    @Binding var routine: SingleRoutine
    @State var routineTitle: String = ""
    @Binding var editMode: EditMode
    let saveAction: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            EditableText(routineTitle, isEditing: editMode.isEditing) { title in
                routine.title = title
                routineTitle = title
                editMode = .inactive
                saveAction()
            }
                .font(.system(size: Constants.largeFont))
            Spacer()
            HStack {
                VStack {
                    Text("\(routine.breatheIn)s")
                    Image(systemName: "sunrise.fill")
                }
                VStack {
                    Text("\(routine.holdIn)s")
                    Image(systemName: "sun.max.fill")
                }
                VStack {
                    Text("\(routine.breatheOut)s")
                    Image(systemName: "sunset")
                }
                VStack {
                    Text("\(routine.holdOut)s")
                    Image(systemName: "sun.max")
                }
                .padding(.trailing, Constants.mediumSpacing)
                VStack {
                    Text("\(Int(routine.numberOfCycles))x")
                    Image(systemName: "clock.arrow.circlepath")
                }
                Spacer()
                HStack {
                    Image(systemName: routine.vibrationOn ? "iphone.radiowaves.left.and.right" : "iphone.slash")
                    Image(systemName: routine.soundOn ? "speaker.wave.3.fill" : "speaker.slash.fill")
                }
                Spacer()
            }
            .imageScale(.medium)
            .font(.system(size: Constants.mediumFont))
            .environment(\.editMode, $editMode)
        }
        .padding()
//        .background(Color("1-Vivid Sky Blue"))
        .environment(\.colorScheme, .dark)        
    }
}

// MARK: - Editable Text
struct EditableText: View {
// Edit text and update in real time
    var text: String = ""
    var isEditing: Bool
    var onChanged: (String) -> Void

    init(_ text: String, isEditing: Bool, onChanged: @escaping (String) -> Void) {
        self.text = text
        self.isEditing = isEditing
        self.onChanged = onChanged
    }
    
    @State private var editableText: String = ""
            
    var body: some View {
        ZStack(alignment: .leading) {
            TextField(text, text: $editableText, onEditingChanged: { began in
                self.callOnChangedIfChanged()
            })
                .opacity(isEditing ? 1 : 0)
                .disabled(!isEditing)
            if !isEditing {
                Text(text)
                    .opacity(isEditing ? 0 : 1)
                    .onAppear {
                        // any time we move from editable to non-editable
                        // we want to report any changes that happened to the text
                        // while were editable
                        // (i.e. we never "abandon" changes)
                        self.callOnChangedIfChanged()
                }
            }
        }
        .onAppear { self.editableText = self.text }
    }
    
    func callOnChangedIfChanged() {
        if editableText != text {
            onChanged(editableText)
        }
    }
}
