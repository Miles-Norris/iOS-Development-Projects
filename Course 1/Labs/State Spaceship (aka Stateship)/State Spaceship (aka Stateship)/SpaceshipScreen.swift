//
//  SpaceshipScreen.swift
//  State Spaceship (aka Stateship)
//
//  Created by Jane Madsen on 9/29/25.
//

import SwiftUI

@Observable class ShipComputer {
    var availablePower = 10
    var heading = ""
}

struct SpaceshipScreen: View {
    @State var mainComputer = ShipComputer()
    var body: some View {
        Form {
            Section("Helm Station") {
                HelmStation(mainComputer: mainComputer)
            }
            
            Section("Weapons Station") {
                WeaponsStation()
            }
            
            Section("Shield Station") {
                ShieldStation()
            }
            
            Section("Engine Station") {
                EngineStation()
            }
            
            Text("Available Power: \(mainComputer.availablePower)")

        }
        .environment(mainComputer)
        .padding()
    }
}

struct HelmStation: View {
    @State var inChair: Bool = false
    @Bindable var mainComputer: ShipComputer
    var body: some View {
        HStack {
            CrewChair(crewMember: .dog, inChair: $inChair)
            
            TextField("Heading", text: $mainComputer.heading)
                .disabled(!inChair)
        }
    }
}

struct WeaponsStation: View {
    @State var inChair: Bool = false
    @Environment(ShipComputer.self) var mainComputer
    @State var weaponsPower = 0
    @State var isOn = false
    var body: some View {
        HStack {
            CrewChair(crewMember: .cat, inChair: $inChair)
            
            VStack {
                Toggle("Weapons Power: \(weaponsPower)", isOn: $isOn)
                            .disabled(!inChair)
                            .onChange(of: isOn) {
                                if isOn {
                                    mainComputer.availablePower -= 3
                                    weaponsPower += 3
                                } else {
                                    mainComputer.availablePower += 3
                                    weaponsPower -= 3
                                }
                                
                                if mainComputer.availablePower < 0 {
                                    isOn = false
                                }
                            }
                
                Button("Fire!") {
                    if weaponsPower > 0 {
                        print("PEW!")
                    }
                }
                .disabled(!isOn)
            }
        }
    }
}

struct ShieldStation: View {
    @State var inChair: Bool = false
    @Environment(ShipComputer.self) var mainComputer
    @State var shieldPower = 0
    var body: some View {
        HStack {
            CrewChair(crewMember: .lizard, inChair: $inChair)
            
            Stepper("Shield Power: \(shieldPower)", value: $shieldPower, in: 0...10)
                .onChange(of: shieldPower) { oldValue, newValue in
                    let difference = newValue - oldValue
                    
                    mainComputer.availablePower -= difference
                    
                    if mainComputer.availablePower < 0 || !inChair {
                        shieldPower = oldValue
                    }
                }
        }
    }
}

struct EngineStation: View {
    @State var inChair: Bool = false
    @Environment(ShipComputer.self) var mainComputer
    @State var enginePower = 0
    var body: some View {
        HStack {
            CrewChair(crewMember: .hare, inChair: $inChair)
            Stepper("Engine Power: \(enginePower)", value: $enginePower, in: 0...10)
                .onChange(of: enginePower) { oldValue, newValue in
                    let difference = newValue - oldValue
                    
                    mainComputer.availablePower -= difference
                    
                    if mainComputer.availablePower < 0 || !inChair {
                        enginePower = oldValue
                    }
                }

        }
    }
}

struct CrewChair: View {
    var crewMember: Crew
    @Binding var inChair: Bool
    
    var body: some View {
        Button {
            inChair.toggle()
        } label: {
            if inChair {
                crewMember.icon
            } else {
                Image(systemName: "person.slash")
            }
        }
        .padding(5)
        .background {
            Circle()
                .foregroundStyle(.gray)
        }
    }
}

enum Crew: String {
    case dog
    case cat
    case lizard
    case hare
    
    var icon: Image {
        switch self {
        case .dog:
            Image(systemName: "dog")
        case .cat:
            Image(systemName: "cat")
        case .lizard:
            Image(systemName: "lizard")
        case .hare:
            Image(systemName: "hare")
        }
    }
}

#Preview {
    SpaceshipScreen()
}
