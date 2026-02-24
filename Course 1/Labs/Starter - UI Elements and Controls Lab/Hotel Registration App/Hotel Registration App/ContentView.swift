//
//  ContentView.swift
//  Hotel Registration App
//
//  Created by Jane Madsen on 9/26/25.
//

import SwiftUI

struct ContentView: View {
    @State var firstName: String
    @State var lastName: String
    @State var doorCode: String
    @State var numberOfGuests: Int
    @State var lengthOfStay: Int
    @State var nonSmoking: Bool
    @State var registrationFeedback: Double
    @State var isSubmitted: Bool = false
    @State var isFinished = false
    
    var body: some View {
        if isSubmitted {
           completionScreen(registrationFeedback: $registrationFeedback, isSubmitted: $isSubmitted)
        } else {
            HotelRegistrationScreen(firstName: $firstName, lastName: $lastName, doorCode: $doorCode, numberOfGuests: $numberOfGuests, lengthOfStay: $lengthOfStay, nonSmoking: $nonSmoking, isSubmitted: $isSubmitted, isFinished: $isFinished)
        }
    }
}

struct completionScreen: View {
    @Binding var registrationFeedback: Double
    @Binding var isSubmitted: Bool
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            VStack(spacing: 20) {
                HStack {
                    Image("mountainlandLogo")
                        .resizable()
                        .frame(width: 75, height: 75)
                    Text("Mountainland Inn")
                        .font(.custom("Verdana", size: 25))
                        .bold()
                        .foregroundStyle(Color.background)
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(Color.black)
                }
                .padding(.top, 20)
                Spacer()
                Text("Thank You For Booking With Us!")
                    .font(.custom("Rockwell", size: 30))
                    .multilineTextAlignment(.center)
                Text("How would you rate your experience?")
                    .font(.custom("Rockwell", size: 18))
                Text("\(registrationFeedback.formatted(.number.precision(.fractionLength(0...1))))/5 ⭐️s")
                Slider(value: $registrationFeedback, in: 1...5, step: 1)
                    .tint(Color.highlight)
                Button {
                    isSubmitted = false
                } label: {
                    Text("Go Back")
                        .font(.custom("Rockwell", size: 20))
                        .foregroundStyle(Color.background)
                        .padding(.top, 5)
                        .background {
                            Capsule()
                                .frame(width: 110, height: 40)
                                .foregroundStyle(Color.highlight)
                        }
                        .padding(.top, 30)
                }
                Spacer()
                Spacer()
            }
            .padding()
        }
    }
}

struct HotelRegistrationScreen: View {
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var doorCode: String
    @Binding var numberOfGuests: Int
    @Binding var lengthOfStay: Int
    @Binding var nonSmoking: Bool
    @Binding var isSubmitted: Bool
    @Binding var isFinished: Bool
   
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            VStack(spacing: 30) {
                Spacer()
                HStack {
                    Image("mountainlandLogo")
                        .resizable()
                        .frame(width: 75, height: 75)
                    Text("Mountainland Inn")
                        .font(.custom("Verdana", size: 25))
                        .bold()
                        .foregroundStyle(Color.background)
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(Color.black)
                }
                Spacer()
                TextField("First Name", text: $firstName)
                    .onChange(of: firstName) {
                        if !firstName.isEmpty && !lastName.isEmpty && !doorCode.isEmpty {
                            isFinished = true
                        } else {
                            isFinished = false
                        }
                    }
                    .padding()
                    .font(.custom("Rockwell", size:15))
                    .foregroundStyle(Color.text)
                TextField("Last Name", text: $lastName)
                    .onChange(of: lastName) {
                        if !firstName.isEmpty && !lastName.isEmpty && !doorCode.isEmpty {
                            isFinished = true
                        } else {
                            isFinished = false
                        }
                    }
                    .padding()
                    .font(.custom("Rockwell", size:15))
                    .foregroundStyle(Color.text)
                SecureField("Door Code", text: $doorCode)
                    .onChange(of: doorCode) {
                        if !firstName.isEmpty && !lastName.isEmpty && !doorCode.isEmpty {
                            isFinished = true
                        } else {
                            isFinished = false
                        }
                    }
                    .padding()
                    .font(.custom("Rockwell", size: 15))
                    .foregroundStyle(Color.text)
                HStack {
                    Text("Number Of Guests")
                        .font(.custom("Rockwell", size: 15))
                        .padding()
                        .foregroundStyle(Color.text)
                    Picker("Number Of Guests", selection: $numberOfGuests) {
                        ForEach(1..<21) { number in
                            Text("\(number)")
                        }
                    }
                    .pickerStyle(.wheel)
                    Spacer()
                }
                Stepper("Length Of Stay: \(lengthOfStay)", value: $lengthOfStay, in: 1...Int.max)
                    .padding()
                    .font(.custom("Rockwell", size: 15))
                    .foregroundStyle(Color.text)
                Toggle("Non-Smoking", isOn: $nonSmoking)
                    .padding()
                    .font(.custom("Rockwell", size: 15))
                    .foregroundStyle(Color.text)
                    .tint(Color.highlight)
                Button {
                    isSubmitted = true
                } label: {
                    Text("Submit")
                        .font(.custom("Rockwell", size: 20))
                        .foregroundStyle(Color.background)
                        .padding(.top, 5)
                        .background {
                            Capsule()
                                .frame(width: 110, height: 40)
                                .foregroundStyle(Color.highlight)
                        }
                        .opacity(isFinished ? 1.0 : 0.5)
                }
                .disabled(!isFinished)
                Spacer()

            }
        }
    }
}

#Preview {
    ContentView(firstName: "", lastName: "", doorCode: "", numberOfGuests: 0, lengthOfStay: 1, nonSmoking: true, registrationFeedback: 0)
}
