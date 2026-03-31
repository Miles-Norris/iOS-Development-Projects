//
//  ContentView.swift
//  ErrorTesting
//
//  Created by Miles Norris on 3/23/26.
//

import SwiftUI

struct ContentView: View {
    
    @State var email = ""
    @State var password = ""
    @State var errorMessage: String?
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .bold()
            
            TextField("Email", text: $email)
            
            SecureField("Password", text: $password)
            
            if let errorMessage {
                Text(errorMessage)
                    .foregroundStyle(Color.red)
            }
            
            Button("Login") {
                do {
                    try validateEmail(email)
                    try lookUpUsernameAndPassword(email: email, password: password)
                } catch {
                    print(error)
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func lookUpUsernameAndPassword(email: String, password: String) throws {
        if !UserDatabase.users.contains(email) {
            throw ValidationError.userNotFound
        }
    }
    
    func validateEmail(_ email: String) throws {
        if !email.isValidEmail {
            throw ValidationError.invalidEmail
        }
    }
}

enum ValidationError: LocalizedError {
    case invalidEmail
    case userNotFound
    
    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return "Invalid email adddress."
        case .userNotFound:
            return "We are unable to locate that email address. Please try again."
        }
    }
}

extension String {
    var isValidEmail: Bool {
        false
    }
}

class UserDatabase {
    static let users: [String] = [""]
}

#Preview {
    ContentView()
}
