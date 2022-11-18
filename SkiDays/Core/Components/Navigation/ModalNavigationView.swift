import SwiftUI

struct ModalNavigationView<Content>: View where Content: View {

    @Binding var showModal: Bool
    var title: String = ""
    let content: Content

    var body: some View {
        NavigationView {
            content
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            showModal = false
                        }, label: {
                            Image(systemName: "xmark")
                                .frame(width: 24, height: 24, alignment: .center)
                                .foregroundColor(Color.darkerBlue)
                        })
                    }
                })
                .navigationTitle(title)
        }
    }
}
