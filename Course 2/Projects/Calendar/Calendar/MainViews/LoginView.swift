//
//  LoginView.swift
//  Calendar
//
//  Created by Miles Norris on 6/17/26.
//

import SwiftUI

struct LoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    
    @State var isPasswordHidden = true
    @State var isSubmittable = false
    
    @State var loginFailed = false
    @State var loginSuccess = false
    
    @State var currentUser: User?
    var body: some View {
        Group {
            if loginSuccess {
                if let currentUser {
                    CalendarTabView(currentDate: Date(), currentUser: currentUser)
                }
            } else {
                VStack(spacing: 16) {
                  

                    Text("Sign In")
                        .font(.largeTitle.weight(.semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 50)
                        .padding(.leading, 20)

                    TextField("Email or Username", text: $username)
                        .textContentType(.username)
                        .keyboardType(.emailAddress)
                        .loginTextFieldStyle
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)

                    passwordField()

                    LoginButton(isSubmittable: isSubmittable, username: username, password: password, loginFailed: $loginFailed, loginSuccess: $loginSuccess, currentUser: $currentUser)
                

                    if loginFailed {
                        Text("Username or Password Incorrect. Please Try Again.")
                            .foregroundStyle(.red)
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .transition(.opacity.combined(with: .move(edge: .top)))
                            .padding(.bottom, 25)
                    } else {
                        Text("")
                            .padding(.bottom, 25)
                    }
                }
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color(.secondarySystemBackground))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .strokeBorder(Color.black.opacity(0.06), lineWidth: 0.5)
                )
                .padding(.bottom, 100)
                .padding(.vertical, 500)
                .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 8)
                .padding(.horizontal)
                .onChange(of: username) {
                    checkUserAndPassword()
                }
                .onChange(of: password) {
                    checkUserAndPassword()
                }
                .animation(.snappy, value: loginFailed)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
        )
    }
    
    struct LoginButton: View {
        let isSubmittable: Bool
        let username: String
        let password: String
        
        @State var isLoading = false
        
        @Binding var loginFailed: Bool
        @Binding var loginSuccess: Bool
        
        @Binding var currentUser: User?
        var body: some View {
            Button {
                Task {
                    do {
                        isLoading = true
                        try await Task.sleep(nanoseconds: 1000000000)
                        currentUser = try await DataFetcher.shared.fetchData(LoginAPIRequest(body: LoginBody(email: username, password: password)))
                        loginSuccess = true
                        isLoading = false
                    } catch {
                        print(error.localizedDescription)
                        loginFailed = true
                        isLoading = false
                    }
                }
            } label: {
                HStack(spacing: 8) {
                    if isLoading {
                        ProgressView()
                    }
                    Text(isLoading ? "Signing In" : "Sign In")
                }
            }
            .buttonStyle(LoginButtonStyle(isSubmittable: isSubmittable))
            .foregroundStyle(isSubmittable ? .blue : .gray.opacity(0.4))
            .disabled(!isSubmittable || isLoading)
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
    LoginView()
}
