//
//  ContentView.swift
//  AdvancedSwiftUILab
//
//  Created by Miles Norris on 5/15/26.
//

import SwiftUI

enum ViewStates {
    case idle
    case loading
    case loginSuccess(String)
    case loginFail(String)
}

struct ContentView: View {
    @State var username: String = ""
    @State var password: String = ""
    
    @State var isPasswordHidden = true
    @State var isSubmittable = false
    
    @State var viewState: ViewStates = .idle
    var body: some View {
        switch viewState {
        case .idle:
            VStack(spacing: 15) {
                
               Spacer()
                
               Text("Login")
                    .bold()
                    .font(.largeTitle)
                    .padding(8)
                
                TextField("Username", text: $username)
                    .loginTextFieldStyle
            
                passwordField()
                    
                LoginButton(isSubmittable: isSubmittable, viewState: $viewState)
                
                Spacer()

            }
            .padding()
            .padding(.bottom, 150)
            .onChange(of: username) {
                checkUserAndPassword()
            }
            .onChange(of: password) {
                checkUserAndPassword()
            }
        case .loading:
            ProgressView()
            Text("Loading...")
        case .loginSuccess(let string):
            Text(string)
                .foregroundStyle(.green)
        case .loginFail(let string):
            Text(string)
                .foregroundStyle(.red)
        }
    }
    
    struct LoginButton: View {
        let isSubmittable: Bool
        
        @Binding var viewState: ViewStates
        var body: some View {
            Button {
                viewState = .loading
                Task {
                    try await Task.sleep(nanoseconds: 3000000000)
                    switch Int.random(in: 1...2) {
                    case 1:
                        viewState = .loginSuccess("You Logged In!")
                    case 2:
                        viewState = .loginFail("Login Failed. Try Again")
                    default:
                        viewState = .idle
                    }
                }
            } label: {
                Text("Login")
            }
            .buttonStyle(LoginButtonStyle(isSubmittable: isSubmittable))
            .disabled(!isSubmittable)
        }
    }
    
    func checkUserAndPassword() {
        if !username.isEmpty && !password.isEmpty {
            isSubmittable = true
        } else {
            isSubmittable = false
        }
    }
    
    @ViewBuilder
    func passwordField() -> some View {
        if isPasswordHidden {
            HStack {
                SecureField("Password", text: $password)
                
                Button {
                    isPasswordHidden.toggle()
                } label: {
                    Image(systemName: isPasswordHidden ? "eye.slash" : "eye")
                        .foregroundStyle(.gray)
                }
            }
            .loginTextFieldStyle
        } else {
            HStack {
                TextField("Password", text: $password)
                    .textContentType(.password)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                
                Button {
                    isPasswordHidden.toggle()
                } label: {
                    Image(systemName: isPasswordHidden ? "eye.slash" : "eye")
                        .foregroundStyle(.gray)
                }
            }
            .loginTextFieldStyle
        }
    }
}

#Preview {
    ContentView()
}
