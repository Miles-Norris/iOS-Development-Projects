//
//  ContentView.swift
//  Calculator
//
//  Created by Miles Norris on 1/28/26.
//

import SwiftUI

struct CalculatorView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Text("0")
                .font(.largeTitle)
                .bold()
                .padding()
            HStack {
                Button {
                   
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 115, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)

    
                        Text("^")
                            .padding(.top, 10)
                            .font(.title)
                            .foregroundStyle(Color(.black))
                    }
                }
                Button {
                   
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 115, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
    
                        Image(systemName: "squareroot")
                            .foregroundStyle(Color(.black))
                    }
                }
                Button {
                   
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 115, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
    
                        Image(systemName: "plus.forwardslash.minus")
                            .foregroundStyle(Color(.black))
                    }
                }
            }
            HStack {
                Button {
                   
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 84, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
    
                        Image(systemName: "delete.left")
                            .foregroundStyle(Color(.black))
                    }
                }
                Button {
                   
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 84, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
    
                        Image(systemName: "squareroot")
                            .foregroundStyle(Color(.black))
                    }
                }
                Button {
                   
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 84, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
    
                        Image(systemName: "plus.forwardslash.minus")
                            .foregroundStyle(Color(.black))
                    }
                }
                Button {
                   
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 84, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
    
                        Text("^")
                            .padding(.top, 10)
                            .font(.title)
                            .foregroundStyle(Color(.black))
                    }
                }
            }
        }
    }
}

#Preview {
    CalculatorView()
}
