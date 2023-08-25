//
//  ContentView.swift
//  App Test
//
//  Created by กุลนิษฐ์ สิงห์เชื้อ on 25/8/2566 BE.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = BitcoinViewModel()

    var body: some View {
        VStack {
            Text("Bitcoin Currency")
                .font(.system(size: 30).bold())
                .foregroundColor(.yellow)
                .padding(.bottom, 15)
            
            

            Text("USD: \(viewModel.usdPrice)")
                .font(.title)
                .padding(10)

            Text("GBP: \(viewModel.gbpPrice)")
                .font(.title)
                .padding(10)


            Text("EUR: \(viewModel.eurPrice)")
                .font(.title)
                .padding(10)


            TextField("Enter BTC amount", text: $viewModel.btcAmount)
                .keyboardType(.decimalPad)
                .onChange(of: viewModel.btcAmount) { _ in
                    viewModel.calculateConvertedAmount()
                }
                .padding(15)

            Text("Converted Amount \(viewModel.convertedAmount)")
                .font(.body)
                .padding(10)


            Button("Fetch Prices") {
                viewModel.fetchBitcoinPrices()
            }
            .padding(10)
            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.startTimer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

