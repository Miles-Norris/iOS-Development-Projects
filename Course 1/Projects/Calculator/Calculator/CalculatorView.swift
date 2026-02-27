//
//  ContentView.swift
//  Calculator
//
//  Created by Miles Norris on 1/28/26.
//

import SwiftUI

struct CalculatorView: View {
    
    //This is the view modal that holds all the methods and properties for the view.
    @State var viewModal = CalculatorViewModal()
    
    var body: some View {
        VStack {
            Spacer()
            //This HStack hold the main text of the calculator
            HStack {
                Spacer()
                Text(viewModal.currentOperationText)
                    .bold()
                    .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 75))
                    .padding(.horizontal, 25)
                    .lineLimit(1)
                    .truncationMode(.head)
                    .minimumScaleFactor(0.4)
            }
            
            //This is a grid of all the buttons on screen. each of them calls a function on CalculatorViewModal.
            LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()], spacing: 10) {
                Button {
                    viewModal.exponentButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("^")
                            .padding(.top, 9)
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 22))
                            .bold()
                            .foregroundStyle(Color(.black))
                    }
                }
                
                Button {
                    viewModal.sqrtButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("√")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                
                Button {
                    viewModal.openParenButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("(")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                
                Button {
                    viewModal.closeParenButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text(")")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                
                Button {
                    viewModal.memoryAddButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("M+")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 18))
                    }
                }
                
                Button {
                    viewModal.memorySubtractButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("M-")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 18))
                    }
                }
                
                Button {
                    viewModal.memoryRecallButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(viewModal.mrButtonColor)
                            .shadow(radius: 4)
                        
                        Text("MR")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 18))
                    }
                }
                
                Button {
                    viewModal.memoryClearButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("MC")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 18))
                    }
                }
                
                Button {
                    viewModal.backspaceButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Image(systemName: "delete.left")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 16))
                    }
                }
                
                Button {
                    viewModal.allClear()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("AC")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 18))
                    }
                }
                
                Button {
                    viewModal.percentageButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("%")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 22))
                    }
                }
                
                Button {
                    viewModal.divisionButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Image(systemName: "divide")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 18))
                    }
                }
                
                Button {
                    viewModal.positiveNumberButton("7")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("7")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                
                Button {
                    viewModal.positiveNumberButton("8")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("8")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                
                Button {
                    viewModal.positiveNumberButton("9")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("9")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                
                Button {
                    viewModal.mulitplicationButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Image(systemName: "multiply")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 18))
                    }
                }
                
                Button {
                    viewModal.positiveNumberButton("4")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("4")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                
                Button {
                    viewModal.positiveNumberButton("5")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("5")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                
                Button {
                    viewModal.positiveNumberButton("6")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("6")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                
                Button {
                    viewModal.subtractionButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Image(systemName: "minus")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 17))
                    }
                }
                
                Button {
                    viewModal.positiveNumberButton("1")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("1")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                
                Button {
                    viewModal.positiveNumberButton("2")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("2")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                
                Button {
                    viewModal.positiveNumberButton("3")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("3")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                
                Button {
                    viewModal.additionButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Image(systemName: "plus")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 17))
                    }
                }
                
                Button {
                    viewModal.signChangeButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Image(systemName: "plus.forwardslash.minus")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 18))
                    }
                }
                
                Button {
                    viewModal.zeroButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("0")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                
                Button {
                    viewModal.decimalButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text(".")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                
                Button {
                    viewModal.equalsButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81 , height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Image(systemName: "equal")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 18))
                    }
                }
            }
            .padding(.horizontal, 25)
        }
    }
}

#Preview {
    CalculatorView()
}
