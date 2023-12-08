//
//  LoginViewModel.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/16/23.
//

import Foundation
import Security

protocol LoginfromProtocol {
    var formIsVaild: Bool {get}
}


@MainActor
class LoginViewModel: ObservableObject {
    @Published var sessionUser: User?
    @Published var currentUser: User?
    
    init() {
        Task {
            await fetchUser()
        }
        sessionUser = currentUser
    }
    
    func signOut() {
        Task {
            do {
                let urlString: String = "http://localhost:8080/auth/logout"
                guard let url: URL = URL(string: urlString) else {
                    throw LoginViewModelError.invalidURL
                }
                
                var request: URLRequest = URLRequest(url: url);
                request.httpMethod = "POST"
                
                let ( _, response) = try await URLSession.shared.data(for: request);
                
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200
                else {
                    throw LoginViewModelError.invalidResponse
                }
                
                deleteItem(forkey: "username")
                deleteItem(forkey: self.currentUser!.username)
                
                self.currentUser = nil;
                self.sessionUser = nil;
                
            } catch {
                print("unknow error -> unexpected \(error.localizedDescription) (╯’ – ‘)╯︵")
            }
        }
    }
    
    func fetchUser() async {
        let urlString: String = "http://localhost:8080/auth/me"
        print(urlString);
        
        do {
            guard let url: URL = URL(string: urlString) else {
                throw LoginViewModelError.invalidURL
            }
            
            var request: URLRequest = URLRequest(url: url);
            request.httpMethod = "POST"
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode == 200
            else {
                throw LoginViewModelError.invalidResponse
            }
            
            do {
                print(data.description)
                let decodedObj = try JSONDecoder().decode(User.self, from: data);
                self.currentUser = decodedObj
                print()
            } catch {
                throw LoginViewModelError.invalidData;
            }
        } catch LoginViewModelError.invalidData {
            print("return data error (╯’ – ‘)╯︵")
        } catch LoginViewModelError.invalidResponse {
            print("invalidResponse error (╯’ – ‘)╯︵")
        } catch LoginViewModelError.invalidURL {
            print("url error (╯’ – ‘)╯︵")
        } catch {
            print("unknow error -> unexpected \(error.localizedDescription) (╯’ – ‘)╯︵")
        }
    }
}

// MARK: - Create User fetch
extension LoginViewModel {
    func createUser(username: String, password: String, fname: String, mname: String, lname: String) {
        Task {
            do {
                self.sessionUser = try await swiftxios.post(
                        "http://localhost:8080/auth/signup",
                        [
                            "username" : username,
                            "password" : password,
                            "first_name": fname,
                            "last_name": lname,
                            "middle_name": mname
                        ],
                        [
                            "application/json" : "Content-Type"
                        ]
                )
                
                self.currentUser = self.sessionUser
                
                await fetchUser()
                
                saveItem(forkey: "username", item: username)
                saveItem(forkey: username, item: password)
                
                // print(sessionUser ?? "null")
                // print(currentUser ?? "null")
                
            } catch Swiftxios.FetchError.invalidURL {
                print("function signIn from class Swiftxios has URL error (╯’ – ‘)╯︵")
            } catch Swiftxios.FetchError.invalidResponse {
                print("function signIn from class Swiftxios has HttpResponse error (╯’ – ‘)╯︵")
            } catch Swiftxios.FetchError.invalidData {
                print("function signIn from class Swiftxios has response Data error (╯’ – ‘)╯︵")
            } catch Swiftxios.FetchError.invalidObjectConvert {
                print("function signIn from class Swiftxios has Converting Data error (╯’ – ‘)╯︵")
            } catch {
                print("unknow error -> unexpected \(error.localizedDescription) (╯’ – ‘)╯︵")
            }
        }
    }
//    func createUser(username: String, password: String, fname: String, mname: String, lname: String) async throws {
//        do {
//            let endpointURL: String = "http://localhost:8080/auth/signup";
//            print(endpointURL);
//            guard let url: URL = URL(string: endpointURL) else {
//                throw LoginViewModelError.invalidURL;
//            };
//
//            let userRawData: [String: Any] = [
//                "username" : username,
//                "password" : password,
//                "first_name": fname,
//                "last_name": lname,
//                "middle_name": mname
//            ]
//
//            let userData = try? JSONSerialization.data(withJSONObject: userRawData)
//
//            var request: URLRequest = URLRequest(url: url);
//            request.httpMethod = "POST"
//            request.httpBody = userData
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//            let (data, response) = try await URLSession.shared.data(for: request)
//
//            print("fetch ok");
//
//            guard
//                let response = response as? HTTPURLResponse,
//                response.statusCode == 200
//            else {
//                throw LoginViewModelError.invalidResponse
//            }
//
//            do {
//                print(data.description)
//                var decodedObj = try JSONDecoder().decode(User.self, from: data);
//                decodedObj.setPassword(password: password)
//                print("decodedobj \(decodedObj)")
//                self.sessionUser = decodedObj
//                self.currentUser = decodedObj
//            } catch {
//                throw LoginViewModelError.invalidData;
//            }
//
//            print("createUser session -> \(URLSession.shared)")
//
//            await self.fetchUser()
//
//            saveItem(forkey: "username", item: username)
//            saveItem(forkey: username, item: password)
//
//        } catch LoginViewModelError.invalidData {
//            print("return data error (╯’ – ‘)╯︵")
//        } catch LoginViewModelError.invalidResponse {
//            print("invalidResponse error (╯’ – ‘)╯︵")
//        } catch LoginViewModelError.invalidURL {
//            print("url error (╯’ – ‘)╯︵")
//        } catch {
//            print("unknow error -> unexpected \(error.localizedDescription) (╯’ – ‘)╯︵")
//        }
//    }
}

