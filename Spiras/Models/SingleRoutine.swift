//
//  SingleRoutine.swift
//  Spiras
//
//  Created by Fernando Jose Del Campo Guerola on 12/25/20.
//

import Foundation

struct SingleRoutine: Identifiable, Codable {
    let id: UUID
    var title: String
    var breatheIn: Int
    var holdIn: Int
    var breatheOut: Int
    var holdOut: Int
    var cycleLength: Int
    var numberOfCycles: Double
    var sessionLength: Int
    var vibrationOn: Bool
    var soundOn: Bool

    init(id: UUID = UUID(), title: String, breatheIn: Int, holdIn: Int, breatheOut: Int, holdOut: Int, cycleLength: Int, numberOfCycles: Double, sessionLength: Int, vibrationOn: Bool, soundOn: Bool) {
        self.id = id
        self.title = title
        self.breatheIn = breatheIn
        self.holdIn = holdIn
        self.breatheOut = breatheOut
        self.holdOut = holdOut
        self.cycleLength = cycleLength
        self.numberOfCycles = numberOfCycles
        self.sessionLength = sessionLength
        self.vibrationOn = vibrationOn
        self.soundOn = soundOn
    }
}

extension SingleRoutine {
    static var data: [SingleRoutine] {
        [
            SingleRoutine(title: "4-7-8 cycle", breatheIn: 4, holdIn: 7, breatheOut: 8, holdOut: 0, cycleLength: 19, numberOfCycles: 4.0, sessionLength: 76, vibrationOn: false, soundOn: false),
            SingleRoutine(title: "30 seconds cycle", breatheIn: 7, holdIn: 8, breatheOut: 8, holdOut: 7, cycleLength: 30, numberOfCycles: 4.0, sessionLength: 120, vibrationOn: false, soundOn: true),
            SingleRoutine(title: "45 seconds cycle", breatheIn: 7, holdIn: 12, breatheOut: 14, holdOut: 12, cycleLength: 45, numberOfCycles: 4.0, sessionLength: 180, vibrationOn: true, soundOn: true)
        ]
    }
}

extension SingleRoutine {
    struct Data {
        var title: String = "Untitled cycle"
        var breatheIn: Int = 4
        var holdIn: Int = 4
        var breatheOut: Int = 4
        var holdOut: Int = 4
        var cycleLength: Int = 16
        var numberOfCycles: Double = 4
        var sessionLength: Int = 64
        var vibrationOn: Bool = false
        var soundOn: Bool = false
    }

    var data: Data {
        return Data(title: title, breatheIn: breatheIn, holdIn: holdIn, breatheOut: breatheOut, holdOut: holdOut, cycleLength: cycleLength, numberOfCycles: numberOfCycles, sessionLength: sessionLength, vibrationOn: vibrationOn, soundOn: soundOn)
    }

    mutating func update(from data: Data) {
        title = data.title
        breatheIn = data.breatheIn
        holdIn = data.holdIn
        breatheOut = data.breatheOut
        holdOut = data.holdOut
        cycleLength = data.cycleLength
        numberOfCycles = data.numberOfCycles
        sessionLength = data.sessionLength
        vibrationOn = data.vibrationOn
        soundOn = data.soundOn
    }
}

