//
//  ContentView.swift
//  FHNW-Charts
//
//  Created by Ingo Boehme on 09.01.23.
//

import SwiftUI

// MARK: - ChartView

struct ChartView: View {
    @StateObject var viewModel = ViewModel()

    @State private var latitudeDegree: Int = 47
    @State private var latitudeFragment: Int = 48
    @State private var longitudeDegree: Int = 8
    @State private var longitudeFragment: Int = 21

    var body: some View {
        VStack {
            HStack {
                Text(viewModel.city).font(.title)
                Spacer()
                Button {
                    reload()
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
                .padding()
                .background(Color(red: 0.53, green: 0.73, blue: 1.0))
                .clipShape(Circle())
                .shadow(radius: 3, x: 2, y: 1)

            }
            Divider()

            HStack {
                VStack {
                    Text("Latitude")
                    HStack(spacing: 0) {
                        SelectionView(selectedValue: $latitudeDegree, start: -89, end: 89, unitPositive: "°N", unitNegative: "°S")
                        SelectionView(selectedValue: $latitudeFragment, start: 0, end: 99)
                    }
                }
                Spacer()
                VStack {
                    Text("Longitude")
                    HStack(spacing: 0) {
                        SelectionView(selectedValue: $longitudeDegree, start: -179, end: 179, unitPositive: "°E", unitNegative: "°W")
                        SelectionView(selectedValue: $longitudeFragment, start: 0, end: 99)
                    }
                }
            }

            Divider()

            ScrollView {
                LazyVStack {
                    ForEach(viewModel.temperature) { temperature in
                        HStack {
                            Text(temperature.date.formatted())
                            Spacer()
                            Text(temperature.temperature.formatted())
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.reload(latitudeDegree: latitudeDegree, latitudeFragment: latitudeFragment, longitudeDegree: longitudeDegree, longitudeFragment: longitudeFragment)
        }
    }
    
    func reload() {
        viewModel.reload(latitudeDegree: latitudeDegree, latitudeFragment: latitudeFragment, longitudeDegree: longitudeDegree, longitudeFragment: longitudeFragment)
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}

// MARK: - SelectionView

struct SelectionView: View {
    @Binding var selectedValue: Int

    let start: Int
    let end: Int
    var unitPositive: String = ""
    var unitNegative: String = ""

    var body: some View {
        Picker("", selection: $selectedValue) {
            ForEach(start ... end, id: \.self) { value in
                Text("\(abs(value))\(value < 0 ? unitNegative : unitPositive)")
                    .tag(value)
            }
        }
    }
}

// MARK: - LatitudeSelection_Previews

struct LatitudeSelection_Previews: PreviewProvider {
    @State static var xxx: Int = 44
    static var previews: some View {
        SelectionView(selectedValue: $xxx, start: -100, end: 100)
    }
}
