// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: AsyncCachedImageExampleView()) {
                    VStack(alignment: .leading) {
                        Text("AsyncCachedImage")
                            .font(.title2)
                        Text("Async image loader with cache, similar to AsyncImage but with pluggable cache")
                            .font(.footnote)
                    }
                }
            }
            .listStyle(.inset)
            .navigationTitle("Examples")
        }
    }
}

#Preview {
    ContentView()
}
