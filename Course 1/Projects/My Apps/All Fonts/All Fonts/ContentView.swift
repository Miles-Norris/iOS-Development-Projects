//
//  ContentView.swift
//  All Fonts
//
//  Created by Miles Norris on 2/4/26.
//

import SwiftUI

struct FontBrowserView: View {
    let fonts: [(family: String, names: [String])] = {
        UIFont.familyNames.sorted().map { family in
            (family, UIFont.fontNames(forFamilyName: family).sorted())
        }
    }()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(fonts, id: \.family) { family in
                    Section(header: Text(family.family)) {
                        ForEach(family.names, id: \.self) { name in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(name)
                                    .font(.system(size: 12))
                                    .foregroundColor(.secondary)
                                
                                Text("The quick brown fox jumps over the lazy dog 0123456789")
                                    .font(.custom(name, size: 20))
                            }
                            .padding(.vertical, 6)
                        }
                    }
                }
            }
            .navigationTitle("iOS Fonts")
        }
    }
}

#Preview {
    FontBrowserView()
}