// MARK: - SignIn fetch
extension LoginViewModel {
    func signIn(username: String, password: String) {
        Task {
            do {
                self.sessionUser = try await swiftxios.post(
                        "http://localhost:8080/auth/login",
                        [
                            "username" : username,
                            "password" : password,
                        ],
                        [
                            "application/json" : "Content-Type"
                        ]
                )
                await fetchUser()
                
                self.saveItem(forkey: "username", item: username)
                self.saveItem(forkey: username, item: password)
                
            } catch Swiftxios.FetchError.invalidURL {
                print("function signIn from class Swiftxios has URL error (╯’ – ‘)╯︵")
            } catch Swiftxios.FetchError.invalidResponse {
                print("function signIn from class Swiftxios has HttpResponse error (╯’ – ‘)╯︵")
            } catch Swiftxios.FetchError.invalidData {
                print("function signIn from class Swiftxios has response Data error (╯’ – ‘)╯︵")
            } catch Swiftxios.FetchError.invalidObjectConvert {
                print("function signIn from class Swiftxios has Converting Data error (╯’ – ‘)╯︵")
            } catch {
                print("unknow error -> unexpected \(error.localizedDescription) (╯’ – ‘)╯︵")
            }
        }
    }
    
//    private func signInFetch(username: String, password: String) async throws {
//        let endpointURL: String = "http://localhost:8080/auth/login";
//        guard let url: URL = URL(string: endpointURL) else {
//            throw LoginViewModelError.invalidURL;
//        };
//
//        let accountRawData: [String : Any] = [
//            "username" : username,
//            "password" : password,
//        ]
//
//        let userData = try? JSONSerialization.data(withJSONObject: accountRawData)
//
//        var request: URLRequest = URLRequest(url: url);
//        request.httpMethod = "POST"
//        request.httpBody = userData
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let (data, response) = try await URLSession.shared.data(for: request)
//
//        guard
//            let response = response as? HTTPURLResponse,
//            response.statusCode == 200
//        else {
//            throw LoginViewModelError.invalidResponse
//        }
//
//        do {
//            print(data.description)
//            var decodedObj = try JSONDecoder().decode(User.self, from: data);
//            decodedObj.setPassword(password: password)
//            print("decodedobj \(decodedObj)")
//            self.sessionUser = decodedObj
//        } catch {
//            throw LoginViewModelError.invalidData;
//        }
//
//        // print("ok")
//
//        await fetchUser()
//
//        saveItem(forkey: "username", item: username)
//        saveItem(forkey: username, item: password)
//    }
}

// MARK: - Data In SecKeychain
extension LoginViewModel {
    private func saveItem(forkey key: String, item: String) {
        // Set username and password
        let itemData = item.data(using: .utf8)!

        // Set attributes
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: itemData,
        ]

        // Add user
        if SecItemAdd(attributes as CFDictionary, nil) == noErr {
            print("Item saved successfully in the keychain with key (\(key)) (๑•̀ㅂ•́) ✧")
        } else {
            print("Something went wrong trying to save the Item for key (\(key)) in the keychain (╯’ – ‘)╯︵")
        }
        
    }
    
    private func deleteItem(forkey key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
        ]
        // Find key and delete
        if SecItemDelete(query as CFDictionary) == noErr {
            print("forkey (\(key)) removed successfully from the keychain (๑•̀ㅂ•́) ✧")
        } else {
            print("Something went wrong trying to remove the key (\(key)) from the keychain (╯’ – ‘)╯︵")
        }
    }
    
    func retrieveItem(forkey key: String) -> String? {
        // Set query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ]
        
        var item: CFTypeRef?

        // Check if user exists in the keychain
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            // Extract result
            if let existingItem = item as? [String: Any],
               let itemData = existingItem[kSecValueData as String] as? Data,
               let item = String(data: itemData, encoding: .utf8)
            {
                print("Item retrieve successfully in the keychain with key (\(key)) (๑•̀ㅂ•́) ✧")
                return item
            }
        } else {
            print("Something went wrong trying to find the key (\(key)) in the keychain (╯’ – ‘)╯︵")
        }
        return nil
    }
}

// MARK: - Customize Fetch error
extension LoginViewModel {
    enum LoginViewModelError: Error {
        case invalidURL, invalidResponse, invalidData
    }
}


