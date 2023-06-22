//
//  ContentView.swift
//  TheTour
//
//  Created by Sam 77 on 2023-06-08.
//

import SwiftUI

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    @State private var isLoggedIn: Bool = false
    @State private var errorMessage: String = ""
    @State private var showActivityView: Bool = false // New state variable
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoggedIn {
                    // User is logged in, show the ActivityView directly
                    ActivityView(isLoggedIn: $isLoggedIn)
                } else {
                    VStack {
                        Text("Login to the app")
                            .font(.title)
                            .padding()
                        
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        HStack {
                            Button(action: {
                                rememberMe.toggle()
                            }) {
                                Image(systemName: rememberMe ? "checkmark.square" : "square")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                            
                            Text("Remember Me")
                        }
                        .padding()
                        
                        Button(action: loginButtonTapped) {
                            Text("Login")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        .padding()
                        
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
            }
            .navigationBarHidden(true) // Hide the navigation bar
        }
    }
    
    func loginButtonTapped() {
        // Perform validation
        if email.isEmpty {
            errorMessage = "Please enter your email address."
        } else if password.isEmpty {
            errorMessage = "Please enter your password."
        } else if !isValidEmail(email) {
            errorMessage = "Please enter a valid email address."
        } else if !isValidPassword(password) {
            errorMessage = "Please enter a valid password."
        } else {
            // Perform authentication
            if authenticateUser(email: email, password: password) {
                isLoggedIn = true
                
                if rememberMe {
                    saveLoginCredentials(email: email, password: password)
                }
                
                errorMessage = ""
                
                // Set showActivityView to true to trigger navigation to ActivityView
                showActivityView = true
            } else {
                errorMessage = "Invalid email or password. Please try again."
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        // Implement your email validation logic here
        // For example, you can use regular expressions or other validation techniques
        
        // Example:
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        // Implement your password validation logic here
        // For example, you can check for minimum length or specific character requirements
        
        // Example:
        let minPasswordLength = 6
        return password.count >= minPasswordLength
    }
    
    func authenticateUser(email: String, password: String) -> Bool {
        // Implement your authentication logic here
        // You can compare the entered email and password with the pre-defined user objects
        
        // Example:
        let user1 = User(email: "User1@example.com", password: "password1")
        let user2 = User(email: "User2@example.com", password: "password2")
        
        let validUsers = [user1, user2]
        
        return validUsers.contains { $0.email == email && $0.password == password }
    }
    
    func saveLoginCredentials(email: String, password: String) {
        UserDefaults.standard.set(email, forKey: "SavedEmail")
        UserDefaults.standard.set(password, forKey: "SavedPassword")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class User {
    let email: String
    let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

struct ActivityView: View {
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        if isLoggedIn {
            ActivityData()
        } else {
            Text("You are logged out.")
                .font(.title)
                .foregroundColor(.gray)
        }
    }
}
