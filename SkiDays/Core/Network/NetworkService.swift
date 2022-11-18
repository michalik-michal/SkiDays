import Foundation
import Network

class NetworkService: ObservableObject {

    @Published var isConnected = true
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Service")

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied ? true : false
            }
        }
        monitor.start(queue: queue)
    }
}
