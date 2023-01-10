//
//  ContentView.swift
//  Ingo's Charts Playground
//
//  Created by Ingo Boehme on 09.01.23.
//

import Charts
import SwiftUI

// MARK: - ContentView

struct ContentView: View {
    var body: some View {
        VStack {
Chart {
    ForEach(0..<values.count, id: \.self) { index in
        BarMark(
            x: .value("x", index),
            y: .value("y", values[index].1))
    }
}
        }
        .padding()
    }

    
    var values: [(Int, Int)]  {
        (0...10).map { index in
            (index, Int.random(in: 1...49))
        }
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
