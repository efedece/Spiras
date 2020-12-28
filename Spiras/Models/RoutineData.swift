//
//  RoutineData.swift
//  Spiras
//
//  Created by Fernando Jose Del Campo Guerola on 12/25/20.
//

import Foundation

class RoutineData: ObservableObject {
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("routines.data")
    }
    @Published var routines: [SingleRoutine] = []

    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                #if DEBUG
                DispatchQueue.main.async {
                    self?.routines = SingleRoutine.data
                }
                #endif
                return
            }
            guard let allRoutines = try? JSONDecoder().decode([SingleRoutine].self, from: data) else {
                fatalError("Can't decode saved routine data.")
            }
            DispatchQueue.main.async {
                self?.routines = allRoutines
            }
        }
    }
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let routines = self?.routines else { fatalError("Self out of scope") }
            guard let data = try? JSONEncoder().encode(routines) else { fatalError("Error encoding data") }
            do {
                let outfile = Self.fileURL
                try data.write(to: outfile)
            } catch {
                fatalError("Can't write to file")
            }
        }
    }
    
    func remove(_ routine: [SingleRoutine]) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            //guard let routines = self?.routines else { fatalError("Self out of scope") }
            //guard let data = try? JSONEncoder().encode(routines) else { fatalError("Error encoding data") }
            do {
                let outfile = Self.fileURL
                try FileManager.default.removeItem(at: outfile)
                //self.routines[routine] = nil
            } catch {
                fatalError("Can't remove file")
            }
        }
    }
}
