import SwiftUI
import Combine

class BitcoinViewModel: ObservableObject {
    @Published var usdPrice: String = ""
    @Published var gbpPrice: String = ""
    @Published var eurPrice: String = ""
    @Published var btcAmount: String = ""
    @Published var convertedAmount: String = ""
    @Published var selectedCurrency: CurrencyType = .usd
    
    enum CurrencyType: String, CaseIterable {
           case usd
           case gbp
           case eur
       }

    private var cancellables: Set<AnyCancellable> = []

    init() {
        fetchBitcoinPrices()
        startTimer()
    }
    


    func fetchBitcoinPrices() {
        guard let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: BitcoinPriceResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                // Handle completion if needed
            }, receiveValue: { [weak self] response in
                self?.usdPrice = response.bpi.usd.rate
                self?.gbpPrice = response.bpi.gbp.rate
                self?.eurPrice = response.bpi.eur.rate
            })
            .store(in: &cancellables)
    }

    func startTimer() {
        Timer.publish(every: 60, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                self?.fetchBitcoinPrices()
            }
            .store(in: &cancellables)
    }

    func calculateConvertedAmount() {
        guard let btcValue = Double(btcAmount), let rate = Double(usdPrice) else {
            convertedAmount = ""
            return
        }

        let convertedValue = rate * btcValue
        convertedAmount = String(format: "%.2f", convertedValue)
    }



}



